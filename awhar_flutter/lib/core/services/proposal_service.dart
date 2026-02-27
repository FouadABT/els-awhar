import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

/// Service for managing driver proposals
class ProposalService extends GetxService {
  final Client _client;

  ProposalService(this._client);

  /// Get all proposals for a request (client side)
  Future<List<DriverProposal>> getProposalsForRequest(int requestId) async {
    try {
      debugPrint('[ProposalService] 📋 Fetching proposals for request: $requestId');
      final proposals = await _client.proposal.getProposalsForRequest(requestId);
      debugPrint('[ProposalService] ✅ Found ${proposals.length} proposals');
      return proposals;
    } catch (e) {
      debugPrint('[ProposalService] ❌ Error fetching proposals: $e');
      return [];
    }
  }

  /// Submit a proposal (driver side)
  Future<DriverProposal?> submitProposal({
    required int requestId,
    required int driverId,
    required int estimatedArrival,
    double? proposedPrice,
    String? message,
  }) async {
    try {
      debugPrint('[ProposalService] 📤 Submitting proposal for request: $requestId');
      final proposal = await _client.proposal.submitProposal(
        requestId: requestId,
        driverId: driverId,
        proposedPrice: proposedPrice,
        estimatedArrival: estimatedArrival,
        message: message,
      );
      debugPrint('[ProposalService] ✅ Proposal submitted successfully');
      return proposal;
    } catch (e) {
      debugPrint('[ProposalService] ❌ Error submitting proposal: $e');
      rethrow;
    }
  }

  /// Accept a proposal (client side)
  Future<ServiceRequest?> acceptProposal({
    required int proposalId,
    required int clientId,
  }) async {
    try {
      debugPrint('[ProposalService] ✅ Accepting proposal: $proposalId');
      final request = await _client.proposal.acceptProposal(
        proposalId: proposalId,
        clientId: clientId,
      );
      debugPrint('[ProposalService] ✅ Proposal accepted, request updated');
      return request;
    } catch (e) {
      debugPrint('[ProposalService] ❌ Error accepting proposal: $e');
      rethrow;
    }
  }

  /// Reject a proposal (client side)
  Future<bool> rejectProposal({
    required int proposalId,
    required int clientId,
  }) async {
    try {
      debugPrint('[ProposalService] ❌ Rejecting proposal: $proposalId');
      final success = await _client.proposal.rejectProposal(
        proposalId: proposalId,
        clientId: clientId,
      );
      debugPrint('[ProposalService] ${success ? "✅" : "❌"} Proposal rejection result: $success');
      return success;
    } catch (e) {
      debugPrint('[ProposalService] ❌ Error rejecting proposal: $e');
      return false;
    }
  }

  /// Withdraw a proposal (driver side)
  Future<bool> withdrawProposal({
    required int proposalId,
    required int driverId,
  }) async {
    try {
      debugPrint('[ProposalService] 🔙 Withdrawing proposal: $proposalId');
      final success = await _client.proposal.withdrawProposal(
        proposalId: proposalId,
        driverId: driverId,
      );
      debugPrint('[ProposalService] ${success ? "✅" : "❌"} Proposal withdrawal result: $success');
      return success;
    } catch (e) {
      debugPrint('[ProposalService] ❌ Error withdrawing proposal: $e');
      return false;
    }
  }
}
