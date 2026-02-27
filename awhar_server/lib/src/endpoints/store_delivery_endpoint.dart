import 'dart:convert';
import 'dart:math' show sqrt, pi, atan2, cos, sin;
import 'package:serverpod/serverpod.dart' hide Transaction;
import '../generated/protocol.dart';
import '../services/smart_matching_service.dart';
import 'notification_endpoint.dart';

/// Store Delivery Endpoint
/// Handles driver assignment, delivery flow, and 3-way coordination
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
class StoreDeliveryEndpoint extends Endpoint {
  // ==================== DRIVER DISCOVERY (for Stores) ====================

  /// Get nearby online drivers for store to request delivery
  /// Returns NearbyDriver list with distance info
  /// MVP Mode: Shows nearby drivers first, then up to 3 additional online drivers
  Future<List<NearbyDriver>> getNearbyDrivers(
    Session session, {
    required int storeId,
    required int orderId,
    double radiusKm = 10.0,
  }) async {
    try {
      // Get store location
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      session.log(
        '[StoreDelivery] 🔍 Finding drivers for store ${store.name} at (${store.latitude}, ${store.longitude})',
      );

      // Get all online drivers
      final allDrivers = await DriverProfile.db.find(
        session,
        where: (t) => t.isOnline.equals(true),
      );

      session.log(
        '[StoreDelivery] 📋 Found ${allDrivers.length} online drivers total',
      );

      // Separate into nearby (with recent location) and others
      final now = DateTime.now();
      final cutoff = now.subtract(
        const Duration(minutes: 30),
      ); // More lenient: 30 min instead of 2 min

      final nearbyWithDistance = <_DriverWithDistance>[];
      final othersWithDistance = <_DriverWithDistance>[];

      for (final driver in allDrivers) {
        // Check if driver has valid location
        final hasLiveLocation =
            driver.lastLocationLat != null &&
            driver.lastLocationLng != null &&
            driver.lastLocationUpdatedAt != null &&
            driver.lastLocationUpdatedAt!.isAfter(cutoff);

        double? distance;
        if (hasLiveLocation) {
          distance = _calculateDistance(
            store.latitude,
            store.longitude,
            driver.lastLocationLat!,
            driver.lastLocationLng!,
          );

          session.log(
            '[StoreDelivery] 👤 Driver ${driver.id}: ${distance.toStringAsFixed(2)}km away',
          );

          if (distance <= radiusKm) {
            nearbyWithDistance.add(_DriverWithDistance(driver, distance, true));
          } else {
            // Still add to "other" list if they're online but far
            othersWithDistance.add(_DriverWithDistance(driver, distance, true));
          }
        } else {
          // Driver is online but no/old location - add to others for MVP
          session.log(
            '[StoreDelivery] 👤 Driver ${driver.id}: online but no recent location',
          );
          othersWithDistance.add(_DriverWithDistance(driver, null, false));
        }
      }

      // Sort nearby by distance
      nearbyWithDistance.sort(
        (a, b) => (a.distance ?? double.infinity).compareTo(
          b.distance ?? double.infinity,
        ),
      );

      // Combine results: nearby first, then up to 3 additional drivers for MVP testing
      final combined = <_DriverWithDistance>[...nearbyWithDistance];

      // Add up to 3 "other" drivers for MVP testing (so stores always see some options)
      final othersToAdd = othersWithDistance.take(3);
      for (final dwd in othersToAdd) {
        if (!combined.any((d) => d.driver.id == dwd.driver.id)) {
          combined.add(dwd);
        }
      }

      session.log(
        '[StoreDelivery] ✅ Returning ${combined.length} drivers (${nearbyWithDistance.length} nearby + ${combined.length - nearbyWithDistance.length} others)',
      );

      // Convert to NearbyDriver list
      return combined
          .map(
            (dwd) => NearbyDriver(
              driver: dwd.driver,
              distanceKm: dwd.distance,
              hasLiveLocation: dwd.hasLiveLocation,
              lastLocationAt: dwd.driver.lastLocationUpdatedAt,
            ),
          )
          .toList();
    } catch (e) {
      session.log('Error getting nearby drivers: $e', level: LogLevel.error);
      return [];
    }
  }

  // ==================== DRIVER REQUEST ====================

  /// Store requests a specific driver directly
  Future<StoreDeliveryRequest?> requestDriver(
    Session session, {
    required int storeId,
    required int orderId,
    required int driverId,
  }) async {
    try {
      // Validate store owns the order
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.storeId != storeId) {
        throw Exception('Not authorized');
      }
      if (order.driverId != null) {
        throw Exception('Driver already assigned');
      }
      if (order.status != StoreOrderStatus.confirmed &&
          order.status != StoreOrderStatus.preparing &&
          order.status != StoreOrderStatus.ready) {
        throw Exception('Order not ready for driver assignment');
      }

      // Get store for pickup details
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      // Check driver exists and is online
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) {
        throw Exception('Driver not found');
      }
      if (!driver.isOnline) {
        throw Exception('Driver is not online');
      }

      // Check for ANY existing request for this order (regardless of status)
      // and delete it to avoid unique constraint violation
      final existingRequest = await StoreDeliveryRequest.db.findFirstRow(
        session,
        where: (t) => t.storeOrderId.equals(orderId),
      );
      if (existingRequest != null) {
        // Delete existing request to avoid unique constraint violation
        await StoreDeliveryRequest.db.deleteRow(session, existingRequest);
        session.log(
          '[StoreDelivery] 🗑️ Deleted existing request ${existingRequest.id} (status: ${existingRequest.status}) for order $orderId',
        );
      }

      // Calculate earnings
      final deliveryFee = order.deliveryFee;
      final commission = deliveryFee * 0.05;
      final driverEarnings = deliveryFee - commission;

      // Create delivery request
      final request = StoreDeliveryRequest(
        storeOrderId: orderId,
        storeId: storeId,
        requestType: 'direct',
        targetDriverId: driverId,
        pickupAddress: store.address,
        pickupLatitude: store.latitude,
        pickupLongitude: store.longitude,
        deliveryAddress: order.deliveryAddress,
        deliveryLatitude: order.deliveryLatitude,
        deliveryLongitude: order.deliveryLongitude,
        distanceKm: order.deliveryDistance,
        deliveryFee: deliveryFee,
        driverEarnings: driverEarnings,
        status: 'pending',
        assignedDriverId: null,
        expiresAt: DateTime.now().add(const Duration(minutes: 30)),
        createdAt: DateTime.now(),
        acceptedAt: null,
        rejectedAt: null,
      );

      final created = await StoreDeliveryRequest.db.insertRow(session, request);
      session.log(
        '[StoreDelivery] ✅ Direct driver request created: ${created.id} for order $orderId',
      );

      // Send push notification to driver
      session.log(
        '[StoreDelivery] 📤 Sending notification to driver.userId=${driver.userId}...',
      );
      try {
        final notificationEndpoint = NotificationEndpoint();
        final notification = await notificationEndpoint.createNotification(
          session,
          userId: driver.userId,
          title: '🚚 New Delivery Request',
          body:
              '${store.name} sent you a delivery request - ৳${deliveryFee.toStringAsFixed(2)}',
          type: NotificationType.delivery,
          relatedEntityId: created.id,
          relatedEntityType: 'StoreDeliveryRequest',
          data: {
            'storeName': store.name,
            'pickupAddress': store.address,
            'deliveryFee': deliveryFee,
            'requestId': created.id,
          },
        );
        if (notification != null) {
          session.log(
            '[StoreDelivery] ✅ Notification created id=${notification.id} for driver.userId=${driver.userId}',
          );
        } else {
          session.log(
            '[StoreDelivery] ⚠️ Notification returned null for driver.userId=${driver.userId}',
            level: LogLevel.warning,
          );
        }
      } catch (e, stack) {
        session.log(
          '[StoreDelivery] ❌ Failed to send notification: $e\n$stack',
          level: LogLevel.error,
        );
        // Don't fail the request if notification fails - driver can still see it in-app
      }

      return created;
    } catch (e) {
      session.log('Error requesting driver: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Store posts a public delivery request (all nearby drivers can see)
  Future<StoreDeliveryRequest?> postDeliveryRequest(
    Session session, {
    required int storeId,
    required int orderId,
  }) async {
    try {
      // Validate store owns the order
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.storeId != storeId) {
        throw Exception('Not authorized');
      }
      if (order.driverId != null) {
        throw Exception('Driver already assigned');
      }
      if (order.status != StoreOrderStatus.confirmed &&
          order.status != StoreOrderStatus.preparing &&
          order.status != StoreOrderStatus.ready) {
        throw Exception('Order not ready for driver assignment');
      }

      // Get store for pickup details
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      // Check for ANY existing request for this order (regardless of status)
      // and delete it to avoid unique constraint violation
      final existingRequest = await StoreDeliveryRequest.db.findFirstRow(
        session,
        where: (t) => t.storeOrderId.equals(orderId),
      );
      if (existingRequest != null) {
        // Delete existing request to avoid unique constraint violation
        await StoreDeliveryRequest.db.deleteRow(session, existingRequest);
        session.log(
          '[StoreDelivery] 🗑️ Deleted existing request ${existingRequest.id} (status: ${existingRequest.status}) for order $orderId',
        );
      }

      // Calculate earnings
      final deliveryFee = order.deliveryFee;
      final commission = deliveryFee * 0.05;
      final driverEarnings = deliveryFee - commission;

      // Create public delivery request
      final request = StoreDeliveryRequest(
        storeOrderId: orderId,
        storeId: storeId,
        requestType: 'public',
        targetDriverId: null,
        pickupAddress: store.address,
        pickupLatitude: store.latitude,
        pickupLongitude: store.longitude,
        deliveryAddress: order.deliveryAddress,
        deliveryLatitude: order.deliveryLatitude,
        deliveryLongitude: order.deliveryLongitude,
        distanceKm: order.deliveryDistance,
        deliveryFee: deliveryFee,
        driverEarnings: driverEarnings,
        status: 'pending',
        assignedDriverId: null,
        expiresAt: DateTime.now().add(const Duration(minutes: 15)),
        createdAt: DateTime.now(),
        acceptedAt: null,
        rejectedAt: null,
      );

      final created = await StoreDeliveryRequest.db.insertRow(session, request);
      session.log(
        'Public delivery request created: ${created.id} for order $orderId',
      );

      // Send targeted notifications using AI Smart Matching
      // Falls back to simple geo-broadcast if agent fails
      try {
        session.log('[StoreDelivery] 🤖 Using AI Smart Match for public delivery request...');

        // Build a lightweight ServiceRequest-like object for the matching service
        final matchRequest = ServiceRequest(
          clientId: storeId,
          serviceType: ServiceType.delivery,
          status: RequestStatus.pending,
          pickupLocation: Location(
            latitude: store.latitude,
            longitude: store.longitude,
            address: store.address,
          ),
          destinationLocation: Location(
            latitude: order.deliveryLatitude ?? store.latitude,
            longitude: order.deliveryLongitude ?? store.longitude,
            address: order.deliveryAddress ?? '',
          ),
          basePrice: deliveryFee,
          distancePrice: 0,
          totalPrice: deliveryFee,
          clientOfferedPrice: deliveryFee,
          clientName: store.name,
          createdAt: DateTime.now(),
          negotiationStatus: PriceNegotiationStatus.waiting_for_offers,
          isPurchaseRequired: false,
          notes: 'Store delivery from ${store.name}',
        );

        final matchResult = await SmartMatchingService.findMatchedDrivers(
          session,
          request: matchRequest,
          maxDrivers: 5,
        );

        if (matchResult.success && matchResult.hasMatches) {
          // Send targeted notifications to matched drivers
          final notificationEndpoint = NotificationEndpoint();
          int notificationsSent = 0;

          for (final driverUserId in matchResult.matchedDriverUserIds) {
            try {
              await notificationEndpoint.createNotification(
                session,
                userId: driverUserId,
                title: '🎯 Delivery Matched for You!',
                body: '${store.name} needs a driver - ${deliveryFee.toStringAsFixed(0)} MAD',
                type: NotificationType.delivery,
                relatedEntityId: created.id,
                relatedEntityType: 'StoreDeliveryRequest',
                data: {
                  'storeName': store.name,
                  'pickupAddress': store.address,
                  'deliveryFee': deliveryFee,
                  'requestId': created.id,
                  'match_type': 'smart_match',
                },
              );
              notificationsSent++;
            } catch (e) {
              session.log(
                '[StoreDelivery] Failed to notify matched driver $driverUserId: $e',
                level: LogLevel.warning,
              );
            }
          }

          session.log(
            '[StoreDelivery] ✅ Smart Match: Sent to $notificationsSent/${matchResult.count} matched drivers',
          );
        } else {
          // Fallback: broadcast to all nearby online drivers
          session.log(
            '[StoreDelivery] ⚠️ Smart Match ${matchResult.success ? "found 0 drivers" : "failed"} - falling back to geo-broadcast',
            level: LogLevel.warning,
          );
          await _broadcastToNearbyDrivers(session, store: store, deliveryFee: deliveryFee, created: created);
        }
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Smart Match exception - falling back to geo-broadcast: $e',
          level: LogLevel.warning,
        );
        try {
          await _broadcastToNearbyDrivers(session, store: store, deliveryFee: deliveryFee, created: created);
        } catch (broadcastError) {
          session.log(
            '[StoreDelivery] ⚠️ Fallback broadcast also failed: $broadcastError',
            level: LogLevel.warning,
          );
        }
      }

      return created;
    } catch (e) {
      session.log('Error posting delivery request: $e', level: LogLevel.error);
      rethrow;
    }
  }

  // ==================== DRIVER ACTIONS ====================

  /// Get available store delivery requests for driver
  Future<List<StoreDeliveryRequest>> getStoreDeliveryRequests(
    Session session, {
    required int driverId, // This is the User ID, not DriverProfile ID
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    try {
      final now = DateTime.now();

      // Get the driver's DriverProfile to match targetDriverId
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );
      final driverProfileId = driverProfile?.id;

      session.log(
        '[StoreDelivery] Getting requests for driver userId: $driverId, profileId: $driverProfileId',
      );

      // Get pending requests (both direct and public)
      final requests = await StoreDeliveryRequest.db.find(
        session,
        where: (t) => t.status.equals('pending'),
      );

      session.log(
        '[StoreDelivery] Found ${requests.length} pending requests',
      );

      // Filter by type and location
      final availableRequests = <StoreDeliveryRequest>[];
      for (final request in requests) {
        // Skip expired requests
        if (request.expiresAt != null && request.expiresAt!.isBefore(now)) {
          session.log(
            '[StoreDelivery] Skipping expired request ${request.id}',
          );
          continue;
        }

        // For direct requests, only show to target driver
        // Note: targetDriverId is DriverProfile.id, not User.id
        if (request.requestType == 'direct') {
          session.log(
            '[StoreDelivery] Direct request ${request.id}: targetDriverId=${request.targetDriverId}, driverProfileId=$driverProfileId',
          );
          if (driverProfileId != null &&
              request.targetDriverId == driverProfileId) {
            availableRequests.add(request);
            session.log('[StoreDelivery] ✅ Added direct request ${request.id}');
          }
          continue;
        }

        // For public requests, check distance
        final distance = _calculateDistance(
          latitude,
          longitude,
          request.pickupLatitude,
          request.pickupLongitude,
        );

        session.log(
          '[StoreDelivery] Public request ${request.id}: distance=${distance.toStringAsFixed(2)}km, radius=$radiusKm',
        );

        if (distance <= radiusKm) {
          availableRequests.add(request);
          session.log('[StoreDelivery] ✅ Added public request ${request.id}');
        }
      }

      // Sort by creation time (newest first)
      availableRequests.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      session.log(
        '[StoreDelivery] Returning ${availableRequests.length} available requests',
      );

      return availableRequests;
    } catch (e) {
      session.log('Error getting delivery requests: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Driver accepts a store delivery request
  Future<StoreOrder?> acceptStoreDelivery(
    Session session, {
    required int driverId, // This is User.id, not DriverProfile.id
    required int requestId,
  }) async {
    try {
      // Get the driver's DriverProfile to match targetDriverId
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );
      final driverProfileId = driverProfile?.id;

      session.log(
        '[StoreDelivery] Accept request: userId=$driverId, profileId=$driverProfileId, requestId=$requestId',
      );

      // Get the request
      final request = await StoreDeliveryRequest.db.findById(
        session,
        requestId,
      );
      if (request == null) {
        throw Exception('Request not found');
      }
      if (request.status != 'pending') {
        throw Exception('Request is no longer available');
      }

      // For direct requests, verify target driver (compare DriverProfile.id)
      if (request.requestType == 'direct' &&
          request.targetDriverId != driverProfileId) {
        session.log(
          '[StoreDelivery] Mismatch: targetDriverId=${request.targetDriverId}, driverProfileId=$driverProfileId',
          level: LogLevel.error,
        );
        throw Exception('This request was sent to another driver');
      }

      // Check expiry
      if (request.expiresAt != null &&
          request.expiresAt!.isBefore(DateTime.now())) {
        // Mark the request as expired in the database
        request.status = 'expired';
        await StoreDeliveryRequest.db.updateRow(session, request);
        session.log('[StoreDelivery] Request $requestId has expired');
        throw Exception('This delivery request has expired. Please ask the store to send a new request.');
      }

      // Update request - assignedDriverId should be User.id for tracking
      request.status = 'accepted';
      request.assignedDriverId = driverId; // User.id
      request.acceptedAt = DateTime.now();
      await StoreDeliveryRequest.db.updateRow(session, request);

      // Update order with driver assignment (use User.id as per schema)
      final order = await StoreOrder.db.findById(session, request.storeOrderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      order.driverId = driverId; // User.id as defined in store_order.yaml
      order.status = StoreOrderStatus.driverAssigned; // Update status to driverAssigned

      // Update timeline
      final timeline = _parseTimeline(order.timelineJson);
      timeline.add({
        'status': 'driver_assigned',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver assigned',
        'actor': 'driver',
        'driverId': driverId,
      });
      order.timelineJson = jsonEncode(timeline);

      final updatedOrder = await StoreOrder.db.updateRow(session, order);
      session.log('Driver $driverId assigned to order ${order.id}');

      // Get store and driver names for notifications
      final store = await Store.db.findById(session, request.storeId);
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';
      final storeName = store?.name ?? 'Store';

      // Send notification to store
      if (store?.userId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store!.userId,
            title: '🚗 Driver Accepted',
            body:
                '$driverName is on the way to pick up order #${order.orderNumber}',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'StoreOrder',
            data: {
              'orderId': order.id,
              'orderNumber': order.orderNumber,
              'status': 'driver_assigned',
              'driverName': driverName,
            },
          );
          session.log('[StoreDelivery] ✅ Notified store user ${store.userId}');
        } catch (e) {
          session.log(
            '[StoreDelivery] ⚠️ Failed to notify store: $e',
            level: LogLevel.warning,
          );
        }
      }

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: '🚗 Driver Assigned',
          body: '$driverName is picking up your order from $storeName',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'driver_assigned',
            'driverName': driverName,
          },
        );
        session.log('[StoreDelivery] ✅ Notified client user ${order.clientId}');
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify client: $e',
          level: LogLevel.warning,
        );
      }

      // Add driver to chat so they receive chat notifications
      try {
        await addDriverToChat(
          session,
          orderId: order.id!,
          driverId: driverId,
        );
        session.log('[StoreDelivery] ✅ Added driver $driverId to chat');
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to add driver to chat: $e',
          level: LogLevel.warning,
        );
      }

      return updatedOrder;
    } catch (e) {
      session.log('Error accepting delivery: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver rejects a store delivery request
  Future<bool> rejectStoreDelivery(
    Session session, {
    required int driverId, // This is User.id, not DriverProfile.id
    required int requestId,
    String? reason,
  }) async {
    try {
      // Get the driver's DriverProfile to match targetDriverId
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );
      final driverProfileId = driverProfile?.id;

      final request = await StoreDeliveryRequest.db.findById(
        session,
        requestId,
      );
      if (request == null) {
        throw Exception('Request not found');
      }

      // For direct requests, verify target driver (compare DriverProfile.id)
      if (request.requestType == 'direct' &&
          request.targetDriverId != driverProfileId) {
        throw Exception('Not authorized');
      }

      // Update request status
      request.status = 'rejected';
      request.rejectedAt = DateTime.now();
      await StoreDeliveryRequest.db.updateRow(session, request);

      session.log('Driver $driverId rejected request $requestId');

      // Notify store that driver rejected
      final store = await Store.db.findById(session, request.storeId);
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';

      if (store?.userId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store!.userId,
            title: '❌ Driver Declined',
            body:
                '$driverName declined your delivery request${reason != null ? ': $reason' : ''}',
            type: NotificationType.order,
            relatedEntityId: request.storeOrderId,
            relatedEntityType: 'StoreOrder',
            data: {
              'requestId': requestId,
              'storeOrderId': request.storeOrderId,
              'status': 'rejected',
              if (reason != null) 'reason': reason,
            },
          );
          session.log('[StoreDelivery] ✅ Notified store of rejection');
        } catch (e) {
          session.log(
            '[StoreDelivery] ⚠️ Failed to notify store: $e',
            level: LogLevel.warning,
          );
        }
      }

      return true;
    } catch (e) {
      session.log('Error rejecting delivery: $e', level: LogLevel.error);
      return false;
    }
  }

  // ==================== DELIVERY FLOW ====================

  /// Driver arrived at store for pickup
  Future<StoreOrder?> arrivedAtStore(
    Session session, {
    required int driverId, // This is User.id
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      // order.driverId is User.id, compare directly
      if (order.driverId != driverId) {
        session.log(
          '[StoreDelivery] Auth failed: order.driverId=${order.driverId}, driverId=$driverId',
        );
        throw Exception('Not authorized');
      }

      // Validate current status - accept both ready and driverAssigned
      if (order.status != StoreOrderStatus.ready &&
          order.status != StoreOrderStatus.driverAssigned) {
        throw Exception('Order must be ready or driver assigned for pickup');
      }

      // Update status - keep as pickedUp (driver arrived and ready to pick up)
      order.status = StoreOrderStatus.pickedUp;

      // Update timeline
      final timeline = _parseTimeline(order.timelineJson);
      timeline.add({
        'status': 'driver_at_store',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver arrived at store',
        'actor': 'driver',
      });
      order.timelineJson = jsonEncode(timeline);

      final updated = await StoreOrder.db.updateRow(session, order);
      session.log('Driver $driverId arrived at store for order $orderId');

      // Get store and driver names for notifications
      final store = await Store.db.findById(session, order.storeId);
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';

      // Send notification to store
      if (store?.userId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store!.userId,
            title: '📍 Driver Arrived',
            body:
                '$driverName has arrived to pick up order #${order.orderNumber}',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'StoreOrder',
            data: {
              'orderId': order.id,
              'orderNumber': order.orderNumber,
              'status': 'driver_at_store',
            },
          );
          session.log('[StoreDelivery] ✅ Notified store of driver arrival');
        } catch (e) {
          session.log(
            '[StoreDelivery] ⚠️ Failed to notify store: $e',
            level: LogLevel.warning,
          );
        }
      }

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: '📍 Driver at Store',
          body: '$driverName has arrived at the store to collect your order',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'driver_at_store',
          },
        );
        session.log(
          '[StoreDelivery] ✅ Notified client of driver arrival at store',
        );
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify client: $e',
          level: LogLevel.warning,
        );
      }

      return updated;
    } catch (e) {
      session.log('Error marking arrived at store: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver picked up order from store (and paid store)
  Future<StoreOrder?> pickedUp(
    Session session, {
    required int driverId, // This is User.id
    required int orderId,
    required double amountPaidToStore,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      // order.driverId is User.id, compare directly
      if (order.driverId != driverId) {
        session.log(
          '[StoreDelivery] Auth failed: order.driverId=${order.driverId}, driverId=$driverId',
        );
        throw Exception('Not authorized');
      }

      // Validate payment matches subtotal
      if (amountPaidToStore != order.subtotal) {
        session.log(
          'Warning: Amount paid ($amountPaidToStore) differs from subtotal (${order.subtotal})',
        );
      }

      // Update status
      order.status = StoreOrderStatus.pickedUp;
      order.pickedUpAt = DateTime.now();

      // Update timeline
      final timeline = _parseTimeline(order.timelineJson);
      timeline.add({
        'status': 'picked_up',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Order picked up from store',
        'actor': 'driver',
        'amountPaid': amountPaidToStore,
      });
      order.timelineJson = jsonEncode(timeline);

      final updated = await StoreOrder.db.updateRow(session, order);
      session.log('Order $orderId picked up by driver $driverId');

      // Get store and driver names for notifications
      final store = await Store.db.findById(session, order.storeId);
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';
      final storeName = store?.name ?? 'Store';

      // Send notification to store
      if (store?.userId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store!.userId,
            title: '📦 Order Picked Up',
            body: '$driverName has picked up order #${order.orderNumber}',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'StoreOrder',
            data: {
              'orderId': order.id,
              'orderNumber': order.orderNumber,
              'status': 'picked_up',
            },
          );
          session.log('[StoreDelivery] ✅ Notified store of pickup');
        } catch (e) {
          session.log(
            '[StoreDelivery] ⚠️ Failed to notify store: $e',
            level: LogLevel.warning,
          );
        }
      }

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: '🚗 Order On The Way!',
          body:
              '$driverName has picked up your order from $storeName and is heading to you',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'picked_up',
          },
        );
        session.log(
          '[StoreDelivery] ✅ Notified client that order is on the way',
        );
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify client: $e',
          level: LogLevel.warning,
        );
      }

      return updated;
    } catch (e) {
      session.log('Error marking picked up: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver arrived at client location
  Future<StoreOrder?> arrivedAtClient(
    Session session, {
    required int driverId, // This is User.id
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      // order.driverId is User.id, compare directly
      if (order.driverId != driverId) {
        session.log(
          '[StoreDelivery] Auth failed: order.driverId=${order.driverId}, driverId=$driverId',
        );
        throw Exception('Not authorized');
      }
      if (order.status != StoreOrderStatus.pickedUp) {
        throw Exception('Order must be picked up first');
      }

      // Update status
      order.status = StoreOrderStatus.inDelivery;

      // Update timeline
      final timeline = _parseTimeline(order.timelineJson);
      timeline.add({
        'status': 'driver_at_client',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver arrived at delivery location',
        'actor': 'driver',
      });
      order.timelineJson = jsonEncode(timeline);

      final updated = await StoreOrder.db.updateRow(session, order);
      session.log('Driver $driverId arrived at client for order $orderId');

      // Get driver name for notification
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: '📍 Driver Arrived!',
          body: '$driverName has arrived at your location with your order',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'driver_at_client',
          },
        );
        session.log('[StoreDelivery] ✅ Notified client of driver arrival');
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify client: $e',
          level: LogLevel.warning,
        );
      }

      return updated;
    } catch (e) {
      session.log('Error marking arrived at client: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver delivered order and collected cash
  Future<StoreOrder?> delivered(
    Session session, {
    required int driverId, // This is User.id
    required int orderId,
    required double amountCollected,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      // order.driverId is User.id, compare directly
      if (order.driverId != driverId) {
        session.log(
          '[StoreDelivery] Auth failed: order.driverId=${order.driverId}, driverId=$driverId',
        );
        throw Exception('Not authorized');
      }
      if (order.status != StoreOrderStatus.inDelivery &&
          order.status != StoreOrderStatus.pickedUp) {
        throw Exception('Order must be picked up first');
      }

      // Validate collected amount
      if (amountCollected != order.total) {
        session.log(
          'Warning: Amount collected ($amountCollected) differs from total (${order.total})',
        );
      }

      // Update status
      order.status = StoreOrderStatus.delivered;
      order.deliveredAt = DateTime.now();

      // Update timeline
      final timeline = _parseTimeline(order.timelineJson);
      timeline.add({
        'status': 'delivered',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Order delivered',
        'actor': 'driver',
        'amountCollected': amountCollected,
      });
      order.timelineJson = jsonEncode(timeline);

      final updated = await StoreOrder.db.updateRow(session, order);
      session.log('Order $orderId delivered by driver $driverId');

      // Record commission (driver pays platform)
      await _recordCommission(session, order, driverId);

      // Get store and driver names for notifications
      final store = await Store.db.findById(session, order.storeId);
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';
      final storeName = store?.name ?? 'Store';

      // Send notification to store
      if (store?.userId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store!.userId,
            title: '✅ Order Delivered!',
            body: 'Order #${order.orderNumber} has been delivered successfully',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'StoreOrder',
            data: {
              'orderId': order.id,
              'orderNumber': order.orderNumber,
              'status': 'delivered',
              'amountCollected': amountCollected,
            },
          );
          session.log('[StoreDelivery] ✅ Notified store of delivery');
        } catch (e) {
          session.log(
            '[StoreDelivery] ⚠️ Failed to notify store: $e',
            level: LogLevel.warning,
          );
        }
      }

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: '✅ Order Delivered!',
          body: 'Your order from $storeName has been delivered. Enjoy!',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'delivered',
          },
        );
        session.log('[StoreDelivery] ✅ Notified client of delivery');
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify client: $e',
          level: LogLevel.warning,
        );
      }

      // Send notification to driver (confirmation + earnings summary)
      try {
        // Get delivery request to get earnings
        final request = await StoreDeliveryRequest.db.findFirstRow(
          session,
          where: (t) =>
              t.storeOrderId.equals(orderId) &
              t.assignedDriverId.equals(driverId),
        );
        final earnings = request?.driverEarnings ?? 0.0;

        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: driverId,
          title: '💰 Delivery Complete!',
          body:
              'You earned ৳${earnings.toStringAsFixed(2)} for delivering order #${order.orderNumber}',
          type: NotificationType.delivery,
          relatedEntityId: order.id,
          relatedEntityType: 'StoreOrder',
          data: {
            'orderId': order.id,
            'orderNumber': order.orderNumber,
            'status': 'delivered',
            'earnings': earnings,
          },
        );
        session.log('[StoreDelivery] ✅ Notified driver of completion');
      } catch (e) {
        session.log(
          '[StoreDelivery] ⚠️ Failed to notify driver: $e',
          level: LogLevel.warning,
        );
      }

      return updated;
    } catch (e) {
      session.log('Error marking delivered: $e', level: LogLevel.error);
      rethrow;
    }
  }

  // ==================== 3-WAY CHAT ====================

  /// Create 3-way chat channel when driver is assigned
  Future<int?> createOrderChat(
    Session session, {
    required int orderId,
    required int clientId,
    required int storeId,
    required int driverId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      // Check if chat already exists
      if (order.chatId != null) {
        return order.chatId;
      }

      // Create chat
      final chat = StoreOrderChat(
        storeOrderId: orderId,
        clientId: clientId,
        storeId: storeId,
        driverId: driverId,
        firebaseChannelId: 'store_order_$orderId',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final createdChat = await StoreOrderChat.db.insertRow(session, chat);

      // Link chat to order
      order.chatId = createdChat.id;
      await StoreOrder.db.updateRow(session, order);

      // Send system message
      await StoreOrderChatMessage.db.insertRow(
        session,
        StoreOrderChatMessage(
          chatId: createdChat.id!,
          senderId: 0, // System
          senderRole: 'system',
          senderName: 'System',
          messageType: 'system',
          content:
              'Chat started for order ${order.orderNumber}. Driver has been assigned.',
          createdAt: DateTime.now(),
        ),
      );

      session.log('Created 3-way chat ${createdChat.id} for order $orderId');
      return createdChat.id;
    } catch (e) {
      session.log('Error creating order chat: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get or create store order chat (called when any party opens chat)
  Future<StoreOrderChat?> getOrCreateOrderChat(
    Session session, {
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      // Check if chat exists
      if (order.chatId != null) {
        final existingChat = await StoreOrderChat.db.findById(session, order.chatId!);
        if (existingChat != null) {
          // Auto-sync driver if order has driver but chat doesn't
          // This handles cases where driver was assigned before the addDriverToChat fix
          if (order.driverId != null && existingChat.driverId == null) {
            session.log(
              '[StoreOrderChat] Auto-syncing driver ${order.driverId} to chat ${existingChat.id}',
            );
            existingChat.driverId = order.driverId;
            existingChat.updatedAt = DateTime.now();
            await StoreOrderChat.db.updateRow(session, existingChat);
          }
          return existingChat;
        }
      }

      // Create chat without driver (driver joins later when assigned)
      final chat = StoreOrderChat(
        storeOrderId: orderId,
        clientId: order.clientId,
        storeId: order.storeId,
        driverId: order.driverId, // May be null
        firebaseChannelId: 'store_order_$orderId',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final createdChat = await StoreOrderChat.db.insertRow(session, chat);

      // Link chat to order
      order.chatId = createdChat.id;
      await StoreOrder.db.updateRow(session, order);

      // Send system message
      await StoreOrderChatMessage.db.insertRow(
        session,
        StoreOrderChatMessage(
          chatId: createdChat.id!,
          senderId: 0,
          senderRole: 'system',
          senderName: 'System',
          messageType: 'system',
          content: 'Chat started for order ${order.orderNumber}.',
          createdAt: DateTime.now(),
        ),
      );

      return createdChat;
    } catch (e) {
      session.log(
        'Error getting/creating order chat: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Send message to store order chat
  Future<StoreOrderChatMessage?> sendChatMessage(
    Session session, {
    required int orderId,
    required int senderId,
    required String senderRole,
    required String senderName,
    required String content,
    String messageType = 'text',
    String? attachmentUrl,
    double? latitude,
    double? longitude,
  }) async {
    try {
      // Get or create chat
      final chat = await getOrCreateOrderChat(session, orderId: orderId);
      if (chat == null) {
        throw Exception('Could not get chat');
      }

      // Create message
      final message = StoreOrderChatMessage(
        chatId: chat.id!,
        senderId: senderId,
        senderRole: senderRole,
        senderName: senderName,
        messageType: messageType,
        content: content,
        attachmentUrl: attachmentUrl,
        latitude: latitude,
        longitude: longitude,
        createdAt: DateTime.now(),
      );
      final created = await StoreOrderChatMessage.db.insertRow(
        session,
        message,
      );

      // Update chat timestamp
      chat.updatedAt = DateTime.now();
      await StoreOrderChat.db.updateRow(session, chat);

      // Send notifications to other participants
      await _sendChatNotifications(
        session,
        orderId: orderId,
        chat: chat,
        senderId: senderId,
        senderRole: senderRole,
        senderName: senderName,
        content: content,
        messageType: messageType,
      );

      return created;
    } catch (e) {
      session.log('Error sending chat message: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Send push notifications to chat participants
  Future<void> _sendChatNotifications(
    Session session, {
    required int orderId,
    required StoreOrderChat chat,
    required int senderId,
    required String senderRole,
    required String senderName,
    required String content,
    required String messageType,
  }) async {
    try {
      final notificationEndpoint = NotificationEndpoint();

      // Determine message preview based on type
      String messagePreview;
      switch (messageType) {
        case 'image':
          messagePreview = '📷 Sent an image';
          break;
        case 'audio':
          messagePreview = '🎤 Sent a voice message';
          break;
        case 'location':
          messagePreview = '📍 Shared a location';
          break;
        default:
          messagePreview = content.length > 50
              ? '${content.substring(0, 50)}...'
              : content;
      }

      // Get order info for the notification
      final order = await StoreOrder.db.findById(session, orderId);
      final orderNumber = order?.orderNumber ?? 'Order';

      // List of recipients (exclude sender)
      final recipients = <int>[];

      session.log(
        '[StoreOrderChat] Building recipients - senderId: $senderId, senderRole: $senderRole',
      );
      session.log(
        '[StoreOrderChat] Chat info - clientId: ${chat.clientId}, storeId: ${chat.storeId}, driverId: ${chat.driverId}',
      );

      // Add client if sender is not client
      if (senderRole != 'client' && chat.clientId != senderId) {
        recipients.add(chat.clientId);
        session.log(
          '[StoreOrderChat] Added client ${chat.clientId} to recipients',
        );
      }

      // Add store owner if sender is not store
      // Note: chat.storeId is the Store record ID, not the user ID
      // We need to fetch the store to get the owner's userId
      if (senderRole != 'store') {
        final store = await Store.db.findById(session, chat.storeId);
        if (store != null && store.userId != senderId) {
          recipients.add(store.userId);
          session.log(
            '[StoreOrderChat] Added store owner ${store.userId} to recipients',
          );
        }
      }

      // Add driver if assigned and sender is not driver
      // Check both chat.driverId and order.driverId for robustness
      int? effectiveDriverId = chat.driverId ?? order?.driverId;
      if (senderRole != 'driver' &&
          effectiveDriverId != null &&
          effectiveDriverId != senderId) {
        recipients.add(effectiveDriverId);
        session.log(
          '[StoreOrderChat] Added driver $effectiveDriverId to recipients',
        );
        
        // Auto-sync driver to chat if it was missing
        if (chat.driverId == null && order?.driverId != null) {
          session.log('[StoreOrderChat] Auto-syncing driver to chat');
          chat.driverId = order!.driverId;
          chat.updatedAt = DateTime.now();
          await StoreOrderChat.db.updateRow(session, chat);
        }
      }

      // Remove duplicates (in case same user has multiple roles)
      final uniqueRecipients = recipients.toSet().toList();
      session.log('[StoreOrderChat] Sending notifications to: $uniqueRecipients (deduped from $recipients)');

      // Send notification to each recipient
      for (final recipientId in uniqueRecipients) {
        try {
          await notificationEndpoint.createNotification(
            session,
            userId: recipientId,
            title: '$senderName ($orderNumber)',
            body: messagePreview,
            type: NotificationType.message,
            relatedEntityId: orderId,
            relatedEntityType: 'store_order_chat',
            data: {
              'orderId': orderId.toString(),
              'chatId': chat.id.toString(),
              'senderId': senderId.toString(),
              'senderRole': senderRole,
              'senderName': senderName,
              'messageType': messageType,
              'type': 'store_order_chat',
            },
          );
          session.log(
            '[StoreOrderChat] Notification sent to user $recipientId',
          );
        } catch (e) {
          session.log(
            '[StoreOrderChat] Failed to send notification to $recipientId: $e',
            level: LogLevel.warning,
          );
        }
      }
    } catch (e) {
      session.log(
        '[StoreOrderChat] Error sending notifications: $e',
        level: LogLevel.warning,
      );
    }
  }

  /// Get chat messages for order
  Future<List<StoreOrderChatMessage>> getChatMessages(
    Session session, {
    required int orderId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null || order.chatId == null) {
        return [];
      }

      return await StoreOrderChatMessage.db.find(
        session,
        where: (t) => t.chatId.equals(order.chatId!),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting chat messages: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get chat participants info (names) for order
  Future<ChatParticipantsInfo?> getChatParticipantsInfo(
    Session session, {
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        return null;
      }

      // Get client info
      final client = await User.db.findById(session, order.clientId);
      final clientName = client?.fullName ?? 'Client';

      // Get store info
      final store = await Store.db.findById(session, order.storeId);
      final storeName = store?.name ?? 'Store';

      // Get driver info if assigned
      String? driverName;
      if (order.driverId != null) {
        final driver = await User.db.findById(session, order.driverId!);
        driverName = driver?.fullName ?? 'Driver';
      }

      return ChatParticipantsInfo(
        clientId: order.clientId,
        clientName: clientName,
        storeId: order.storeId,
        storeName: storeName,
        driverId: order.driverId,
        driverName: driverName,
      );
    } catch (e) {
      session.log(
        'Error getting chat participants info: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  /// Add driver to existing chat when assigned
  Future<bool> addDriverToChat(
    Session session, {
    required int orderId,
    required int driverId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null || order.chatId == null) {
        return false;
      }

      final chat = await StoreOrderChat.db.findById(session, order.chatId!);
      if (chat == null) {
        return false;
      }

      chat.driverId = driverId;
      chat.updatedAt = DateTime.now();
      await StoreOrderChat.db.updateRow(session, chat);

      // Get driver name
      final driver = await User.db.findById(session, driverId);
      final driverName = driver?.fullName ?? 'Driver';

      // Send system message
      await StoreOrderChatMessage.db.insertRow(
        session,
        StoreOrderChatMessage(
          chatId: chat.id!,
          senderId: 0,
          senderRole: 'system',
          senderName: 'System',
          messageType: 'system',
          content: '$driverName has joined the chat.',
          createdAt: DateTime.now(),
        ),
      );

      return true;
    } catch (e) {
      session.log('Error adding driver to chat: $e', level: LogLevel.error);
      return false;
    }
  }

  // ==================== STORE ORDER QUERIES ====================

  /// Get driver's active store deliveries
  Future<List<StoreOrder>> getDriverStoreOrders(
    Session session, {
    required int driverId,
    bool activeOnly = true,
  }) async {
    try {
      if (activeOnly) {
        final orders = await StoreOrder.db.find(
          session,
          where: (t) => t.driverId.equals(driverId),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );

        return orders
            .where(
              (o) =>
                  o.status != StoreOrderStatus.delivered &&
                  o.status != StoreOrderStatus.cancelled &&
                  o.status != StoreOrderStatus.rejected,
            )
            .toList();
      }

      return await StoreOrder.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log(
        'Error getting driver store orders: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }

  /// Get request status for an order
  Future<StoreDeliveryRequest?> getOrderDeliveryRequest(
    Session session, {
    required int orderId,
  }) async {
    try {
      return await StoreDeliveryRequest.db.findFirstRow(
        session,
        where: (t) => t.storeOrderId.equals(orderId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log(
        'Error getting order delivery request: $e',
        level: LogLevel.error,
      );
      return null;
    }
  }

  // ==================== PRIVATE HELPERS ====================

  List<Map<String, dynamic>> _parseTimeline(String? timelineJson) {
    if (timelineJson == null || timelineJson.isEmpty) {
      return [];
    }
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(timelineJson));
    } catch (_) {
      return [];
    }
  }

  Future<void> _recordCommission(
    Session session,
    StoreOrder order,
    int driverId,
  ) async {
    try {
      // Create transaction record for commission
      final commissionTx = Transaction(
        userId: driverId,
        type: TransactionType.commission,
        amount: order.platformCommission,
        description: 'Store order commission: ${order.orderNumber}',
        platformCommission: order.platformCommission,
        createdAt: DateTime.now(),
      );
      await Transaction.db.insertRow(session, commissionTx);

      // Create earnings transaction
      final earningsTx = Transaction(
        userId: driverId,
        type: TransactionType.earning,
        amount: order.driverEarnings,
        description: 'Store delivery earnings: ${order.orderNumber}',
        driverEarnings: order.driverEarnings,
        createdAt: DateTime.now(),
      );
      await Transaction.db.insertRow(session, earningsTx);

      session.log('Commission recorded for order ${order.orderNumber}');
    } catch (e) {
      session.log('Error recording commission: $e', level: LogLevel.error);
    }
  }

  /// Fallback: broadcast delivery notification to all nearby online drivers (legacy geo-filter)
  Future<void> _broadcastToNearbyDrivers(
    Session session, {
    required Store store,
    required double deliveryFee,
    required StoreDeliveryRequest created,
  }) async {
    final nearbyDrivers = await DriverProfile.db.find(
      session,
      where: (t) => t.isOnline.equals(true),
    );

    const radiusKm = 15.0;
    final notificationEndpoint = NotificationEndpoint();
    int notificationsSent = 0;

    for (final driver in nearbyDrivers) {
      if (driver.lastLocationLat != null && driver.lastLocationLng != null) {
        final distance = _calculateDistance(
          store.latitude,
          store.longitude,
          driver.lastLocationLat!,
          driver.lastLocationLng!,
        );

        if (distance <= radiusKm) {
          try {
            await notificationEndpoint.createNotification(
              session,
              userId: driver.userId,
              title: '📦 New Delivery Available',
              body: '${store.name} needs a driver - ${deliveryFee.toStringAsFixed(0)} MAD',
              type: NotificationType.delivery,
              relatedEntityId: created.id,
              relatedEntityType: 'StoreDeliveryRequest',
              data: {
                'storeName': store.name,
                'pickupAddress': store.address,
                'deliveryFee': deliveryFee,
                'distance': distance.toStringAsFixed(1),
                'requestId': created.id,
              },
            );
            notificationsSent++;
          } catch (e) {
            session.log(
              '[StoreDelivery] Failed to notify driver ${driver.userId}: $e',
              level: LogLevel.warning,
            );
          }
        }
      }
    }

    session.log(
      '[StoreDelivery] ✅ Fallback broadcast sent to $notificationsSent nearby drivers',
    );
  }

  /// Calculate distance between two points using Haversine formula
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371.0; // km

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }
}

/// Helper class for sorting drivers with distance
class _DriverWithDistance {
  final DriverProfile driver;
  final double? distance;
  final bool hasLiveLocation;

  _DriverWithDistance(this.driver, this.distance, this.hasLiveLocation);
}
