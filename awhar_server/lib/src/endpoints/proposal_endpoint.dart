import 'package:awhar_server/src/generated/protocol.dart';
import 'package:awhar_server/src/services/notification_service.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for managing driver proposals/bids
class ProposalEndpoint extends Endpoint {
  /// Driver submits a proposal for a service request
  /// Can either accept client's price (no proposedPrice) or counter-offer (with proposedPrice)
  Future<DriverProposal> submitProposal(
    Session session, {
    required int requestId,
    required int driverId,
    double? proposedPrice,  // If null, driver accepts client's offered price
    required int estimatedArrival,
    String? message,
  }) async {
    try {
      // Get request
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Verify request is still pending
      if (request.status != RequestStatus.pending) {
        throw Exception('Request is no longer available');
      }

      // Get driver info
      final driver = await User.db.findById(session, driverId);
      if (driver == null) {
        throw Exception('Driver not found');
      }

      // Check if driver already submitted a proposal
      final existingProposal = await DriverProposal.db.findFirstRow(
        session,
        where: (t) =>
            t.requestId.equals(requestId) &
            t.driverId.equals(driverId) &
            (t.status.equals(ProposalStatus.pending) |
                t.status.equals(ProposalStatus.accepted)),
      );

      if (existingProposal != null) {
        throw Exception('You already submitted a proposal for this request');
      }

      // Validate counter-offer price if provided
      if (proposedPrice != null) {
        if (proposedPrice < 15.0) {
          throw Exception('Minimum price is 15 MAD');
        }
        if (proposedPrice > 500.0) {
          throw Exception('Maximum price is 500 MAD');
        }
        
        // Warn if counter is too high (more than 3x client offer)
        final clientOffer = request.clientOfferedPrice ?? request.totalPrice;
        if (proposedPrice > clientOffer * 3) {
          session.log(
            '[ProposalEndpoint] ⚠️ Driver counter-offer ($proposedPrice MAD) is >3x client offer ($clientOffer MAD)',
            level: LogLevel.warning,
          );
        }
      }

      // Determine if this is direct acceptance or counter-offer
      final isDirectAcceptance = proposedPrice == null;

      // Create proposal
      final proposal = DriverProposal(
        requestId: requestId,
        driverId: driverId,
        proposedPrice: proposedPrice ?? request.clientOfferedPrice ?? request.totalPrice,
        estimatedArrival: estimatedArrival,
        message: message,
        driverName: driver.fullName,
        driverPhone: driver.phoneNumber,
        driverRating: driver.rating,
        driverVehicleInfo: driver.vehicleInfo,
        status: ProposalStatus.pending,
        createdAt: DateTime.now(),
      );

      // Save proposal
      final savedProposal = await DriverProposal.db.insertRow(session, proposal);

      // Update request negotiation status
      final updatedRequest = request.copyWith(
        negotiationStatus: isDirectAcceptance 
            ? PriceNegotiationStatus.price_agreed  // Direct acceptance
            : PriceNegotiationStatus.offer_received,  // Counter-offer
        driverCounterPrice: proposedPrice,  // Will be null if direct acceptance
      );
      await ServiceRequest.db.updateRow(session, updatedRequest);

      session.log(
        '[ProposalEndpoint] 📝 ${isDirectAcceptance ? "Direct acceptance" : "Counter-offer"}: Driver ${driver.fullName} for request $requestId (${proposedPrice ?? request.clientOfferedPrice ?? request.totalPrice} MAD)',
        level: LogLevel.info,
      );

      // Send appropriate notification based on acceptance type
      if (isDirectAcceptance) {
        // Driver accepted client's price directly
        await NotificationService.notifyDriverAcceptedPrice(
          session,
          request: updatedRequest,
          driver: driver,
        );
      } else {
        // Driver sent counter-offer
        await NotificationService.notifyDriverCounterOffer(
          session,
          request: updatedRequest,
          driver: driver,
          counterPrice: proposedPrice!,
          message: message,
        );
      }

      return savedProposal;
    } catch (e) {
      session.log(
        '[ProposalEndpoint] ❌ Error submitting proposal: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Get all proposals for a request (client views available drivers)
  Future<List<DriverProposal>> getProposalsForRequest(
    Session session,
    int requestId,
  ) async {
    try {
      final proposals = await DriverProposal.db.find(
        session,
        where: (t) =>
            t.requestId.equals(requestId) &
            t.status.equals(ProposalStatus.pending),
        orderBy: (t) => t.createdAt,
      );

      return proposals;
    } catch (e) {
      session.log(
        '[ProposalEndpoint] ❌ Error fetching proposals: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Client accepts a driver's proposal
  Future<ServiceRequest> acceptProposal(
    Session session, {
    required int proposalId,
    required int clientId,
  }) async {
    try {
      // Get proposal
      final proposal = await DriverProposal.db.findById(session, proposalId);
      if (proposal == null) {
        throw Exception('Proposal not found');
      }

      // Get request
      final request = await ServiceRequest.db.findById(session, proposal.requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Verify client owns this request
      if (request.clientId != clientId) {
        throw Exception('Not authorized to accept this proposal');
      }

      // Verify request is still pending
      if (request.status != RequestStatus.pending) {
        throw Exception('Request is no longer available');
      }

      // Get driver info
      final driver = await User.db.findById(session, proposal.driverId);
      if (driver == null) {
        throw Exception('Driver not found');
      }

      // Accept this proposal
      final acceptedProposal = proposal.copyWith(
        status: ProposalStatus.accepted,
        acceptedAt: DateTime.now(),
      );
      await DriverProposal.db.updateRow(session, acceptedProposal);

      // Update request with driver and mark as accepted
      final finalPrice = proposal.proposedPrice ?? request.clientOfferedPrice ?? request.totalPrice;
      final updatedRequest = request.copyWith(
        driverId: proposal.driverId,
        driverName: proposal.driverName,
        driverPhone: proposal.driverPhone,
        status: RequestStatus.accepted,
        acceptedAt: DateTime.now(),
        // Set final agreed price
        agreedPrice: finalPrice,
        totalPrice: finalPrice,  // Also update totalPrice for compatibility
        // Update negotiation status
        negotiationStatus: PriceNegotiationStatus.price_agreed,
      );
      final savedRequest = await ServiceRequest.db.updateRow(session, updatedRequest);

      // Reject all other pending proposals
      final otherProposals = await DriverProposal.db.find(
        session,
        where: (t) =>
            t.requestId.equals(proposal.requestId) &
            t.id.notEquals(proposalId) &
            t.status.equals(ProposalStatus.pending),
      );

      for (final otherProposal in otherProposals) {
        await DriverProposal.db.updateRow(
          session,
          otherProposal.copyWith(
            status: ProposalStatus.expired,
            rejectedAt: DateTime.now(),
          ),
        );
      }

      session.log(
        '[ProposalEndpoint] ✅ Proposal accepted: Driver ${driver.fullName} for request ${request.id} at $finalPrice MAD',
        level: LogLevel.info,
      );

      // Get client info for notifications
      final client = await User.db.findById(session, request.clientId);

      // Notify driver that client accepted their offer
      if (client != null) {
        await NotificationService.notifyClientAcceptedOffer(
          session,
          request: savedRequest,
          client: client,
          agreedPrice: finalPrice,
        );
      }

      return savedRequest;
    } catch (e) {
      session.log(
        '[ProposalEndpoint] ❌ Error accepting proposal: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Client rejects a driver's proposal
  Future<bool> rejectProposal(
    Session session, {
    required int proposalId,
    required int clientId,
  }) async {
    try {
      final proposal = await DriverProposal.db.findById(session, proposalId);
      if (proposal == null) {
        throw Exception('Proposal not found');
      }

      final request = await ServiceRequest.db.findById(session, proposal.requestId);
      if (request == null || request.clientId != clientId) {
        throw Exception('Not authorized');
      }

      final rejectedProposal = proposal.copyWith(
        status: ProposalStatus.rejected,
        rejectedAt: DateTime.now(),
      );
      await DriverProposal.db.updateRow(session, rejectedProposal);

      // Notify driver that their offer was rejected
      await NotificationService.notifyClientRejectedOffer(
        session,
        request: request,
        driverId: proposal.driverId,
      );

      return true;
    } catch (e) {
      session.log(
        '[ProposalEndpoint] ❌ Error rejecting proposal: $e',
        level: LogLevel.error,
      );
      return false;
    }
  }

  /// Driver withdraws their proposal
  Future<bool> withdrawProposal(
    Session session, {
    required int proposalId,
    required int driverId,
  }) async {
    try {
      final proposal = await DriverProposal.db.findById(session, proposalId);
      if (proposal == null || proposal.driverId != driverId) {
        throw Exception('Not authorized');
      }

      if (proposal.status != ProposalStatus.pending) {
        throw Exception('Cannot withdraw proposal in current state');
      }

      final withdrawnProposal = proposal.copyWith(
        status: ProposalStatus.withdrawn,
        rejectedAt: DateTime.now(),
      );
      await DriverProposal.db.updateRow(session, withdrawnProposal);

      return true;
    } catch (e) {
      session.log(
        '[ProposalEndpoint] ❌ Error withdrawing proposal: $e',
        level: LogLevel.error,
      );
      return false;
    }
  }
}
