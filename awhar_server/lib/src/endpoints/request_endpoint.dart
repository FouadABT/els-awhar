import 'dart:async';

import 'package:awhar_server/src/generated/protocol.dart';
import 'package:awhar_server/src/services/pricing_service.dart';
import 'package:awhar_server/src/services/notification_service.dart';
import 'package:awhar_server/src/services/smart_matching_service.dart';
import 'package:awhar_server/src/services/elasticsearch/elasticsearch.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for managing service requests (rides, deliveries, etc.)
class RequestEndpoint extends Endpoint {
  /// Create a new service request
  /// Supports both generic requests and catalog-specific requests (with pre-assigned driver)
  Future<ServiceRequest> createRequest(
    Session session,
    int clientId,
    ServiceType serviceType,
    Location? pickupLocation,
    Location destinationLocation,
    String? notes, {
    double? clientOfferedPrice,  // Client's offered price
    double? estimatedPurchaseCost,
    bool? isPurchaseRequired,
    List<ShoppingItem>? shoppingList,
    List<String>? attachments,
    int? catalogServiceId,        // NEW: Reference to DriverService if from catalog
    int? catalogDriverId,         // NEW: Pre-assigned driver from catalog
    String? deviceFingerprint,    // Fraud detection - device fingerprint hash
  }) async {
    try {
      // Get client info
      final client = await User.db.findById(session, clientId);
      if (client == null) {
        throw Exception('Client not found');
      }

      // Validate catalog context if provided
      DriverService? catalogService;
      DriverProfile? catalogDriver;
      
      if (catalogServiceId != null && catalogServiceId > 0) {
        catalogService = await DriverService.db.findById(session, catalogServiceId);
        if (catalogService == null) {
          throw Exception('Catalog service not found');
        }
        if (!catalogService.isActive) {
          throw Exception('Service is no longer available');
        }
      }
      
      if (catalogDriverId != null && catalogDriverId > 0) {
        catalogDriver = await DriverProfile.db.findById(session, catalogDriverId);
        if (catalogDriver == null) {
          throw Exception('Driver not found');
        }
        if (!catalogDriver.isOnline) {
          session.log(
            'Warning: Catalog driver $catalogDriverId is offline but request created anyway',
            level: LogLevel.warning,
          );
        }
      }

      // Calculate distance only if pickup location is known
      double? distance;
      if (pickupLocation != null) {
        distance = PricingService.calculateDistance(
          pickupLocation.latitude,
          pickupLocation.longitude,
          destinationLocation.latitude,
          destinationLocation.longitude,
        );
      }

      // Calculate price estimate (for suggestions)
      final priceEstimate = PricingService.calculatePrice(
        distanceKm: distance,
        serviceType: serviceType,
      );

      // If from catalog service, use service pricing instead of generic estimate
      double finalOfferedPrice = clientOfferedPrice ?? priceEstimate.totalPrice;
      if (catalogService != null) {
        // Use service base price as starting point
        if (catalogService.basePrice != null && catalogService.basePrice! > 0) {
          finalOfferedPrice = clientOfferedPrice ?? catalogService.basePrice!;
        }
      }

      // Validate client offered price if provided
      if (finalOfferedPrice < 15.0) {
        throw Exception('Minimum price is 15 MAD');
      }
      if (finalOfferedPrice > 500.0) {
        throw Exception('Maximum price is 500 MAD');
      }

      // Estimate duration
      int? duration;
      if (distance != null) {
        duration = PricingService.estimateDuration(distance);
      }

      // Create service request
      final request = ServiceRequest(
        clientId: clientId,
        driverId: catalogDriverId,  // Auto-assign driver if from catalog
        serviceType: serviceType,
        status: RequestStatus.pending,
        pickupLocation: pickupLocation,
        destinationLocation: destinationLocation,
        basePrice: priceEstimate.basePrice,
        distancePrice: priceEstimate.distancePrice,
        totalPrice: priceEstimate.totalPrice,  // Keep as estimate
        distance: distance,
        estimatedDuration: duration,
        notes: notes,
        clientName: client.fullName,
        clientPhone: client.phoneNumber,
        createdAt: DateTime.now(),
        // Negotiation fields
        clientOfferedPrice: finalOfferedPrice,
           negotiationStatus: PriceNegotiationStatus.waiting_for_offers,
        isPurchaseRequired: isPurchaseRequired ?? false,
        estimatedPurchaseCost: estimatedPurchaseCost,
        shoppingList: shoppingList,
        attachments: attachments,
        // Catalog integration fields
        catalogServiceId: catalogServiceId,
        catalogDriverId: catalogDriverId,
        // Fraud detection
        deviceFingerprint: deviceFingerprint,
      );

      // Save to database
      final savedRequest = await ServiceRequest.db.insertRow(session, request);
      
      // Sync to Elasticsearch for analytics
      await session.esSync.indexRequest(savedRequest);

      session.log(
        'Service request created: ID ${savedRequest.id}, Client: ${client.fullName}, Type: $serviceType, Offered: $finalOfferedPrice MAD${catalogDriverId != null ? ', CatalogDriver: $catalogDriverId' : ''}',
        level: LogLevel.info,
      );

      // Send notifications based on request type
      if (catalogDriverId != null && catalogDriverId > 0) {
        // CATALOG REQUEST: Send notification to the pre-assigned driver
        try {
          // catalogDriverId is the DriverProfile ID, not User ID
          // We need to look up the DriverProfile to get the actual user
          final driverProfile = await DriverProfile.db.findById(session, catalogDriverId);
          if (driverProfile != null) {
            final driverUser = await User.db.findById(session, driverProfile.userId);
            if (driverUser != null) {
              session.log(
                '[RequestEndpoint] 📤 Sending catalog request notification to driver profile $catalogDriverId (user ID: ${driverUser.id}, name: ${driverUser.fullName})',
              );
              await NotificationService.notifyCatalogRequest(
                session,
                request: savedRequest,
                client: client,
                driver: driverUser,
              );
              session.log('[RequestEndpoint] ✅ Catalog request notification sent to ${driverUser.fullName}');
            } else {
              session.log(
                '[RequestEndpoint] ⚠️ Driver user not found for userId: ${driverProfile.userId}',
                level: LogLevel.warning,
              );
            }
          } else {
            session.log(
              '[RequestEndpoint] ⚠️ Driver profile not found for catalogDriverId: $catalogDriverId',
              level: LogLevel.warning,
            );
          }
        } catch (e) {
          session.log(
            '❌ Failed to send catalog request notification: $e',
            level: LogLevel.warning,
          );
          // Don't throw - notification failure shouldn't block request creation
        }
      } else {
        // GENERAL/CONCIERGE REQUEST: Use AI Smart Matching to find best drivers
        // The matching screen handles the AI visualization via streaming SSE.
        // This background task just notifies ALL drivers about the new request.
        unawaited(_notifyDriversAsync(savedRequest, client));
      }

      return savedRequest;
    } catch (e) {
      session.log(
        'Error creating service request: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Notify all drivers about a new service request in the background.
  /// The AI smart matching visualization is handled separately via SSE streaming
  /// to the client. This background task just ensures ALL drivers get notified.
  ///
  /// IMPORTANT: This creates its OWN session because the endpoint session
  /// is closed as soon as createRequest() returns.
  Future<void> _notifyDriversAsync(
    ServiceRequest savedRequest,
    User client,
  ) async {
    Session? bgSession;
    try {
      bgSession = await SmartMatchingService.createBackgroundSession();
      bgSession.log(
        '[RequestEndpoint] 📢 Broadcasting new request ${savedRequest.id} to all drivers...',
      );

      final notifiedCount = await NotificationService.notifyAllDrivers(
        bgSession,
        request: savedRequest,
        client: client,
      );

      bgSession.log(
        '[RequestEndpoint] ✅ Broadcast notifications sent to $notifiedCount drivers',
      );
    } catch (e, stackTrace) {
      print('[RequestEndpoint] ❌ Background notification failed: $e');
      print('[RequestEndpoint] Stack trace: $stackTrace');
    } finally {
      await bgSession?.close();
    }
  }

  /// Get a service request by ID
  Future<ServiceRequest?> getRequestById(
    Session session,
    int requestId,
  ) async {
    try {
      return await ServiceRequest.db.findById(session, requestId);
    } catch (e) {
      session.log(
        'Error fetching request $requestId: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Get price suggestion for a route
  /// Helps clients and drivers determine fair pricing
  Future<Map<String, dynamic>> getPriceSuggestion(
    Session session,
    double pickupLat,
    double pickupLon,
    double destLat,
    double destLon,
    ServiceType serviceType,
  ) async {
    try {
      // Calculate distance
      final distance = PricingService.calculateDistance(
        pickupLat,
        pickupLon,
        destLat,
        destLon,
      );

      // Get price suggestion
      final suggestion = PricingService.getSuggestedPriceRange(
        distanceKm: distance,
        serviceType: serviceType,
      );

      session.log(
        'Price suggestion calculated: Distance ${distance}km, Range: ${suggestion.minPrice}-${suggestion.maxPrice} MAD',
        level: LogLevel.info,
      );

      return suggestion.toJson();
    } catch (e) {
      session.log(
        'Error calculating price suggestion: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Get ALL active requests for a client (supports multiple orders)
  Future<List<ServiceRequest>> getActiveRequestsForClient(
    Session session,
    int clientId,
  ) async {
    try {
      session.log('[RequestEndpoint] 🔍 Getting active requests for client $clientId');
      
      // Find all requests that are not completed or cancelled
      // Include ALL active statuses: pending, driver_proposed, accepted, driver_arriving, in_progress
      final requests = await ServiceRequest.db.find(
        session,
        where: (t) =>
            t.clientId.equals(clientId) &
            (t.status.equals(RequestStatus.pending) |
                t.status.equals(RequestStatus.driver_proposed) |
                t.status.equals(RequestStatus.accepted) |
                t.status.equals(RequestStatus.driver_arriving) |
                t.status.equals(RequestStatus.in_progress)),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );

      session.log('[RequestEndpoint] ✅ Found ${requests.length} active requests for client $clientId');
      for (final req in requests) {
        session.log('[RequestEndpoint]   📋 Request #${req.id}: ${req.serviceType}, status=${req.status}');
      }

      return requests;
    } catch (e) {
      session.log(
        'Error fetching active requests for client $clientId: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get active request for a client (DEPRECATED - returns first one for backwards compatibility)
  @Deprecated('Use getActiveRequestsForClient instead')
  Future<ServiceRequest?> getActiveRequestForClient(
    Session session,
    int clientId,
  ) async {
    try {
      final requests = await getActiveRequestsForClient(session, clientId);
      return requests.isNotEmpty ? requests.first : null;
    } catch (e) {
      session.log(
        'Error fetching active request for client $clientId: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Get active request for a driver (returns first one - for backwards compatibility)
  Future<ServiceRequest?> getActiveRequestForDriver(
    Session session,
    int driverId,
  ) async {
    try {
      final requests = await getActiveRequestsForDriver(session, driverId);
      return requests.isNotEmpty ? requests.first : null;
    } catch (e) {
      session.log(
        'Error fetching active request for driver $driverId: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Get ALL active requests for a driver (supports multiple active deliveries)
  /// Includes driver_proposed so drivers can see requests waiting for client confirmation
  Future<List<ServiceRequest>> getActiveRequestsForDriver(
    Session session,
    int driverId,
  ) async {
    try {
      session.log('[RequestEndpoint] 🔍 Getting active requests for driver $driverId');
      
      final requests = await ServiceRequest.db.find(
        session,
        where: (t) =>
            t.driverId.equals(driverId) &
            (t.status.equals(RequestStatus.driver_proposed) |
                t.status.equals(RequestStatus.accepted) |
                t.status.equals(RequestStatus.driver_arriving) |
                t.status.equals(RequestStatus.in_progress)),
        orderBy: (t) => t.acceptedAt,
        orderDescending: true,
      );

      session.log('[RequestEndpoint] ✅ Found ${requests.length} active requests for driver $driverId');
      for (final req in requests) {
        session.log('[RequestEndpoint]   📋 Request #${req.id}: ${req.serviceType}, status=${req.status}');
      }

      return requests;
    } catch (e) {
      session.log(
        'Error fetching active requests for driver $driverId: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get nearby pending requests for a driver
  /// Note: This is a simple implementation. For production, use PostGIS for geospatial queries
  Future<List<ServiceRequest>> getNearbyRequests(
    Session session,
    int driverId,
    double driverLat,
    double driverLon, {
    double radiusKm = 10.0,
  }) async {
    try {
      session.log('[RequestEndpoint] 🔍 Getting nearby requests for driver $driverId at ($driverLat, $driverLon) within ${radiusKm}km');
      
      // Get all pending requests
      final allPendingRequests = await ServiceRequest.db.find(
        session,
        where: (t) => t.status.equals(RequestStatus.pending),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: 50,
      );

      session.log('[RequestEndpoint] 📋 Found ${allPendingRequests.length} total pending requests');

      // Filter by distance
      final nearbyRequests = <ServiceRequest>[];
      for (final request in allPendingRequests) {
        // If pickup location is null (Concierge), use destination location for distance check
        // Or if it's "any store", the request is effectively "at the client" to start the job flow?
        // Let's assume if pickup is null, we measure distance to destination (Client)
        final targetLat = request.pickupLocation?.latitude ?? request.destinationLocation.latitude;
        final targetLon = request.pickupLocation?.longitude ?? request.destinationLocation.longitude;

        final distance = PricingService.calculateDistance(
          driverLat,
          driverLon,
          targetLat,
          targetLon,
        );

        session.log('[RequestEndpoint]   Request #${request.id}: ${request.pickupLocation?.placeName ?? "Flexible"} - Distance: ${distance.toStringAsFixed(2)}km');

        if (distance <= radiusKm) {
          nearbyRequests.add(request);
          session.log('[RequestEndpoint]   ✅ Added to nearby list (within ${radiusKm}km)');
        } else {
          session.log('[RequestEndpoint]   ❌ Too far (${distance.toStringAsFixed(2)}km > ${radiusKm}km)');
        }
      }

      // Sort by distance (closest first)
      nearbyRequests.sort((a, b) {
        final targetLatA = a.pickupLocation?.latitude ?? a.destinationLocation.latitude;
        final targetLonA = a.pickupLocation?.longitude ?? a.destinationLocation.longitude;
        
        final targetLatB = b.pickupLocation?.latitude ?? b.destinationLocation.latitude;
        final targetLonB = b.pickupLocation?.longitude ?? b.destinationLocation.longitude;

        final distA = PricingService.calculateDistance(
          driverLat,
          driverLon,
          targetLatA,
          targetLonA,
        );
        final distB = PricingService.calculateDistance(
          driverLat,
          driverLon,
          targetLatB,
          targetLonB,
        );
        return distA.compareTo(distB);
      });

      session.log('[RequestEndpoint] ✅ Returning ${nearbyRequests.length} nearby requests');
      return nearbyRequests;
    } catch (e) {
      session.log(
        'Error fetching nearby requests for driver $driverId: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Accept a request (driver accepts)
  /// Drivers can have multiple active deliveries (up to maxActiveRequests)
  Future<ServiceRequest?> acceptRequest(
    Session session,
    int requestId,
    int driverId,
  ) async {
    // Removed max active requests limit - drivers can handle unlimited concurrent deliveries
    
    try {
      // Get the request
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Validate request is still pending
      if (request.status != RequestStatus.pending) {
        throw Exception(
            'Request is no longer available (status: ${request.status})');
      }

      // Get driver info
      final driver = await User.db.findById(session, driverId);
      if (driver == null) {
        throw Exception('Driver not found');
      }

      // Validate driver role
      if (!driver.roles.contains(UserRole.driver)) {
        throw Exception('User is not a driver');
      }

      // Update request - set as proposed (awaiting client approval)
      request.proposedDriverId = driverId;
      request.proposedDriverName = driver.fullName;
      request.proposedDriverPhone = driver.phoneNumber;
      request.status = RequestStatus.driver_proposed;
      // driverId will be set only after client accepts

      final updatedRequest =
          await ServiceRequest.db.updateRow(session, request);

      // Sync to Elasticsearch
      await session.esSync.indexRequest(updatedRequest);

      session.log(
        'Request ${request.id} proposed by driver ${driver.fullName}, awaiting client approval',
        level: LogLevel.info,
      );

      // Send notification to client - driver wants to take the request
      try {
        session.log('[RequestEndpoint] 📤 Sending driver proposal notification to client ${request.clientId}');
        await NotificationService.notifyDriverProposed(
          session,
          request: updatedRequest,
          driver: driver,
        );
        session.log('[RequestEndpoint] ✅ Notification sent successfully');
      } catch (e) {
        session.log(
          '❌ Failed to send notification: $e',
          level: LogLevel.warning,
        );
        // Don't throw - notification failure shouldn't block acceptance
      }

      return updatedRequest;
    } catch (e) {
      session.log(
        'Error accepting request $requestId by driver $driverId: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Client approves proposed driver
  Future<ServiceRequest?> approveDriver(
    Session session,
    int requestId,
    int clientId,
  ) async {
    try {
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Validate client owns this request
      if (request.clientId != clientId) {
        throw Exception('Unauthorized: Not your request');
      }

      // Validate request status
      if (request.status != RequestStatus.driver_proposed) {
        throw Exception('No driver proposal to approve (status: ${request.status})');
      }

      if (request.proposedDriverId == null) {
        throw Exception('No proposed driver found');
      }

      // Get driver info
      final driver = await User.db.findById(session, request.proposedDriverId!);
      if (driver == null) {
        throw Exception('Proposed driver not found');
      }

      // Approve driver - assign them to the request
      request.driverId = request.proposedDriverId;
      request.driverName = request.proposedDriverName;
      request.driverPhone = request.proposedDriverPhone;
      request.status = RequestStatus.accepted;
      request.acceptedAt = DateTime.now();

      final updatedRequest = await ServiceRequest.db.updateRow(session, request);

      // Sync to Elasticsearch
      await session.esSync.indexRequest(updatedRequest);

      session.log(
        'Client ${request.clientName} approved driver ${driver.fullName} for request ${request.id}',
        level: LogLevel.info,
      );

      // Notify driver they were approved
      try {
        await NotificationService.notifyDriverApproved(
          session,
          request: updatedRequest,
          driver: driver,
        );
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      return updatedRequest;
    } catch (e) {
      session.log('Error approving driver for request $requestId: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Client rejects proposed driver
  Future<ServiceRequest?> rejectDriver(
    Session session,
    int requestId,
    int clientId,
  ) async {
    try {
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Validate client owns this request
      if (request.clientId != clientId) {
        throw Exception('Unauthorized: Not your request');
      }

      // Validate request status
      if (request.status != RequestStatus.driver_proposed) {
        throw Exception('No driver proposal to reject (status: ${request.status})');
      }

      if (request.proposedDriverId == null) {
        throw Exception('No proposed driver found');
      }

      // Get driver info for notification
      final driver = await User.db.findById(session, request.proposedDriverId!);

      // Reject - reset to pending for other drivers to see
      request.proposedDriverId = null;
      request.proposedDriverName = null;
      request.proposedDriverPhone = null;
      request.status = RequestStatus.pending;

      final updatedRequest = await ServiceRequest.db.updateRow(session, request);

      // Sync to Elasticsearch
      await session.esSync.indexRequest(updatedRequest);

      session.log(
        'Client ${request.clientName} rejected driver ${driver?.fullName} for request ${request.id}',
        level: LogLevel.info,
      );

      // Notify driver they were rejected
      if (driver != null) {
        try {
          await NotificationService.notifyDriverRejected(
            session,
            request: updatedRequest,
            driver: driver,
          );
        } catch (e) {
          session.log('Failed to send notification: $e', level: LogLevel.warning);
        }
      }

      return updatedRequest;
    } catch (e) {
      session.log('Error rejecting driver for request $requestId: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Update request status (with validation)
  Future<ServiceRequest?> updateRequestStatus(
    Session session,
    int requestId,
    RequestStatus newStatus,
    int userId,
  ) async {
    try {
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Validate status transition
      if (!_isValidStatusTransition(request.status, newStatus)) {
        throw Exception(
            'Invalid status transition: ${request.status} -> $newStatus');
      }

      // Validate user permission
      // Only driver can update status (except cancellation)
      if (newStatus != RequestStatus.cancelled) {
        if (request.driverId != userId) {
          throw Exception('Only the assigned driver can update request status');
        }
      }

      // Update status and timestamp
      request.status = newStatus;

      switch (newStatus) {
        case RequestStatus.driver_arriving:
          request.driverArrivingAt = DateTime.now();
          break;
        case RequestStatus.in_progress:
          request.startedAt = DateTime.now();
          break;
        case RequestStatus.completed:
          request.completedAt = DateTime.now();
          break;
        case RequestStatus.cancelled:
          request.cancelledAt = DateTime.now();
          request.cancelledBy = userId;
          break;
        default:
          break;
      }

      final updatedRequest =
          await ServiceRequest.db.updateRow(session, request);

      // Sync to Elasticsearch
      await session.esSync.indexRequest(updatedRequest);

      session.log(
        'Request ${request.id} status updated to $newStatus',
        level: LogLevel.info,
      );

      // Send notifications based on status
      try {
        switch (newStatus) {
          case RequestStatus.accepted:
            final driver = await User.db.findById(session, request.driverId!);
            if (driver != null) {
              await NotificationService.notifyRequestAccepted(
                session,
                request: updatedRequest,
                driver: driver,
              );
            }
            break;
          case RequestStatus.driver_arriving:
            final driver = await User.db.findById(session, request.driverId!);
            if (driver != null) {
              await NotificationService.notifyDriverArriving(
                session,
                request: updatedRequest,
                driver: driver,
              );
            }
            break;
          case RequestStatus.in_progress:
            final driver = await User.db.findById(session, request.driverId!);
            if (driver != null) {
              await NotificationService.notifyServiceStarted(
                session,
                request: updatedRequest,
                driver: driver,
              );
            }
            break;
          case RequestStatus.completed:
            final driver = await User.db.findById(session, request.driverId!);
            if (driver != null) {
              await NotificationService.notifyServiceCompleted(
                session,
                request: updatedRequest,
                driver: driver,
              );
            }
            break;
          default:
            break;
        }
      } catch (e) {
        session.log(
          'Failed to send notification for status $newStatus: $e',
          level: LogLevel.warning,
        );
        // Don't throw - notification failure shouldn't block status update
      }

      return updatedRequest;
    } catch (e) {
      session.log(
        'Error updating request $requestId status: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Cancel a request
  Future<ServiceRequest?> cancelRequest(
    Session session,
    int requestId,
    int userId,
    String reason,
  ) async {
    try {
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) {
        throw Exception('Request not found');
      }

      // Validate user is client or driver
      if (request.clientId != userId && request.driverId != userId) {
        throw Exception('Only client or assigned driver can cancel request');
      }

      // Check if already completed or cancelled
      if (request.status == RequestStatus.completed ||
          request.status == RequestStatus.cancelled) {
        throw Exception('Request is already ${request.status}');
      }

      request.status = RequestStatus.cancelled;
      request.cancelledAt = DateTime.now();
      request.cancelledBy = userId;
      request.cancellationReason = reason;

      final updatedRequest =
          await ServiceRequest.db.updateRow(session, request);

      // Sync to Elasticsearch
      await session.esSync.indexRequest(updatedRequest);

      session.log(
        'Request ${request.id} cancelled by user $userId. Reason: $reason',
        level: LogLevel.info,
      );

      // Send cancellation notification to the other party
      try {
        if (request.driverId != null && request.driverId != userId) {
          // Client cancelled, notify driver
          await NotificationService.notifyRequestCancelled(
            session,
            request: updatedRequest,
            driverId: request.driverId!,
          );
        }
        // If driver cancelled, we could notify client here
        // For now, client will see status change when they refresh
      } catch (e) {
        session.log(
          'Failed to send cancellation notification: $e',
          level: LogLevel.warning,
        );
      }

      // TODO: Handle refund if applicable

      return updatedRequest;
    } catch (e) {
      session.log(
        'Error cancelling request $requestId: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Get request history for a client
  Future<List<ServiceRequest>> getClientRequestHistory(
    Session session,
    int clientId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await ServiceRequest.db.find(
        session,
        where: (t) => t.clientId.equals(clientId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log(
        'Error fetching client history for $clientId: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get request history for a driver
  Future<List<ServiceRequest>> getDriverRequestHistory(
    Session session,
    int driverId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await ServiceRequest.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
        orderBy: (t) => t.acceptedAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log(
        'Error fetching driver history for $driverId: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get ALL pending service requests (no distance filter)
  /// FOR TESTING ONLY - In production, use getNearbyRequests with distance filter
  /// Returns all pending requests that don't have an assigned driver yet
  Future<List<ServiceRequest>> getAllPendingRequests(
    Session session,
  ) async {
    try {
      session.log('[RequestEndpoint] 🔍 Getting ALL pending requests (no filter)');
      
      // Get all pending requests without an assigned driver
      final allPending = await ServiceRequest.db.find(
        session,
        where: (t) => t.status.equals(RequestStatus.pending) & 
                       t.driverId.equals(null),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: 100,
      );

      session.log('[RequestEndpoint] 📋 Found ${allPending.length} pending requests available');
      for (final req in allPending) {
        session.log('[RequestEndpoint]   - Request #${req.id}: ${req.clientName}, ${req.serviceType}, ${req.clientOfferedPrice ?? req.totalPrice} ${req.currencySymbol}');
      }
      
      return allPending;
    } catch (e) {
      session.log(
        'Error getting all pending requests: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get all pending catalog requests assigned to a driver
  /// Catalog requests are requests created specifically for this driver via service catalog
  /// These are NOT filtered by distance - driver should see all requests assigned to them
  /// 
  /// NOTE: This accepts USER ID (not driver profile ID) and looks up the driver profile
  Future<List<ServiceRequest>> getCatalogRequests(
    Session session,
    int userId,
  ) async {
    try {
      session.log('[RequestEndpoint] 🎯 Getting catalog requests for user $userId');
      
      // First, look up the driver profile for this user
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
      
      if (driverProfile == null) {
        session.log('[RequestEndpoint] ⚠️ No driver profile found for user $userId');
        return [];
      }
      
      final driverProfileId = driverProfile.id!;
      session.log('[RequestEndpoint] 📋 Found driver profile ID: $driverProfileId for user $userId');
      
      // Get all pending requests with this driver profile's ID as catalogDriverId
      final catalogRequests = await ServiceRequest.db.find(
        session,
        where: (t) => t.status.equals(RequestStatus.pending) & 
                       t.catalogDriverId.equals(driverProfileId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );

      session.log('[RequestEndpoint] 📋 Found ${catalogRequests.length} catalog requests for driver profile $driverProfileId (user $userId)');
      for (final req in catalogRequests) {
        session.log('[RequestEndpoint]   - Request #${req.id}: ${req.clientName}, ${req.serviceType}, ${req.clientOfferedPrice ?? req.totalPrice} MAD');
      }
      
      return catalogRequests;
    } catch (e) {
      session.log(
        'Error getting catalog requests for user $userId: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  /// Validate if status transition is allowed
  bool _isValidStatusTransition(
      RequestStatus currentStatus, RequestStatus newStatus) {
    // Can always cancel (except if already completed or cancelled)
    if (newStatus == RequestStatus.cancelled) {
      return currentStatus != RequestStatus.completed &&
          currentStatus != RequestStatus.cancelled;
    }

    // Valid transitions map
    const validTransitions = {
      RequestStatus.pending: [RequestStatus.accepted],
      RequestStatus.accepted: [RequestStatus.driver_arriving],
      RequestStatus.driver_arriving: [RequestStatus.in_progress],
      RequestStatus.in_progress: [RequestStatus.completed],
    };

    final allowedTransitions = validTransitions[currentStatus];
    return allowedTransitions?.contains(newStatus) ?? false;
  }
}
