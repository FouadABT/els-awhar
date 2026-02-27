import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'dart:io';
import '../generated/protocol.dart';

/// Service for sending push notifications via Firebase Cloud Messaging
/// Uses FCM HTTP v1 API with service account authentication
class NotificationService {
  static String? _projectId;
  static ServiceAccountCredentials? _credentials;
  static const _fcmScope = 'https://www.googleapis.com/auth/firebase.messaging';

  /// Initialize Firebase Admin SDK
  /// Call this once during server startup
  static Future<void> initialize(Session session) async {
    try {
      // Load service account credentials from config file
      final serviceAccountPath = 'config/awhar-5afc5-firebase-adminsdk-fbsvc-7175139fdc.json';
      final file = File(serviceAccountPath);
      
      if (!file.existsSync()) {
        session.log(
          '[NotificationService] ⚠️ Service account file not found at: $serviceAccountPath',
          level: LogLevel.warning,
        );
        session.log(
          '[NotificationService] ⚠️ Notifications will be logged but not sent',
          level: LogLevel.warning,
        );
        return;
      }

      final serviceAccountJson = jsonDecode(await file.readAsString());
      _projectId = serviceAccountJson['project_id'];
      _credentials = ServiceAccountCredentials.fromJson(serviceAccountJson);
      
      session.log('[NotificationService] ✅ Notification service initialized (FCM HTTP v1 API)', level: LogLevel.info);
      session.log('[NotificationService] 📱 Project ID: $_projectId', level: LogLevel.info);
    } catch (e) {
      session.log('[NotificationService] ❌ Failed to initialize: $e', level: LogLevel.error);
      // Don't throw - allow server to start even if notifications fail
    }
  }

  /// Send notification to a single user
  static Future<bool> sendToUser(
    Session session, {
    required int userId,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      // Get user's FCM token
      final user = await User.db.findById(session, userId);

      if (user == null || user.fcmToken == null || user.fcmToken!.isEmpty) {
        session.log('[NotificationService] ⚠️ User $userId has no FCM token', level: LogLevel.warning);
        return false;
      }

      if (!user.notificationsEnabled) {
        session.log('[NotificationService] ⚠️ User $userId has notifications disabled', level: LogLevel.info);
        return false;
      }

      return await _sendNotification(
        session,
        token: user.fcmToken!,
        title: title,
        body: body,
        data: data,
      );
    } catch (e) {
      session.log('[NotificationService] ❌ Error sending to user $userId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Send notification to multiple users
  static Future<int> sendToUsers(
    Session session, {
    required List<int> userIds,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    int successCount = 0;

    for (final userId in userIds) {
      final success = await sendToUser(
        session,
        userId: userId,
        title: title,
        body: body,
        data: data,
      );

      if (success) successCount++;
    }

    session.log('[NotificationService] Sent $successCount/${userIds.length} notifications', level: LogLevel.info);
    return successCount;
  }

  /// Internal method to send notification via FCM
  static Future<bool> _sendNotification(
    Session session, {
    required String token,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      // Check if FCM is configured
      if (_credentials == null || _projectId == null) {
        session.log(
          '[NotificationService] ⚠️ FCM not configured, logging notification instead',
          level: LogLevel.warning,
        );
        session.log(
          '[NotificationService] 📬 Title: $title, Body: $body',
          level: LogLevel.info,
        );
        return false;
      }

      // Get OAuth2 access token
      final client = await clientViaServiceAccount(_credentials!, [_fcmScope]);
      final accessToken = client.credentials.accessToken.data;
      client.close();

      // Construct FCM v1 API endpoint
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
      );

      // Construct FCM message
      final message = {
        'message': {
          'token': token,
          'notification': {
            'title': title,
            'body': body,
          },
          if (data != null) 'data': data,
          'android': {
            'priority': 'high',
            'notification': {
              'sound': 'default',
              'channel_id': 'awhar_notifications',
            },
          },
          'apns': {
            'payload': {
              'aps': {
                'sound': 'default',
                'badge': 1,
              },
            },
          },
        },
      };

      // Send FCM request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        session.log(
          '[NotificationService] ✅ Notification sent successfully',
          level: LogLevel.info,
        );
        return true;
      } else {
        session.log(
          '[NotificationService] ❌ FCM API error (${response.statusCode}): ${response.body}',
          level: LogLevel.error,
        );
        return false;
      }
    } catch (e) {
      session.log('[NotificationService] ❌ Failed to send: $e', level: LogLevel.error);
      return false;
    }
  }

  // ==================== Notification Triggers ====================

  /// Notify client that a driver wants to take their request (awaiting approval)
  static Future<void> notifyDriverProposed(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    session.log('[NotificationService] 🔔 Preparing driver proposal notification');
    session.log('[NotificationService]   Client ID: ${request.clientId}');
    session.log('[NotificationService]   Driver: ${driver.fullName} (ID: ${driver.id})');
    session.log('[NotificationService]   Request ID: ${request.id}');
    
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'Driver Available! 🚗',
      body: '${driver.fullName} wants to take your request. Review & accept?',
      data: {
        'type': 'driver_proposed',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
        'driver_name': driver.fullName,
        'driver_phone': driver.phoneNumber ?? '',
        'action': 'review_driver', // Action for notification tap
      },
    );
    
    session.log('[NotificationService] ✅ Driver proposal notification queued');
  }

  /// Notify driver that they received a catalog request from a client
  static Future<void> notifyCatalogRequest(
    Session session, {
    required ServiceRequest request,
    required User client,
    required User driver,
  }) async {
    session.log('[NotificationService] 🔔 Preparing catalog request notification');
    session.log('[NotificationService]   Driver ID: ${driver.id}');
    session.log('[NotificationService]   Client: ${client.fullName} (ID: ${client.id})');
    session.log('[NotificationService]   Request ID: ${request.id}');
    session.log('[NotificationService]   Service Type: ${request.serviceType}');
    
    final serviceTypeName = request.serviceType.toString().split('.').last;
    final price = request.clientOfferedPrice ?? request.totalPrice;
    
    await sendToUser(
      session,
      userId: driver.id!,
      title: 'New Catalog Request! 🔔',
      body: '${client.fullName} wants your $serviceTypeName service for ${price.toStringAsFixed(0)} MAD',
      data: {
        'type': 'catalog_request',
        'request_id': request.id.toString(),
        'client_id': client.id.toString(),
        'client_name': client.fullName,
        'client_phone': client.phoneNumber ?? '',
        'service_type': serviceTypeName,
        'price': price.toString(),
        'catalog_service_id': request.catalogServiceId?.toString() ?? '',
        'action': 'review_catalog_request',
      },
    );
    
    session.log('[NotificationService] ✅ Catalog request notification queued');
  }

  /// Notify driver that client approved them
  static Future<void> notifyDriverApproved(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: driver.id!,
      title: '✅ Request Accepted!',
      body: '${request.clientName} accepted you. Start the service!',
      data: {
        'type': 'driver_approved',
        'request_id': request.id.toString(),
        'client_id': request.clientId.toString(),
      },
    );
  }

  /// Notify driver that client rejected them
  static Future<void> notifyDriverRejected(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: driver.id!,
      title: 'Request Not Accepted',
      body: 'The client chose another driver for this request.',
      data: {
        'type': 'driver_rejected',
        'request_id': request.id.toString(),
      },
    );
  }

  /// Notify client that driver accepted their request (legacy - after approval)
  static Future<void> notifyRequestAccepted(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'Driver Assigned',
      body: '${driver.fullName} is on the way to pick you up',
      data: {
        'type': 'request_accepted',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify client that driver is arriving
  static Future<void> notifyDriverArriving(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'Driver Arriving',
      body: '${driver.fullName} will arrive in 2 minutes',
      data: {
        'type': 'driver_arriving',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify client that service has started
  static Future<void> notifyServiceStarted(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'Service Started',
      body: '${driver.fullName} has started your delivery',
      data: {
        'type': 'service_started',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify client that service is completed
  static Future<void> notifyServiceCompleted(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'Service Completed',
      body: 'Your delivery is complete. Please rate your experience!',
      data: {
        'type': 'service_completed',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify driver that request was cancelled by client
  static Future<void> notifyRequestCancelled(
    Session session, {
    required ServiceRequest request,
    required int driverId,
  }) async {
    await sendToUser(
      session,
      userId: driverId,
      title: 'Request Cancelled',
      body: 'The client has cancelled the request',
      data: {
        'type': 'request_cancelled',
        'request_id': request.id.toString(),
      },
    );
  }

  /// Notify nearby drivers of new request (broadcast to area)
  /// This would require storing driver locations in database
  /// For MVP, we can skip this and rely on polling
  static Future<void> notifyNearbyDrivers(
    Session session, {
    required ServiceRequest request,
    required List<int> nearbyDriverIds,
  }) async {
    await sendToUsers(
      session,
      userIds: nearbyDriverIds,
      title: 'New Request Available',
      body: 'Pickup from ${request.pickupLocation?.address ?? "nearby location"}',
      data: {
        'type': 'new_request',
        'request_id': request.id.toString(),
      },
    );
  }

  /// Notify user of new chat message
  static Future<void> notifyChatMessage(
    Session session, {
    required int recipientUserId,
    required String senderName,
    required String messageText,
    required int requestId,
    required int senderId,
  }) async {
    // Truncate message if too long
    final truncatedMessage = messageText.length > 100
        ? '${messageText.substring(0, 100)}...'
        : messageText;

    await sendToUser(
      session,
      userId: recipientUserId,
      title: senderName,
      body: truncatedMessage,
      data: {
        'type': 'chat_message',
        'request_id': requestId.toString(),
        'sender_id': senderId.toString(),
      },
    );
  }

  /// Notify client that a driver submitted a proposal
  static Future<void> notifyNewProposal(
    Session session, {
    required ServiceRequest request,
    required User driver,
    required int estimatedArrival,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'New Driver Proposal',
      body: '${driver.fullName} can arrive in $estimatedArrival min${estimatedArrival == 1 ? "" : "s"}',
      data: {
        'type': 'new_proposal',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify driver that client accepted their proposal
  static Future<void> notifyProposalAccepted(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: driver.id!,
      title: 'Proposal Accepted!',
      body: 'Client accepted your proposal. Head to pickup location.',
      data: {
        'type': 'proposal_accepted',
        'request_id': request.id.toString(),
      },
    );
  }

  // ==================== NEGOTIATION NOTIFICATIONS ====================

  /// Notify client that driver sent a counter-offer
  static Future<void> notifyDriverCounterOffer(
    Session session, {
    required ServiceRequest request,
    required User driver,
    required double counterPrice,
    String? message,
  }) async {
    final clientPrice = request.clientOfferedPrice ?? request.totalPrice;
    final priceDiff = counterPrice - clientPrice;
    final diffText = priceDiff > 0 ? '+${priceDiff.toStringAsFixed(0)}' : priceDiff.toStringAsFixed(0);

    await sendToUser(
      session,
      userId: request.clientId,
      title: '${driver.fullName} sent you an offer',
      body: 'Counter-offer: ${counterPrice.toStringAsFixed(0)} MAD ($diffText MAD)',
      data: {
        'type': 'driver_counter_offer',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
        'counter_price': counterPrice.toString(),
        'client_price': clientPrice.toString(),
        'message': message ?? '',
      },
    );
  }

  /// Notify client that driver accepted their offered price
  static Future<void> notifyDriverAcceptedPrice(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    final price = request.clientOfferedPrice ?? request.totalPrice;

    await sendToUser(
      session,
      userId: request.clientId,
      title: '${driver.fullName} accepted your price!',
      body: '${driver.fullName} is on the way for ${price.toStringAsFixed(0)} MAD',
      data: {
        'type': 'driver_accepted_price',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
        'agreed_price': price.toString(),
      },
    );
  }

  /// Notify driver that client accepted their counter-offer
  static Future<void> notifyClientAcceptedOffer(
    Session session, {
    required ServiceRequest request,
    required User client,
    required double agreedPrice,
  }) async {
    await sendToUser(
      session,
      userId: request.driverId!,
      title: 'Offer accepted!',
      body: '${client.fullName} accepted your offer of ${agreedPrice.toStringAsFixed(0)} MAD',
      data: {
        'type': 'client_accepted_offer',
        'request_id': request.id.toString(),
        'client_id': client.id.toString(),
        'agreed_price': agreedPrice.toString(),
      },
    );
  }

  /// Notify driver that client rejected their counter-offer
  static Future<void> notifyClientRejectedOffer(
    Session session, {
    required ServiceRequest request,
    required int driverId,
    String? reason,
  }) async {
    await sendToUser(
      session,
      userId: driverId,
      title: 'Offer declined',
      body: 'Client declined your offer. Request is available again.',
      data: {
        'type': 'client_rejected_offer',
        'request_id': request.id.toString(),
        'reason': reason ?? '',
      },
    );
  }

  /// Notify client that their request has new offers available
  static Future<void> notifyNewOfferReceived(
    Session session, {
    required ServiceRequest request,
    required User driver,
  }) async {
    await sendToUser(
      session,
      userId: request.clientId,
      title: 'New offer received',
      body: '${driver.fullName} sent you an offer. Tap to review.',
      data: {
        'type': 'new_offer_received',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
      },
    );
  }

  /// Notify both parties that price negotiation succeeded
  static Future<void> notifyNegotiationSuccess(
    Session session, {
    required ServiceRequest request,
    required User client,
    required User driver,
    required double agreedPrice,
  }) async {
    // Notify client
    await sendToUser(
      session,
      userId: client.id!,
      title: 'Price agreed!',
      body: '${driver.fullName} will provide service for ${agreedPrice.toStringAsFixed(0)} MAD',
      data: {
        'type': 'negotiation_success',
        'request_id': request.id.toString(),
        'driver_id': driver.id.toString(),
        'agreed_price': agreedPrice.toString(),
      },
    );

    // Notify driver
    await sendToUser(
      session,
      userId: driver.id!,
      title: 'Price agreed!',
      body: 'Service confirmed for ${agreedPrice.toStringAsFixed(0)} MAD',
      data: {
        'type': 'negotiation_success',
        'request_id': request.id.toString(),
        'client_id': client.id.toString(),
        'agreed_price': agreedPrice.toString(),
      },
    );
  }

  // ==================== BROADCAST NOTIFICATIONS ====================

  /// Notify ALL active drivers about a new service request
  /// Used for concierge/general requests to broadcast to all available drivers
  /// For testing: Disabled nearby filter - sends to ALL drivers
  static Future<int> notifyAllDrivers(
    Session session, {
    required ServiceRequest request,
    required User client,
  }) async {
    try {
      session.log('[NotificationService] 📢 Broadcasting new request to ALL drivers...');

      // Get ALL driver profiles (no nearby filter for testing)
      final allDriverProfiles = await DriverProfile.db.find(
        session,
        where: (t) => t.isVerified.equals(true),
      );

      if (allDriverProfiles.isEmpty) {
        session.log('[NotificationService] ⚠️ No verified drivers found to notify');
        return 0;
      }

      session.log('[NotificationService] 📋 Found ${allDriverProfiles.length} verified drivers');

      // Get user IDs for all drivers
      final driverUserIds = allDriverProfiles.map((p) => p.userId).toList();

      // Build notification content
      final serviceTypeDisplay = _getServiceTypeDisplayName(request.serviceType);
      final priceText = request.clientOfferedPrice != null 
          ? '${request.clientOfferedPrice!.toStringAsFixed(0)} ${request.currencySymbol}'
          : 'Make an offer';
      
      final locationText = request.pickupLocation?.address ?? 
                          request.destinationLocation.address ?? 
                          'See details';

      // Send FCM push notification to all drivers
      final successCount = await sendToUsers(
        session,
        userIds: driverUserIds,
        title: '🆕 New $serviceTypeDisplay Request!',
        body: '$priceText • ${client.fullName} • $locationText',
        data: {
          'type': 'new_service_request',
          'request_id': request.id.toString(),
          'client_id': request.clientId.toString(),
          'service_type': request.serviceType.name,
          'offered_price': request.clientOfferedPrice?.toString() ?? '',
        },
      );

      // Create in-app notification records for each driver
      int inAppCount = 0;
      for (final driverUserId in driverUserIds) {
        try {
          await UserNotification.db.insertRow(
            session,
            UserNotification(
              userId: driverUserId,
              title: '🆕 New $serviceTypeDisplay Request!',
              body: '$priceText • ${client.fullName} • $locationText',
              type: NotificationType.order,
              relatedEntityId: request.id,
              relatedEntityType: 'service_request',
              dataJson: jsonEncode({
                'type': 'new_service_request',
                'request_id': request.id.toString(),
                'client_id': request.clientId.toString(),
                'service_type': request.serviceType.name,
                'offered_price': request.clientOfferedPrice?.toString() ?? '',
              }),
              isRead: false,
            ),
          );
          inAppCount++;
        } catch (e) {
          session.log(
            '[NotificationService] ⚠️ Failed to create in-app notification for driver $driverUserId: $e',
            level: LogLevel.warning,
          );
        }
      }

      session.log('[NotificationService] ✅ Broadcast: FCM=$successCount, InApp=$inAppCount / ${driverUserIds.length} drivers');
      return successCount;
    } catch (e) {
      session.log('[NotificationService] ❌ Error broadcasting to drivers: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Notify a specific list of AI-matched drivers about a new service request.
  ///
  /// Unlike [notifyAllDrivers] which broadcasts blindly, this sends
  /// targeted notifications only to drivers selected by the awhar-match
  /// Kibana Agent Builder agent.
  ///
  /// [driverUserIds] - User IDs of matched drivers (NOT profile IDs)
  /// [matchExplanation] - Optional AI explanation to include in notification data
  static Future<int> notifyMatchedDrivers(
    Session session, {
    required ServiceRequest request,
    required User client,
    required List<int> driverUserIds,
    String? matchExplanation,
  }) async {
    try {
      if (driverUserIds.isEmpty) {
        session.log('[NotificationService] ⚠️ No matched driver IDs provided');
        return 0;
      }

      session.log(
        '[NotificationService] 🎯 Smart Match: Sending targeted notifications to ${driverUserIds.length} matched drivers',
      );

      final serviceTypeDisplay = _getServiceTypeDisplayName(request.serviceType);
      final priceText = request.clientOfferedPrice != null
          ? '${request.clientOfferedPrice!.toStringAsFixed(0)} ${request.currencySymbol}'
          : 'Make an offer';

      final locationText = request.pickupLocation?.address ??
          request.destinationLocation.address ??
          'See details';

      final successCount = await sendToUsers(
        session,
        userIds: driverUserIds,
        title: '🎯 New $serviceTypeDisplay - Matched for You!',
        body: '$priceText • ${client.fullName} • $locationText',
        data: {
          'type': 'new_service_request',
          'request_id': request.id.toString(),
          'client_id': request.clientId.toString(),
          'service_type': request.serviceType.name,
          'offered_price': request.clientOfferedPrice?.toString() ?? '',
          'match_type': 'smart_match',
        },
      );

      // Create in-app notification records for each matched driver
      int inAppCount = 0;
      for (final driverUserId in driverUserIds) {
        try {
          await UserNotification.db.insertRow(
            session,
            UserNotification(
              userId: driverUserId,
              title: '🎯 New $serviceTypeDisplay - Matched for You!',
              body: '$priceText • ${client.fullName} • $locationText',
              type: NotificationType.order,
              relatedEntityId: request.id,
              relatedEntityType: 'service_request',
              dataJson: jsonEncode({
                'type': 'new_service_request',
                'request_id': request.id.toString(),
                'client_id': request.clientId.toString(),
                'service_type': request.serviceType.name,
                'offered_price': request.clientOfferedPrice?.toString() ?? '',
                'match_type': 'smart_match',
              }),
              isRead: false,
            ),
          );
          inAppCount++;
        } catch (e) {
          session.log(
            '[NotificationService] ⚠️ Failed to create in-app notification for matched driver $driverUserId: $e',
            level: LogLevel.warning,
          );
        }
      }

      session.log(
        '[NotificationService] ✅ Smart Match: FCM=$successCount, InApp=$inAppCount / ${driverUserIds.length} drivers',
      );
      return successCount;
    } catch (e) {
      session.log(
        '[NotificationService] ❌ Error sending matched notifications: $e',
        level: LogLevel.error,
      );
      return 0;
    }
  }

  /// Helper to get display name for service type
  static String _getServiceTypeDisplayName(ServiceType type) {
    switch (type) {
      case ServiceType.ride:
        return 'Ride';
      case ServiceType.delivery:
        return 'Delivery';
      case ServiceType.purchase:
        return 'Buy & Bring';
      case ServiceType.task:
        return 'Errand';
      case ServiceType.moving:
        return 'Moving';
      case ServiceType.other:
        return 'Service';
    }
  }
}

