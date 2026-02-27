import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import '../controllers/auth_controller.dart';
import '../controllers/request_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/conversations_controller.dart';
import '../controllers/proposal_controller.dart';
import '../controllers/store_order_controller.dart';
import '../models/app_notification.dart';
import '../services/request_service.dart';
import '../utils/currency_helper.dart';
import '../../shared/widgets/proposal_notification_card.dart';
import '../../shared/widgets/driver_proposal_notification.dart';
import '../../screens/client/driver_review_screen.dart';
import '../../elasticsearch/screens/ai_matching_screen.dart';

/// Service for handling push notifications with Firebase Cloud Messaging
class NotificationService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _storage = GetStorage();
  final RxString fcmToken = ''.obs;
  final RxBool permissionGranted = false.obs;

  static const String _fcmTokenKey = 'fcm_token';

  // Track last notification time for smart grouping
  final Map<String, DateTime> _lastNotificationTime = {};
  final Map<String, int> _notificationCount = {};
  static const Duration _groupingThreshold = Duration(seconds: 10);

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  /// Initialize Firebase Messaging and request permissions
  Future<void> _initializeNotifications() async {
    try {
      // Request permission
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      permissionGranted.value =
          settings.authorizationStatus == AuthorizationStatus.authorized;

      if (!permissionGranted.value) {
        print('[NotificationService] ❌ Permission denied');
        return;
      }

      print('[NotificationService] ✅ Permission granted');

      // Get FCM token
      await _getFCMToken();

      // Listen to token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        print('[NotificationService] 🔄 Token refreshed');
        _updateFCMToken(newToken);
      });

      // Setup message handlers
      _setupMessageHandlers();
    } catch (e) {
      print('[NotificationService] ❌ Error initializing: $e');
    }
  }

  /// Get FCM token from Firebase
  Future<void> _getFCMToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        fcmToken.value = token;
        _storage.write(_fcmTokenKey, token);
        print(
          '[NotificationService] 📱 FCM Token: ${token.substring(0, 20)}...',
        );

        // Send to backend if user is logged in
        await _sendTokenToBackend(token);
      }
    } catch (e) {
      print('[NotificationService] ❌ Error getting token: $e');
    }
  }

  /// Send FCM token to backend
  Future<void> _sendTokenToBackend(String token) async {
    try {
      final authController = Get.find<AuthController>();
      if (authController.currentUser.value == null) {
        print(
          '[NotificationService] ⚠️ User not logged in, skipping token update',
        );
        return;
      }

      final client = Get.find<Client>();
      final userId = authController.currentUser.value!.id!;
      await client.user.updateFCMToken(userId: userId, fcmToken: token);
      print('[NotificationService] ✅ Token sent to backend');
    } catch (e) {
      print('[NotificationService] ❌ Error sending token to backend: $e');
    }
  }

  /// Update FCM token (called on token refresh or login)
  Future<void> _updateFCMToken(String token) async {
    fcmToken.value = token;
    _storage.write(_fcmTokenKey, token);
    await _sendTokenToBackend(token);
  }

  /// Clear FCM token from backend on logout
  /// This prevents the old user from receiving notifications after logout
  Future<void> clearFCMToken() async {
    try {
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;

      if (userId == null) {
        print('[NotificationService] ⚠️ No user ID, skipping FCM token clear');
        return;
      }

      final client = Get.find<Client>();
      final success = await client.user.clearFCMToken(userId: userId);

      if (success) {
        print(
          '[NotificationService] ✅ FCM token cleared from backend for user: $userId',
        );
      } else {
        print(
          '[NotificationService] ⚠️ Failed to clear FCM token from backend',
        );
      }

      // Clear local cache
      fcmToken.value = '';
      _storage.remove(_fcmTokenKey);
      print('[NotificationService] ✅ Local FCM token cache cleared');
    } catch (e) {
      print('[NotificationService] ❌ Error clearing FCM token: $e');
    }
  }

  /// Setup message handlers for foreground, background, and terminated states
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
        '[NotificationService] 📬 Foreground message: ${message.notification?.title}',
      );
      _handleForegroundMessage(message);
    });

    // Background message tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
        '[NotificationService] 📭 Background message opened: ${message.notification?.title}',
      );
      _handleMessageTap(message);
    });

    // Terminated state message - add delay to ensure app is initialized
    _messaging.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        print(
          '[NotificationService] 📪 Terminated message opened: ${message.notification?.title}',
        );
        print('[NotificationService] 📪 Data: ${message.data}');

        // Wait for app to fully initialize before navigating
        await Future.delayed(const Duration(milliseconds: 800));

        // Ensure we're on the home screen first
        if (Get.currentRoute != '/home' && Get.currentRoute != '/splash') {
          await Get.offAllNamed('/home');
          await Future.delayed(const Duration(milliseconds: 300));
        }

        await _handleMessageTap(message);
      }
    });
  }

  /// Handle foreground messages (show in-app notification and save to list)
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[NotificationService] 📬 FOREGROUND message received');
    final notification = message.notification;
    if (notification == null) {
      debugPrint('[NotificationService] ⚠️ No notification object');
      return;
    }

    final notificationType = message.data['type'] as String?;
    final senderId = message.data['sender_id'] as String?;

    debugPrint('[NotificationService]   Title: ${notification.title}');
    debugPrint('[NotificationService]   Type: $notificationType');
    debugPrint('[NotificationService]   Data: ${message.data}');

    // Save to notification list
    _saveNotification(
      title: notification.title ?? 'Notification',
      body: notification.body ?? '',
      data: message.data,
    );

    // Handle new proposal notification with special UI
    if (notificationType == 'new_proposal') {
      debugPrint('[NotificationService] 🎯 Handling new_proposal');
      _handleNewProposal(message);
      return;
    }

    // Handle driver proposal notification with overlay
    if (notificationType == 'driver_proposed') {
      debugPrint(
        '[NotificationService] 📨 Received driver_proposed notification',
      );
      debugPrint(
        '[NotificationService]   Request ID: ${message.data['request_id']}',
      );
      debugPrint(
        '[NotificationService]   Driver ID: ${message.data['driver_id']}',
      );
      _handleDriverProposal(message);
      return;
    }

    // Handle new service request notification for drivers (from client)
    if (notificationType == 'new_service_request') {
      debugPrint(
        '[NotificationService] 🚗 Received new_service_request notification',
      );
      debugPrint(
        '[NotificationService]   Request ID: ${message.data['request_id']}',
      );
      debugPrint(
        '[NotificationService]   Client ID: ${message.data['client_id']}',
      );
      _handleNewServiceRequest(message);
      return;
    }

    // Handle driver approved notification (client approved the driver)
    if (notificationType == 'driver_approved') {
      debugPrint(
        '[NotificationService] ✅ Received driver_approved notification',
      );
      debugPrint(
        '[NotificationService]   Request ID: ${message.data['request_id']}',
      );
      _handleDriverApproved(message);
      return;
    }

    // Handle catalog request notification for drivers
    if (notificationType == 'catalog_request') {
      debugPrint(
        '[NotificationService] 🔔 Received catalog_request notification',
      );
      debugPrint(
        '[NotificationService]   Request ID: ${message.data['request_id']}',
      );
      debugPrint(
        '[NotificationService]   Client ID: ${message.data['client_id']}',
      );
      _handleCatalogRequest(message);
      return;
    }

    // Handle store order notification for stores
    if (notificationType == 'order') {
      debugPrint('[NotificationService] 🛍️ Received store order notification');
      debugPrint(
        '[NotificationService]   Order ID: ${message.data['orderId']}',
      );
      debugPrint(
        '[NotificationService]   Order Number: ${message.data['orderNumber']}',
      );
      debugPrint('[NotificationService]   Status: ${message.data['status']}');
      _handleStoreOrderNotification(message);
      return;
    }

    // Handle store order chat message notification
    if (notificationType == 'store_order_chat' ||
        (notificationType == 'message' &&
            message.data['relatedEntityType'] == 'store_order_chat')) {
      debugPrint(
        '[NotificationService] 💬 Received store order chat notification',
      );
      debugPrint(
        '[NotificationService]   Order ID: ${message.data['orderId']}',
      );
      debugPrint(
        '[NotificationService]   Sender: ${message.data['senderName']} (${message.data['senderRole']})',
      );
      _handleStoreOrderChatNotification(message);
      return;
    }

    // Smart notification grouping for chat messages
    if (notificationType == 'chat_message' && senderId != null) {
      // Update conversation state immediately
      final reqId = message.data['request_id']?.toString();
      if (reqId != null && Get.isRegistered<ConversationsController>()) {
        try {
          Get.find<ConversationsController>().bumpFromNotification(reqId);
        } catch (_) {}
      }
      _handleChatNotification(notification, message, senderId);
    } else {
      _showStandardNotification(notification, message);
    }
  }

  /// Handle new proposal notification with beautiful overlay
  Future<void> _handleNewProposal(RemoteMessage message) async {
    try {
      final requestId = int.tryParse(message.data['request_id'] ?? '');
      final driverId = int.tryParse(message.data['driver_id'] ?? '');

      if (requestId == null || driverId == null) {
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Fetch the actual proposal data
      final proposalController = Get.put(ProposalController());
      await proposalController.loadProposalsForRequest(requestId);

      // Find the latest proposal (just submitted)
      final proposals = proposalController.proposals;
      if (proposals.isEmpty) {
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Get the newest proposal
      final newestProposal = proposals.last;

      // Show beautiful animated notification card
      Get.dialog(
        ProposalNotificationCard(
          proposal: newestProposal,
          onDismiss: () {
            Get.back();
          },
          onAccept: (proposal) async {
            final requestController = Get.find<RequestController>();
            final request = await proposalController.acceptProposal(proposal);
            if (request != null) {
              requestController.activeRequest.value = request;
              Get.back(); // Close notification
              Get.toNamed('/track-delivery', arguments: request.id);
            }
          },
          autoDissmissSeconds: 15,
        ),
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 600),
      );
    } catch (e) {
      debugPrint('[NotificationService] Error handling proposal: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle driver proposal notification with overlay (new driver approval system)
  Future<void> _handleDriverProposal(RemoteMessage message) async {
    try {
      debugPrint('[NotificationService] 🔧 Processing driver proposal...');

      // If the AiMatchingScreen is active, it handles this inline — skip overlay
      if (AiMatchingScreen.isActive) {
        debugPrint(
          '[NotificationService] 🔇 AiMatchingScreen is active, skipping overlay (handled inline)',
        );
        return;
      }

      final requestId = int.tryParse(message.data['request_id'] ?? '');
      final driverId = int.tryParse(message.data['driver_id'] ?? '');

      debugPrint('[NotificationService]   Parsed Request ID: $requestId');
      debugPrint('[NotificationService]   Parsed Driver ID: $driverId');

      if (requestId == null) {
        debugPrint(
          '[NotificationService] ❌ No request ID, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Fetch the request with driver proposal
      debugPrint(
        '[NotificationService] 🔍 Fetching request #$requestId from backend...',
      );
      final client = Get.find<Client>();
      final request = await client.request.getRequestById(requestId);

      debugPrint('[NotificationService]   Request found: ${request != null}');
      debugPrint('[NotificationService]   Request status: ${request?.status}');

      if (request == null || request.status != RequestStatus.driver_proposed) {
        debugPrint(
          '[NotificationService] ❌ Request not valid, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Fetch driver info if available
      User? driverUser;
      if (driverId != null) {
        try {
          debugPrint(
            '[NotificationService] 👤 Fetching driver info for ID: $driverId',
          );
          final response = await client.user.getUserById(userId: driverId);
          driverUser = response.user;
          debugPrint(
            '[NotificationService]   Driver found: ${driverUser?.fullName}',
          );
        } catch (e) {
          debugPrint(
            '[NotificationService] ⚠️ Could not fetch driver info: $e',
          );
        }
      }

      // Show overlay notification with slide-in animation
      final context = Get.overlayContext;
      if (context == null) {
        debugPrint('[NotificationService] ❌ No overlay context available');
        return;
      }

      debugPrint('[NotificationService] ✅ Showing driver proposal overlay');
      OverlayEntry? overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: DriverProposalNotification(
            request: request,
            driverUser: driverUser,
            onDismiss: () {
              overlayEntry?.remove();
            },
            onAccept: (req) async {
              final requestService = Get.find<RequestService>();
              final authController = Get.find<AuthController>();
              final clientId = authController.currentUser.value?.id;

              if (clientId != null) {
                await requestService.approveDriver(
                  requestId: req.id!,
                  clientId: clientId,
                );

                Get.snackbar(
                  'Success',
                  'Driver approved! They will start the service soon.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Get.theme.colorScheme.primary,
                  colorText: Colors.white,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                );
              }
            },
            onReject: (req) async {
              final requestService = Get.find<RequestService>();
              final authController = Get.find<AuthController>();
              final clientId = authController.currentUser.value?.id;

              if (clientId != null) {
                await requestService.rejectDriver(
                  requestId: req.id!,
                  clientId: clientId,
                );

                Get.snackbar(
                  'Driver Rejected',
                  'Your request is available for other drivers.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Get.theme.colorScheme.surface,
                  colorText: Get.theme.colorScheme.onSurface,
                  icon: const Icon(Icons.info),
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                );
              }
            },
            durationSeconds: 15,
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry);
    } catch (e) {
      debugPrint('[NotificationService] Error handling driver proposal: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle new service request notification for drivers (from client creating request)
  Future<void> _handleNewServiceRequest(RemoteMessage message) async {
    try {
      debugPrint('[NotificationService] 🚗 Processing new service request...');
      final requestId = int.tryParse(message.data['request_id'] ?? '');
      final clientId = int.tryParse(message.data['client_id'] ?? '');
      final serviceType = message.data['service_type'] as String?;
      final offeredPrice = double.tryParse(message.data['offered_price'] ?? '0');

      debugPrint('[NotificationService]   Request ID: $requestId');
      debugPrint('[NotificationService]   Client ID: $clientId');
      debugPrint('[NotificationService]   Service: $serviceType');
      debugPrint('[NotificationService]   Price: $offeredPrice MAD');

      if (requestId == null) {
        debugPrint(
          '[NotificationService] ❌ Missing request ID, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Show beautiful animated notification snackbar with action to view requests
      Get.snackbar(
        '🚗 ${message.notification?.title ?? 'New Delivery Request!'}',
        message.notification?.body ?? 
          'New ${serviceType ?? 'service'} request available for ${CurrencyHelper.format(offeredPrice ?? 0)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        icon: const Icon(
          Icons.local_shipping,
          color: Colors.white,
          size: 28,
        ),
        duration: const Duration(seconds: 8),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        isDismissible: true,
        mainButton: TextButton(
          onPressed: () {
            Get.back(); // Close snackbar
            // Navigate to available requests
            Get.toNamed('/driver/available-requests');
          },
          child: const Text(
            'VIEW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Refresh driver dashboard if registered
      if (Get.isRegistered<RequestController>()) {
        try {
          Get.find<RequestController>().loadNearbyRequests();
        } catch (e) {
          debugPrint(
            '[NotificationService] Could not refresh nearby requests: $e',
          );
        }
      }

      debugPrint('[NotificationService] ✅ New service request notification shown');
    } catch (e) {
      debugPrint('[NotificationService] Error handling new service request: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle driver approved notification (client approved the driver)
  Future<void> _handleDriverApproved(RemoteMessage message) async {
    try {
      debugPrint('[NotificationService] ✅ Processing driver_approved...');
      final requestId = int.tryParse(message.data['request_id'] ?? '');

      // Show success notification
      Get.snackbar(
        '🎉 ${message.notification?.title ?? 'Request Accepted!'}',
        message.notification?.body ?? 'The client has approved you. Start the service!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 28,
        ),
        duration: const Duration(seconds: 6),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        isDismissible: true,
      );

      // Refresh the driver's active request screen
      if (Get.isRegistered<RequestController>()) {
        try {
          final requestController = Get.find<RequestController>();
          // Refresh current request if it matches
          if (requestId != null) {
            await requestController.refreshCurrentRequest();
          }
          // Also refresh active requests list
          await requestController.loadActiveRequest();
          debugPrint('[NotificationService] ✅ Driver requests refreshed');
        } catch (e) {
          debugPrint('[NotificationService] Could not refresh driver requests: $e');
        }
      }

      debugPrint('[NotificationService] ✅ Driver approved notification handled');
    } catch (e) {
      debugPrint('[NotificationService] Error handling driver_approved: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle catalog request notification for drivers (live overlay)
  Future<void> _handleCatalogRequest(RemoteMessage message) async {
    try {
      debugPrint('[NotificationService] 🔧 Processing catalog request...');
      final requestId = int.tryParse(message.data['request_id'] ?? '');
      final clientId = int.tryParse(message.data['client_id'] ?? '');
      final clientName = message.data['client_name'] as String?;
      final serviceType = message.data['service_type'] as String?;
      final price = double.tryParse(message.data['price'] ?? '0');

      debugPrint('[NotificationService]   Request ID: $requestId');
      debugPrint('[NotificationService]   Client: $clientName (ID: $clientId)');
      debugPrint('[NotificationService]   Service: $serviceType');
      debugPrint('[NotificationService]   Price: $price MAD');

      if (requestId == null || clientName == null) {
        debugPrint(
          '[NotificationService] ❌ Missing data, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Show beautiful animated notification snackbar with actions
      Get.snackbar(
        '🔔 New Catalog Request!',
        '$clientName wants your $serviceType service for ${CurrencyHelper.format(price ?? 0)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.primaryColor,
        colorText: Colors.white,
        icon: const Icon(
          Icons.notifications_active,
          color: Colors.white,
          size: 28,
        ),
        duration: const Duration(seconds: 10),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        isDismissible: true,
        mainButton: TextButton(
          onPressed: () {
            Get.back(); // Close snackbar
            Get.toNamed('/driver/catalog-requests');
          },
          child: const Text(
            'VIEW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Also save to notification list
      _saveNotification(
        title: message.notification?.title ?? 'New Catalog Request',
        body: message.notification?.body ?? '',
        data: message.data,
      );

      debugPrint('[NotificationService] ✅ Catalog request notification shown');
    } catch (e) {
      debugPrint('[NotificationService] Error handling catalog request: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle store order notification for stores (new order, status update)
  Future<void> _handleStoreOrderNotification(RemoteMessage message) async {
    try {
      debugPrint(
        '[NotificationService] 🛍️ Processing store order notification...',
      );
      final orderId = int.tryParse(message.data['orderId'] ?? '');
      final orderNumber = message.data['orderNumber'] as String?;
      final status = message.data['status'] as String?;
      final total = message.data['total'] as String?;
      final storeId = int.tryParse(message.data['storeId'] ?? '');

      debugPrint('[NotificationService]   Order ID: $orderId');
      debugPrint('[NotificationService]   Order Number: $orderNumber');
      debugPrint('[NotificationService]   Status: $status');
      debugPrint('[NotificationService]   Total: $total MAD');
      debugPrint('[NotificationService]   Store ID: $storeId');

      if (orderId == null) {
        debugPrint(
          '[NotificationService] ❌ Missing order ID, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Determine the icon and color based on status
      IconData iconData;
      Color bgColor;
      String actionRoute;

      if (status == 'pending') {
        iconData = Icons.notifications_active;
        bgColor = Colors.orange;
        actionRoute = '/store/orders/detail';
      } else if (status == 'delivered') {
        iconData = Icons.check_circle;
        bgColor = Colors.green;
        actionRoute = '/store/orders/detail';
      } else if (status == 'cancelled' || status == 'rejected') {
        iconData = Icons.cancel;
        bgColor = Colors.red;
        actionRoute = '/store/orders/detail';
      } else {
        iconData = Icons.local_shipping;
        bgColor = Colors.blue;
        actionRoute = '/store/orders/detail';
      }

      // Show beautiful animated notification
      Get.snackbar(
        message.notification?.title ?? '🛍️ Store Order Update',
        message.notification?.body ?? 'Order #$orderNumber',
        snackPosition: SnackPosition.TOP,
        backgroundColor: bgColor,
        colorText: Colors.white,
        icon: Icon(iconData, color: Colors.white, size: 28),
        duration: const Duration(seconds: 8),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        isDismissible: true,
        mainButton: TextButton(
          onPressed: () {
            Get.back(); // Close snackbar
            Get.toNamed(actionRoute, arguments: orderId);
          },
          child: const Text(
            'VIEW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Refresh store orders controller if registered
      if (Get.isRegistered<StoreOrderController>()) {
        try {
          Get.find<StoreOrderController>().refresh();
        } catch (e) {
          debugPrint(
            '[NotificationService] Could not refresh store orders: $e',
          );
        }
      }

      // Also save to notification list
      _saveNotification(
        title: message.notification?.title ?? 'Store Order Update',
        body: message.notification?.body ?? '',
        data: message.data,
      );

      debugPrint('[NotificationService] ✅ Store order notification shown');
    } catch (e) {
      debugPrint('[NotificationService] Error handling store order: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle store order chat message notification
  Future<void> _handleStoreOrderChatNotification(RemoteMessage message) async {
    try {
      debugPrint(
        '[NotificationService] 💬 Processing store order chat notification...',
      );
      final orderId = int.tryParse(message.data['orderId'] ?? '');
      final senderName = message.data['senderName'] as String?;
      final senderRole = message.data['senderRole'] as String?;
      final messageType = message.data['messageType'] as String?;

      debugPrint('[NotificationService]   Order ID: $orderId');
      debugPrint('[NotificationService]   Sender: $senderName ($senderRole)');
      debugPrint('[NotificationService]   Message Type: $messageType');

      if (orderId == null) {
        debugPrint(
          '[NotificationService] ❌ Missing order ID, showing standard notification',
        );
        _showStandardNotification(message.notification!, message);
        return;
      }

      // Determine icon based on sender role
      IconData iconData;
      Color bgColor;

      switch (senderRole) {
        case 'client':
          iconData = Icons.person;
          bgColor = Colors.blue;
          break;
        case 'store':
          iconData = Icons.store;
          bgColor = Colors.purple;
          break;
        case 'driver':
          iconData = Icons.delivery_dining;
          bgColor = Colors.green;
          break;
        default:
          iconData = Icons.message;
          bgColor = Colors.teal;
      }

      // Show chat notification
      Get.snackbar(
        message.notification?.title ?? senderName ?? 'New Message',
        message.notification?.body ?? 'Sent a message',
        snackPosition: SnackPosition.TOP,
        backgroundColor: bgColor,
        colorText: Colors.white,
        icon: Icon(iconData, color: Colors.white, size: 28),
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        isDismissible: true,
        mainButton: TextButton(
          onPressed: () {
            Get.back(); // Close snackbar
            // Navigate to store order chat
            // Determine user role for navigation
            final authController = Get.find<AuthController>();
            final currentUserId = authController.currentUser.value?.id;
            String userRole = 'client';

            // Try to determine user's role in this chat
            if (authController.hasRole(UserRole.store)) {
              userRole = 'store';
            } else if (authController.hasRole(UserRole.driver)) {
              userRole = 'driver';
            }

            Get.toNamed(
              '/store-order-chat',
              arguments: {
                'orderId': orderId,
                'userRole': userRole,
              },
            );
          },
          child: const Text(
            'REPLY',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Save to notification list
      _saveNotification(
        title: message.notification?.title ?? 'Chat Message',
        body: message.notification?.body ?? '',
        data: message.data,
      );

      debugPrint('[NotificationService] ✅ Store order chat notification shown');
    } catch (e) {
      debugPrint('[NotificationService] Error handling store order chat: $e');
      _showStandardNotification(message.notification!, message);
    }
  }

  /// Handle chat message notification with smart grouping
  void _handleChatNotification(
    RemoteNotification notification,
    RemoteMessage message,
    String senderId,
  ) {
    final now = DateTime.now();
    final lastTime = _lastNotificationTime[senderId];
    final count = _notificationCount[senderId] ?? 0;

    // Check if we should group this notification
    if (lastTime != null && now.difference(lastTime) < _groupingThreshold) {
      // Update count for grouped notifications
      _notificationCount[senderId] = count + 1;
      _lastNotificationTime[senderId] = now;

      // Show grouped notification
      final totalMessages = count + 1;
      Get.snackbar(
        notification.title ?? 'New Message',
        totalMessages == 1
            ? notification.body ?? ''
            : '$totalMessages new messages',
        icon: const Icon(
          Icons.message_rounded,
          color: Colors.white,
          size: 28,
        ),
        shouldIconPulse: true,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue.shade700,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        animationDuration: const Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
        onTap: (_) => _handleMessageTap(message),
      );
    } else {
      // First message or after threshold - show individual notification
      _notificationCount[senderId] = 0;
      _lastNotificationTime[senderId] = now;
      _showStandardNotification(notification, message);
    }
  }

  /// Show standard notification with beautiful animation
  void _showStandardNotification(
    RemoteNotification notification,
    RemoteMessage message,
  ) {
    // Show smooth animated notification
    Get.snackbar(
      notification.title ?? 'Notification',
      notification.body ?? '',
      icon: Icon(
        _getNotificationIcon(message.data['type']),
        color: Colors.white,
        size: 28,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
      backgroundColor: _getNotificationColor(message.data['type']),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      onTap: (_) => _handleMessageTap(message),
    );
  }

  /// Get icon for notification type
  IconData _getNotificationIcon(String? type) {
    switch (type) {
      case 'request_accepted':
        return Icons.check_circle;
      case 'driver_arriving':
        return Icons.directions_car;
      case 'service_started':
        return Icons.play_circle;
      case 'service_completed':
        return Icons.done_all;
      case 'new_request':
        return Icons.notification_add;
      case 'request_cancelled':
        return Icons.cancel;
      case 'chat_message':
        return Icons.message;
      case 'new_proposal':
        return Icons.local_shipping;
      case 'proposal_accepted':
        return Icons.thumb_up;
      // Driver proposal notification icons
      case 'driver_proposed':
        return Icons.person_pin_circle;
      case 'driver_approved':
        return Icons.check_circle;
      case 'driver_rejected':
        return Icons.cancel_outlined;
      // Negotiation notification icons
      case 'driver_counter_offer':
        return Icons.local_offer;
      case 'driver_accepted_price':
        return Icons.check_circle_outline;
      case 'client_accepted_offer':
        return Icons.handshake;
      case 'client_rejected_offer':
        return Icons.cancel_outlined;
      case 'negotiation_success':
        return Icons.celebration;
      default:
        return Icons.notifications;
    }
  }

  /// Get color for notification type
  Color _getNotificationColor(String? type) {
    switch (type) {
      case 'request_accepted':
        return Colors.green.shade600;
      case 'driver_arriving':
        return Colors.orange.shade600;
      case 'service_started':
        return Colors.blue.shade600;
      case 'new_proposal':
        return Colors.purple.shade600;
      case 'proposal_accepted':
        return Colors.green.shade700;
      // Driver proposal notification colors
      case 'driver_proposed':
        return Colors.teal.shade600;
      case 'driver_approved':
        return Colors.green.shade700;
      case 'driver_rejected':
        return Colors.orange.shade600;
      // Negotiation notification colors
      case 'driver_counter_offer':
        return Colors.amber.shade700;
      case 'driver_accepted_price':
        return Colors.green.shade600;
      case 'client_accepted_offer':
        return Colors.green.shade700;
      case 'client_rejected_offer':
        return Colors.orange.shade600;
      case 'negotiation_success':
        return Colors.purple.shade700;
      case 'service_completed':
        return Colors.green.shade700;
      case 'new_request':
        return Colors.purple.shade600;
      case 'request_cancelled':
        return Colors.red.shade600;
      case 'chat_message':
        return Colors.blue.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }

  /// Save notification to local storage via NotificationController
  void _saveNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
    try {
      if (Get.isRegistered<NotificationController>()) {
        final notificationController = Get.find<NotificationController>();
        final appNotification = AppNotification.fromRemoteMessage(
          title: title,
          body: body,
          data: data,
        );
        notificationController.addNotification(appNotification);
      }
    } catch (e) {
      print('[NotificationService] ❌ Error saving notification: $e');
    }
  }

  /// Handle message tap - navigate to appropriate screen
  Future<void> _handleMessageTap(RemoteMessage message) async {
    final data = message.data;
    print('[NotificationService] 👆 Message tapped: $data');

    if (data.isEmpty) return;

    // Navigate based on notification type
    final type = data['type'] as String?;
    final requestId = data['request_id'] as String?;
    final orderId = data['orderId'] as String?;
    final relatedEntityType = data['relatedEntityType'] as String?;

    switch (type) {
      case 'request_accepted':
      case 'driver_arriving':
      case 'service_started':
      case 'service_completed':
        // Navigate to active request screen
        // Note: For notification-triggered navigation, the screen should load
        // the request from the controller's activeRequest
        if (requestId != null) {
          // First reload the active request to ensure we have latest data
          final requestController = Get.find<RequestController>();
          await requestController.loadActiveRequest();
          if (requestController.activeRequest.value != null) {
            Get.toNamed(
              '/client/active-request',
              arguments: requestController.activeRequest.value,
            );
          }
        }
        break;

      // Driver proposal navigation cases
      case 'driver_proposed':
        // Client received driver proposal - navigate to review screen
        if (requestId != null) {
          final client = Get.find<Client>();
          final request = await client.request.getRequestById(
            int.parse(requestId),
          );
          if (request != null &&
              request.status == RequestStatus.driver_proposed) {
            // Import: awhar_flutter/lib/screens/client/driver_review_screen.dart
            Get.to(() => DriverReviewScreen(request: request));
          }
        }
        break;

      case 'driver_approved':
        // Driver's proposal was approved - navigate to active request
        if (requestId != null) {
          final requestController = Get.find<RequestController>();
          await requestController.loadActiveRequest();
          if (requestController.activeRequest.value != null) {
            Get.toNamed(
              '/driver/active-request',
              arguments: requestController.activeRequest.value,
            );
          }
        }
        break;

      case 'driver_rejected':
        // Driver's proposal was rejected - navigate back to available requests
        Get.toNamed('/driver/available-requests');
        break;

      // Negotiation navigation cases
      case 'driver_counter_offer':
      case 'driver_accepted_price':
        // Client received offer - navigate to offer review screen
        if (requestId != null) {
          final requestController = Get.find<RequestController>();
          await requestController.loadPendingRequests();
          Get.toNamed('/client/offer-review', arguments: int.parse(requestId));
        }
        break;

      case 'client_accepted_offer':
      case 'negotiation_success':
        // Driver's offer accepted - navigate to active request
        if (requestId != null) {
          final requestController = Get.find<RequestController>();
          await requestController.loadActiveRequest();
          if (requestController.activeRequest.value != null) {
            Get.toNamed(
              '/driver/active-request',
              arguments: requestController.activeRequest.value,
            );
          }
        }
        break;

      case 'client_rejected_offer':
        // Driver's offer rejected - navigate back to available requests
        Get.toNamed('/driver/available-requests');
        break;

      case 'new_request':
        // Navigate to available requests (driver)
        Get.toNamed('/driver/available-requests');
        break;

      case 'catalog_request':
        // Navigate to catalog requests screen (driver)
        Get.toNamed('/driver/catalog-requests');
        break;

      case 'request_cancelled':
        // Navigate to dashboard
        Get.offAllNamed('/home');
        break;

      case 'chat_message':
        // Navigate to service request chat
        if (requestId != null) {
          Get.toNamed('/chat', arguments: {'requestId': requestId});
        }
        break;

      // ==================== STORE ORDER NOTIFICATIONS ====================

      case 'store_order_chat':
        // Navigate to store order group chat
        await _navigateToStoreOrderChat(orderId, data);
        break;

      case 'order':
        // Navigate to store order detail based on user role
        await _navigateToStoreOrder(orderId, data);
        break;

      case 'message':
        // Check relatedEntityType to determine navigation
        if (relatedEntityType == 'store_order_chat') {
          await _navigateToStoreOrderChat(orderId, data);
        } else if (requestId != null) {
          // Regular service request chat
          Get.toNamed('/chat', arguments: {'requestId': requestId});
        }
        break;

      case 'direct_message':
        // Navigate to direct chat
        final senderId = data['sender_id'] as String?;
        final senderName = data['senderName'] as String?;
        if (senderId != null) {
          Get.toNamed(
            '/direct-chat',
            arguments: {
              'clientId': senderId,
              'clientName': senderName ?? 'User',
            },
          );
        }
        break;

      default:
        print('[NotificationService] ⚠️ Unknown notification type: $type');
        // Try to handle based on available data
        if (orderId != null) {
          await _navigateToStoreOrderChat(orderId, data);
        } else if (requestId != null) {
          Get.toNamed('/chat', arguments: {'requestId': requestId});
        }
    }
  }

  /// Navigate to store order chat with proper role detection
  Future<void> _navigateToStoreOrderChat(
    String? orderId,
    Map<String, dynamic> data,
  ) async {
    if (orderId == null) {
      print('[NotificationService] ⚠️ No orderId for store order chat');
      return;
    }

    final authController = Get.find<AuthController>();
    String userRole = 'client';

    // Detect user role
    if (authController.hasRole(UserRole.store)) {
      userRole = 'store';
    } else if (authController.hasRole(UserRole.driver)) {
      userRole = 'driver';
    }

    print(
      '[NotificationService] 💬 Navigating to store order chat: orderId=$orderId, role=$userRole',
    );

    Get.toNamed(
      '/store-order-chat',
      arguments: {
        'orderId': int.tryParse(orderId) ?? orderId,
        'userRole': userRole,
      },
    );
  }

  /// Navigate to store order detail with proper role detection
  Future<void> _navigateToStoreOrder(
    String? orderId,
    Map<String, dynamic> data,
  ) async {
    if (orderId == null) {
      print('[NotificationService] ⚠️ No orderId for store order');
      return;
    }

    final authController = Get.find<AuthController>();
    final orderIdInt = int.tryParse(orderId);

    if (authController.hasRole(UserRole.store)) {
      // Store owner viewing their order
      Get.toNamed('/store/orders/detail', arguments: orderIdInt);
    } else if (authController.hasRole(UserRole.driver)) {
      // Driver viewing assigned delivery
      Get.toNamed('/driver/store-delivery', arguments: orderIdInt);
    } else {
      // Client viewing their order
      Get.toNamed('/client/store-order', arguments: orderIdInt);
    }
  }

  /// Subscribe to topic (for broadcast notifications)
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('[NotificationService] ✅ Subscribed to topic: $topic');
    } catch (e) {
      print('[NotificationService] ❌ Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print('[NotificationService] ✅ Unsubscribed from topic: $topic');
    } catch (e) {
      print('[NotificationService] ❌ Error unsubscribing from topic: $e');
    }
  }

  /// Re-request notification permissions (iOS)
  Future<void> requestPermissions() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _getFCMToken();
  }

  /// Get stored FCM token
  String? getStoredToken() {
    return _storage.read(_fcmTokenKey);
  }

  /// Manually trigger FCM token update to backend
  /// Useful after login/signup to ensure token is synced
  Future<void> updateFCMToken() async {
    final token = fcmToken.value;
    if (token.isNotEmpty) {
      await _sendTokenToBackend(token);
    } else {
      // Try to get token again if not available
      await _getFCMToken();
    }
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
    '[NotificationService] 🔔 Background message: ${message.notification?.title}',
  );
  // Handle background message if needed
}
