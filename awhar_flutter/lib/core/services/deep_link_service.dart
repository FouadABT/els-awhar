import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../app/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Deep Link Service
///
/// Handles incoming deep links (App Links on Android, Universal Links on iOS)
/// and routes them to the appropriate screens.
///
/// Supported link patterns:
/// - /order/{orderId} - View order details
/// - /request/{requestId} - View request details
/// - /driver/{driverId} - View driver profile
/// - /invite/{code} - Accept invitation
/// - /chat/{requestId} - Open chat for request
/// - /store-order/{orderId} - View store order details
/// - /store-order-chat/{orderId} - Open store order group chat
/// - /direct-chat/{userId} - Open direct chat with user
class DeepLinkService extends GetxService {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  /// Pending deep link to handle after authentication
  Uri? _pendingDeepLink;

  /// Whether we've already processed the initial link
  bool _initialLinkProcessed = false;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
  }

  /// Initialize deep link handling
  Future<void> _initDeepLinks() async {
    // Handle initial link (cold start)
    _handleInitialLink();

    // Listen for incoming links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleDeepLink,
      onError: (err) {
        if (kDebugMode) {
          print('[DeepLink] ❌ Error receiving link: $err');
        }
      },
    );
  }

  /// Handle the initial link that opened the app (cold start)
  Future<void> _handleInitialLink() async {
    if (_initialLinkProcessed) return;
    _initialLinkProcessed = true;

    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        if (kDebugMode) {
          print('[DeepLink] 🚀 Initial link received: $initialLink');
        }
        // Delay slightly to let the app initialize
        await Future.delayed(const Duration(milliseconds: 500));
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      if (kDebugMode) {
        print('[DeepLink] ❌ Error getting initial link: $e');
      }
    }
  }

  /// Process an incoming deep link
  void _handleDeepLink(Uri uri) {
    if (kDebugMode) {
      print('[DeepLink] 📲 Handling deep link: $uri');
      print('[DeepLink] 📲 Path: ${uri.path}');
      print('[DeepLink] 📲 Segments: ${uri.pathSegments}');
    }

    // Check if user is authenticated
    final authController = Get.find<AuthController>();
    if (!authController.isLoggedIn) {
      if (kDebugMode) {
        print('[DeepLink] ⏳ User not logged in, saving link for later');
      }
      _pendingDeepLink = uri;
      return;
    }

    // Route to appropriate screen
    _routeDeepLink(uri);
  }

  /// Route to the appropriate screen based on the deep link
  void _routeDeepLink(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.isEmpty) {
      if (kDebugMode) {
        print('[DeepLink] ⚠️ Empty path, going to home');
      }
      Get.offAllNamed(AppRoutes.home);
      return;
    }

    final type = segments[0];
    final id = segments.length > 1 ? segments[1] : null;

    if (kDebugMode) {
      print('[DeepLink] 🎯 Routing: type=$type, id=$id');
    }

    switch (type) {
      case 'order':
      case 'request':
        if (id != null) {
          _navigateToRequest(id);
        } else {
          Get.toNamed(AppRoutes.home);
        }
        break;

      case 'driver':
        if (id != null) {
          _navigateToDriver(id);
        } else {
          Get.toNamed(AppRoutes.clientExplore);
        }
        break;

      case 'store':
        if (id != null) {
          _navigateToStore(id);
        } else {
          Get.toNamed(AppRoutes.clientExplore);
        }
        break;

      case 'invite':
        if (id != null) {
          _handleInvitation(id);
        } else {
          Get.toNamed(AppRoutes.home);
        }
        break;

      case 'chat':
        if (id != null) {
          _navigateToChat(id);
        } else {
          Get.toNamed(AppRoutes.messages);
        }
        break;

      case 'store-order':
        // Store order detail - route based on role
        if (id != null) {
          _navigateToStoreOrder(id);
        } else {
          Get.toNamed(AppRoutes.home);
        }
        break;

      case 'store-order-chat':
        // Store order group chat
        if (id != null) {
          _navigateToStoreOrderChat(id);
        } else {
          Get.toNamed(AppRoutes.messages);
        }
        break;

      case 'direct-chat':
        // Direct chat with user
        if (id != null) {
          _navigateToDirectChat(id, uri.queryParameters);
        } else {
          Get.toNamed(AppRoutes.messages);
        }
        break;

      case 'share':
        // Generic share links - could be driver, service, etc.
        _handleShareLink(uri);
        break;

      default:
        if (kDebugMode) {
          print('[DeepLink] ⚠️ Unknown deep link type: $type');
        }
        Get.toNamed(AppRoutes.home);
    }
  }

  /// Navigate to a request/order detail screen
  void _navigateToRequest(String requestId) {
    if (kDebugMode) {
      print('[DeepLink] 📦 Opening request: $requestId');
    }

    // Parse the request ID
    final id = int.tryParse(requestId);
    if (id == null) {
      Get.snackbar('Error', 'Invalid request ID');
      Get.toNamed(AppRoutes.home);
      return;
    }

    // Check user role and navigate to appropriate screen
    final authController = Get.find<AuthController>();
    if (authController.isDriverMode) {
      Get.toNamed(
        AppRoutes.driverActiveRequest,
        arguments: {'requestId': id},
      );
    } else {
      Get.toNamed(
        AppRoutes.clientActiveRequest,
        arguments: {'requestId': id},
      );
    }
  }

  /// Navigate to a driver profile
  void _navigateToDriver(String driverId) {
    if (kDebugMode) {
      print('[DeepLink] 👤 Opening driver profile: $driverId');
    }

    final id = int.tryParse(driverId);
    if (id == null) {
      Get.snackbar('Error', 'Invalid driver ID');
      Get.toNamed(AppRoutes.home);
      return;
    }

    // Navigate to explore with driver preselected
    // The explore screen should accept a driverId argument
    Get.toNamed(
      AppRoutes.clientExplore,
      arguments: {'selectedDriverId': id},
    );
  }

  /// Navigate to a store profile
  void _navigateToStore(String storeId) {
    if (kDebugMode) {
      print('[DeepLink] 🏪 Opening store profile: $storeId');
    }

    final id = int.tryParse(storeId);
    if (id == null) {
      Get.snackbar('Error', 'Invalid store ID');
      Get.toNamed(AppRoutes.home);
      return;
    }

    // Navigate to store detail screen
    Get.toNamed(
      AppRoutes.clientStoreDetail,
      arguments: {'storeId': id},
    );
  }

  /// Handle invitation links
  void _handleInvitation(String inviteCode) {
    if (kDebugMode) {
      print('[DeepLink] 🎟️ Processing invitation: $inviteCode');
    }

    // Store the invite code for processing
    Get.snackbar(
      'Invitation',
      'Welcome! Your invitation code has been applied.',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Navigate to home
    Get.toNamed(AppRoutes.home);

    // TODO: Send invite code to backend for referral tracking
    // client.referral.applyInviteCode(inviteCode);
  }

  /// Navigate to chat screen
  void _navigateToChat(String requestId) {
    if (kDebugMode) {
      print('[DeepLink] 💬 Opening chat for request: $requestId');
    }

    Get.toNamed('/chat/$requestId');
  }

  /// Navigate to store order detail based on user role
  void _navigateToStoreOrder(String orderId) {
    if (kDebugMode) {
      print('[DeepLink] 🛍️ Opening store order: $orderId');
    }

    final id = int.tryParse(orderId);
    if (id == null) {
      Get.snackbar('Error', 'Invalid order ID');
      Get.toNamed(AppRoutes.home);
      return;
    }

    final authController = Get.find<AuthController>();

    if (authController.hasRole(UserRole.store)) {
      // Store owner viewing their order
      Get.toNamed('/store/orders/detail', arguments: id);
    } else if (authController.hasRole(UserRole.driver)) {
      // Driver viewing assigned delivery
      Get.toNamed('/driver/store-delivery', arguments: id);
    } else {
      // Client viewing their order
      Get.toNamed('/client/store-order', arguments: id);
    }
  }

  /// Navigate to store order group chat
  void _navigateToStoreOrderChat(String orderId) {
    if (kDebugMode) {
      print('[DeepLink] 💬 Opening store order chat: $orderId');
    }

    final id = int.tryParse(orderId);
    if (id == null) {
      Get.snackbar('Error', 'Invalid order ID');
      Get.toNamed(AppRoutes.messages);
      return;
    }

    final authController = Get.find<AuthController>();
    String userRole = 'client';

    if (authController.hasRole(UserRole.store)) {
      userRole = 'store';
    } else if (authController.hasRole(UserRole.driver)) {
      userRole = 'driver';
    }

    Get.toNamed(
      AppRoutes.storeOrderChat,
      arguments: {
        'orderId': id,
        'userRole': userRole,
      },
    );
  }

  /// Navigate to direct chat with a user
  void _navigateToDirectChat(String recipientId, Map<String, String> params) {
    if (kDebugMode) {
      print('[DeepLink] 💬 Opening direct chat with: $recipientId');
    }

    Get.toNamed(
      AppRoutes.directChat,
      arguments: {
        'clientId': recipientId,
        'clientName': params['name'] ?? 'User',
      },
    );
  }

  /// Handle generic share links
  void _handleShareLink(Uri uri) {
    final queryParams = uri.queryParameters;
    final type = queryParams['type'];
    final id = queryParams['id'];

    if (kDebugMode) {
      print('[DeepLink] 🔗 Share link: type=$type, id=$id');
    }

    switch (type) {
      case 'driver':
        if (id != null) _navigateToDriver(id);
        break;
      case 'service':
        // Navigate to service details
        Get.toNamed(AppRoutes.clientExplore, arguments: {'serviceId': id});
        break;
      default:
        Get.toNamed(AppRoutes.home);
    }
  }

  /// Process any pending deep link after login
  /// Call this from AuthController after successful login
  void processPendingDeepLink() {
    if (_pendingDeepLink != null) {
      if (kDebugMode) {
        print('[DeepLink] ✅ Processing pending link: $_pendingDeepLink');
      }
      final link = _pendingDeepLink!;
      _pendingDeepLink = null;
      _routeDeepLink(link);
    }
  }

  /// Check if there's a pending deep link
  bool get hasPendingDeepLink => _pendingDeepLink != null;

  /// Deep link base URL for production
  /// Note: Web server routes are served on serverpod.space, not the custom API domain
  static const String _deepLinkBaseUrl = 'https://awharapp.serverpod.space';

  /// Generate a shareable deep link for an order
  static String generateOrderLink(int orderId) {
    return '$_deepLinkBaseUrl/order/$orderId';
  }

  /// Generate a shareable deep link for a driver
  static String generateDriverLink(int driverId) {
    return '$_deepLinkBaseUrl/driver/$driverId';
  }

  /// Generate an invitation link
  static String generateInviteLink(String inviteCode) {
    return '$_deepLinkBaseUrl/invite/$inviteCode';
  }

  /// Generate a chat link
  static String generateChatLink(int requestId) {
    return '$_deepLinkBaseUrl/chat/$requestId';
  }

  /// Generate a store order link
  static String generateStoreOrderLink(int orderId) {
    return '$_deepLinkBaseUrl/store-order/$orderId';
  }

  /// Generate a store order chat link
  static String generateStoreOrderChatLink(int orderId) {
    return '$_deepLinkBaseUrl/store-order-chat/$orderId';
  }

  /// Generate a direct chat link
  static String generateDirectChatLink(int userId, {String? userName}) {
    final base = '$_deepLinkBaseUrl/direct-chat/$userId';
    if (userName != null) {
      return '$base?name=${Uri.encodeComponent(userName)}';
    }
    return base;
  }
}
