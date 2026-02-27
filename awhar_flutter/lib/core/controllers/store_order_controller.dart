import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'auth_controller.dart';
import 'store_controller.dart';

/// Store Order Controller
/// Handles store order management - view orders, confirm, prepare, find drivers
class StoreOrderController extends GetxController {
  late final Client _client;
  late final AuthController _authController;

  /// Get current user ID
  int? get _userId => _authController.currentUser.value?.id;

  /// Polling timer for delivery request status
  Timer? _deliveryRequestPollingTimer;

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// All store orders
  final RxList<StoreOrder> orders = <StoreOrder>[].obs;

  /// Active orders (pending to ready)
  final RxList<StoreOrder> activeOrders = <StoreOrder>[].obs;

  /// Completed orders (delivered, cancelled)
  final RxList<StoreOrder> completedOrders = <StoreOrder>[].obs;

  /// Cache of clientId -> client full name for quick display
  final RxMap<int, String> clientNames = <int, String>{}.obs;

  /// Current selected order for detail view
  final Rx<StoreOrder?> selectedOrder = Rx<StoreOrder?>(null);

  /// Nearby drivers for delivery (with distance info)
  final RxList<NearbyDriver> nearbyDrivers = <NearbyDriver>[].obs;

  /// Current delivery request for order
  final Rx<StoreDeliveryRequest?> currentDeliveryRequest =
      Rx<StoreDeliveryRequest?>(null);

  /// Is waiting for driver (shows polling indicator)
  final RxBool isWaitingForDriver = false.obs;

  /// Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingDrivers = false.obs;
  final RxBool isProcessing = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  /// Success message
  final RxString successMessage = ''.obs;

  /// Current filter tab
  final RxInt currentTab = 0.obs;

  // ============================================================
  // GETTERS
  // ============================================================

  /// Get pending orders count
  int get pendingCount =>
      orders.where((o) => o.status == StoreOrderStatus.pending).length;

  /// Get active orders count (confirmed, preparing, ready)
  int get activeCount => orders
      .where(
        (o) =>
            o.status == StoreOrderStatus.confirmed ||
            o.status == StoreOrderStatus.preparing ||
            o.status == StoreOrderStatus.ready ||
            o.status == StoreOrderStatus.driverAssigned ||
            o.status == StoreOrderStatus.pickedUp ||
            o.status == StoreOrderStatus.inDelivery,
      )
      .length;

  /// Get today's orders count
  int get todayCount {
    final today = DateTime.now();
    return orders
        .where(
          (o) =>
              o.createdAt.year == today.year &&
              o.createdAt.month == today.month &&
              o.createdAt.day == today.day,
        )
        .length;
  }

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _client = Get.find<Client>();
    _authController = Get.find<AuthController>();
    _setupNotificationListener();
  }

  @override
  void onReady() {
    super.onReady();
    _initializeOrders();
  }

  /// Initialize orders with proper timing
  Future<void> _initializeOrders() async {
    // Wait for StoreController to be ready if not already
    try {
      if (!Get.isRegistered<StoreController>()) {
        debugPrint('[StoreOrderController] ⏳ Waiting for StoreController...');
        await Future.delayed(const Duration(milliseconds: 500));
      }

      final storeController = Get.find<StoreController>();

      // Wait for store to be loaded
      int attempts = 0;
      while (storeController.isLoading.value && attempts < 30) {
        debugPrint(
          '[StoreOrderController] ⏳ Waiting for store to load... (${attempts + 1}/30)',
        );
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }

      // Now load orders
      await loadOrders();
    } catch (e) {
      debugPrint('[StoreOrderController] ⚠️ Error initializing orders: $e');
    }
  }

  /// Listen for incoming order notifications and refresh orders
  void _setupNotificationListener() {
    // This will be called when a new notification arrives
    // We'll use Get.rawSnackbar to show notification and trigger refresh
  }

  @override
  void onClose() {
    _stopDeliveryRequestPolling();
    super.onClose();
  }

  @override
  /// Refresh orders
  Future<void> refresh() async {
    await loadOrders();
  }

  // ============================================================
  // ORDERS LOADING
  // ============================================================

  /// Load all orders for the store
  Future<void> loadOrders() async {
    if (_userId == null) {
      debugPrint('[StoreOrderController] ❌ No user ID found');
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Ensure StoreController is registered
      if (!Get.isRegistered<StoreController>()) {
        debugPrint(
          '[StoreOrderController] ⚠️ StoreController not registered, creating it...',
        );
        Get.put(StoreController());
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Get store ID from StoreController
      final storeController = Get.find<StoreController>();
      var storeId = storeController.storeId;

      debugPrint('[StoreOrderController] 🔍 Loading orders:');
      debugPrint('  User ID: $_userId');
      debugPrint('  Store ID: $storeId');
      debugPrint('  Store object: ${storeController.myStore.value}');

      if (storeId == null || storeId == 0) {
        debugPrint(
          '[StoreOrderController] ⚠️ No valid store ID found, retrying...',
        );
        errorMessage.value = 'No store found. Please try again.';

        // Retry once after a short delay
        await Future.delayed(const Duration(milliseconds: 500));

        storeId = storeController.storeId;
        if (storeId == null || storeId == 0) {
          debugPrint('[StoreOrderController] ❌ Still no store ID after retry');
          throw Exception('No store found');
        }
      }

      final allOrders = await _client.storeOrder.getStoreOrders(
        userId: _userId!,
        storeId: storeId!,
        limit: 200,
        offset: 0,
      );

      debugPrint('[StoreOrderController] ✅ Loaded ${allOrders.length} orders');
      orders.assignAll(allOrders);

      // Preload client names for recent orders display
      final uniqueClientIds = allOrders.map((o) => o.clientId).toSet();
      for (final cid in uniqueClientIds) {
        if (!clientNames.containsKey(cid)) {
          try {
            final res = await _client.user.getUserById(userId: cid);
            final name = res.user?.fullName;
            if (name != null && name.isNotEmpty) {
              clientNames[cid] = name;
            }
          } catch (e) {
            debugPrint(
              '[StoreOrderController] ⚠️ Could not fetch user $cid: $e',
            );
          }
        }
      }

      // Filter active vs completed
      activeOrders.assignAll(
        allOrders.where(
          (o) =>
              o.status != StoreOrderStatus.delivered &&
              o.status != StoreOrderStatus.cancelled &&
              o.status != StoreOrderStatus.rejected,
        ),
      );

      completedOrders.assignAll(
        allOrders.where(
          (o) =>
              o.status == StoreOrderStatus.delivered ||
              o.status == StoreOrderStatus.cancelled ||
              o.status == StoreOrderStatus.rejected,
        ),
      );

      debugPrint(
        '[StoreOrderController] Active: ${activeOrders.length}, Completed: ${completedOrders.length}',
      );
    } catch (e) {
      debugPrint('[StoreOrderController] ❌ Error loading orders: $e');
      errorMessage.value = 'Failed to load orders';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load single order details
  Future<void> loadOrderDetails(int orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final order = await _client.storeOrder.getOrder(orderId);
      selectedOrder.value = order;

      // Also load delivery request if exists
      if (order != null) {
        await loadDeliveryRequest(orderId);
      }
    } catch (e) {
      debugPrint('[StoreOrderController] Error loading order: $e');
      errorMessage.value = 'Failed to load order details';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load order details by order number (fallback)
  Future<void> loadOrderDetailsByNumber(String orderNumber) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final order = await _client.storeOrder.getOrderByNumber(orderNumber);
      selectedOrder.value = order;

      if (order?.id != null) {
        await loadDeliveryRequest(order!.id!);
      }
    } catch (e) {
      debugPrint('[StoreOrderController] Error loading order by number: $e');
      errorMessage.value = 'Failed to load order details';
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // ORDER ACTIONS
  // ============================================================

  /// Confirm a pending order
  Future<bool> confirmOrder(int orderId, {int? estimatedMinutes}) async {
    if (_userId == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final updated = await _client.storeOrder.confirmOrder(
        userId: _userId!,
        orderId: orderId,
        storeNotes: estimatedMinutes != null
            ? 'ETA ${estimatedMinutes}m'
            : null,
      );

      if (updated != null) {
        successMessage.value = 'Order confirmed';
        await loadOrders();
        selectedOrder.value = updated;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error confirming order: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Reject a pending order
  Future<bool> rejectOrder(int orderId, String reason) async {
    if (_userId == null) return false;
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final updated = await _client.storeOrder.rejectOrder(
        userId: _userId!,
        orderId: orderId,
        reason: reason,
      );

      if (updated != null) {
        successMessage.value = 'Order rejected';
        await loadOrders();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error rejecting order: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Mark order as preparing
  Future<bool> markPreparing(int orderId) async {
    if (_userId == null) return false;
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final updated = await _client.storeOrder.markPreparing(
        userId: _userId!,
        orderId: orderId,
      );

      if (updated != null) {
        successMessage.value = 'Order marked as preparing';
        await loadOrders();
        selectedOrder.value = updated;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error marking preparing: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Mark order as ready
  Future<bool> markReady(int orderId) async {
    if (_userId == null) return false;
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final updated = await _client.storeOrder.markReady(
        userId: _userId!,
        orderId: orderId,
      );

      if (updated != null) {
        successMessage.value = 'Order ready for pickup';
        await loadOrders();
        selectedOrder.value = updated;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error marking ready: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  // ============================================================
  // DRIVER MANAGEMENT
  // ============================================================

  /// Load nearby drivers for order
  Future<void> loadNearbyDrivers(int orderId) async {
    try {
      isLoadingDrivers.value = true;
      errorMessage.value = '';

      final storeController = Get.find<StoreController>();
      final storeId = storeController.storeId;

      if (storeId == null) {
        errorMessage.value = 'Store not found';
        return;
      }

      final drivers = await _client.storeDelivery.getNearbyDrivers(
        storeId: storeId,
        orderId: orderId,
        radiusKm: 10,
      );

      nearbyDrivers.assignAll(drivers);
    } catch (e) {
      debugPrint('[StoreOrderController] Error loading drivers: $e');
      errorMessage.value = 'Failed to load nearby drivers';
    } finally {
      isLoadingDrivers.value = false;
    }
  }

  /// Request a specific driver for delivery
  Future<bool> requestDriver(int orderId, int driverId) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final storeController = Get.find<StoreController>();
      final storeId = storeController.storeId;

      if (storeId == null) {
        errorMessage.value = 'Store not found';
        return false;
      }

      final request = await _client.storeDelivery.requestDriver(
        storeId: storeId,
        orderId: orderId,
        driverId: driverId,
      );

      if (request != null) {
        currentDeliveryRequest.value = request;
        successMessage.value = 'Driver requested';

        // Start polling for status updates
        _startDeliveryRequestPolling(orderId);

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error requesting driver: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Post a public delivery request (all nearby drivers see it)
  Future<bool> postDeliveryRequest(int orderId) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final storeController = Get.find<StoreController>();
      final storeId = storeController.storeId;

      if (storeId == null) {
        errorMessage.value = 'Store not found';
        return false;
      }

      final request = await _client.storeDelivery.postDeliveryRequest(
        storeId: storeId,
        orderId: orderId,
      );

      if (request != null) {
        currentDeliveryRequest.value = request;
        successMessage.value = 'Delivery request posted';

        // Start polling for status updates (public request)
        _startDeliveryRequestPolling(orderId);

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderController] Error posting delivery request: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Load current delivery request for order
  Future<void> loadDeliveryRequest(int orderId) async {
    try {
      final request = await _client.storeDelivery.getOrderDeliveryRequest(
        orderId: orderId,
      );
      currentDeliveryRequest.value = request;

      // Start polling if request is pending
      if (request?.status == 'pending') {
        _startDeliveryRequestPolling(orderId);
      } else {
        _stopDeliveryRequestPolling();
      }
    } catch (e) {
      debugPrint('[StoreOrderController] Error loading delivery request: $e');
    }
  }

  /// Start polling for delivery request status updates
  void _startDeliveryRequestPolling(int orderId) {
    // Don't start if already polling
    if (_deliveryRequestPollingTimer?.isActive == true) {
      debugPrint(
        '[StoreOrderController] 🔄 Already polling for delivery request',
      );
      return;
    }

    debugPrint(
      '[StoreOrderController] 🔄 Starting delivery request polling for order $orderId',
    );
    isWaitingForDriver.value = true;

    // Poll every 3 seconds
    _deliveryRequestPollingTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) async {
      try {
        final request = await _client.storeDelivery.getOrderDeliveryRequest(
          orderId: orderId,
        );

        if (request == null) {
          debugPrint(
            '[StoreOrderController] 📭 No delivery request found, stopping poll',
          );
          _stopDeliveryRequestPolling();
          return;
        }

        final previousStatus = currentDeliveryRequest.value?.status;
        currentDeliveryRequest.value = request;

        debugPrint(
          '[StoreOrderController] 🔄 Polled delivery request: status=${request.status}',
        );

        // Check if status changed
        if (request.status != previousStatus) {
          debugPrint(
            '[StoreOrderController] ✅ Delivery request status changed: $previousStatus -> ${request.status}',
          );

          // Refresh the order to get updated status
          await loadOrderDetails(orderId);

          // Stop polling if accepted, rejected, or expired
          if (request.status == 'accepted' ||
              request.status == 'rejected' ||
              request.status == 'expired') {
            _stopDeliveryRequestPolling();

            // Show notification
            if (request.status == 'accepted') {
              Get.snackbar(
                'Driver Accepted! 🎉',
                'A driver has accepted this delivery request',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Get.theme.colorScheme.primaryContainer,
                colorText: Get.theme.colorScheme.onPrimaryContainer,
                duration: const Duration(seconds: 4),
              );
            } else if (request.status == 'rejected') {
              Get.snackbar(
                'Driver Rejected',
                'The driver has rejected this delivery request',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Get.theme.colorScheme.errorContainer,
                colorText: Get.theme.colorScheme.onErrorContainer,
                duration: const Duration(seconds: 4),
              );
            }
          }
        }
      } catch (e) {
        debugPrint(
          '[StoreOrderController] ❌ Error polling delivery request: $e',
        );
      }
    });
  }

  /// Stop polling for delivery request status
  void _stopDeliveryRequestPolling() {
    if (_deliveryRequestPollingTimer?.isActive == true) {
      debugPrint('[StoreOrderController] 🛑 Stopping delivery request polling');
      _deliveryRequestPollingTimer?.cancel();
      _deliveryRequestPollingTimer = null;
    }
    isWaitingForDriver.value = false;
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Parse items JSON from order
  List<Map<String, dynamic>> parseOrderItems(StoreOrder order) {
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(order.itemsJson));
    } catch (_) {
      return [];
    }
  }

  /// Get status display text
  String getStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'Pending';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready';
      case StoreOrderStatus.driverAssigned:
        return 'Driver Assigned';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up';
      case StoreOrderStatus.inDelivery:
        return 'In Delivery';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      case StoreOrderStatus.cancelled:
        return 'Cancelled';
      case StoreOrderStatus.rejected:
        return 'Rejected';
    }
  }

  /// Get status color
  Color getStatusColor(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return Colors.orange;
      case StoreOrderStatus.confirmed:
        return Colors.blue;
      case StoreOrderStatus.preparing:
        return Colors.purple;
      case StoreOrderStatus.ready:
        return Colors.teal;
      case StoreOrderStatus.driverAssigned:
        return Colors.indigo;
      case StoreOrderStatus.pickedUp:
        return Colors.cyan;
      case StoreOrderStatus.inDelivery:
        return Colors.lightBlue;
      case StoreOrderStatus.delivered:
        return Colors.green;
      case StoreOrderStatus.cancelled:
        return Colors.red;
      case StoreOrderStatus.rejected:
        return Colors.red.shade700;
    }
  }

  /// Get display name for a client id
  String getClientName(int clientId) {
    return clientNames[clientId] ?? 'Client #$clientId';
  }
}
