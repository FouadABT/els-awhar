import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'auth_controller.dart';

/// Client Store Orders List Controller
/// Handles client's store orders (from store catalog browsing/ordering)
/// Note: This is different from ClientStoreOrderController in client_store_order_screen.dart
/// which manages a single order's details
class ClientStoreOrdersController extends GetxController {
  late final Client _client;
  late final AuthController _authController;
  Worker? _authWorker;

  /// Get current user ID
  int? get _userId => _authController.currentUser.value?.id;

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// All client's store orders
  final RxList<StoreOrder> orders = <StoreOrder>[].obs;

  /// Active store orders (not delivered/cancelled)
  final RxList<StoreOrder> activeOrders = <StoreOrder>[].obs;

  /// Completed store orders
  final RxList<StoreOrder> completedOrders = <StoreOrder>[].obs;

  /// Loading states
  final RxBool isLoading = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _client = Get.find<Client>();
    _authController = Get.find<AuthController>();

    // Listen for auth changes to reload orders when user logs in
    _authWorker = ever(_authController.currentUser, (user) {
      if (user != null) {
        debugPrint(
          '[ClientStoreOrdersController] 👤 User changed, reloading orders...',
        );
        loadOrders();
      } else {
        // Clear orders when user logs out
        orders.clear();
        activeOrders.clear();
        completedOrders.clear();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Load immediately if user is already logged in
    if (_userId != null) {
      loadOrders();
    }
  }

  @override
  void onClose() {
    _authWorker?.dispose();
    super.onClose();
  }

  // ============================================================
  // ORDERS LOADING
  // ============================================================

  /// Load all client's store orders
  Future<void> loadOrders() async {
    if (_userId == null) {
      debugPrint('[ClientStoreOrdersController] ❌ No user ID found');
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Load all client's orders
      final allOrders = await _client.storeOrder.getClientOrders(
        clientId: _userId!,
        limit: 100,
        offset: 0,
      );

      debugPrint(
        '[ClientStoreOrdersController] ✅ Loaded ${allOrders.length} orders',
      );

      // Separate into active and completed
      final active = <StoreOrder>[];
      final completed = <StoreOrder>[];

      for (final order in allOrders) {
        if (_isActiveStatus(order.status)) {
          active.add(order);
        } else {
          completed.add(order);
        }
      }

      // Sort by creation date (newest first)
      active.sort((a, b) => (b.createdAt).compareTo(a.createdAt));
      completed.sort((a, b) => (b.createdAt).compareTo(a.createdAt));

      orders.assignAll(allOrders);
      activeOrders.assignAll(active);
      completedOrders.assignAll(completed);

      debugPrint(
        '[ClientStoreOrdersController] Active: ${active.length}, Completed: ${completed.length}',
      );
    } catch (e) {
      debugPrint('[ClientStoreOrdersController] ❌ Error loading orders: $e');
      errorMessage.value = 'Failed to load orders';
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if order status is active
  bool _isActiveStatus(StoreOrderStatus status) {
    return status == StoreOrderStatus.pending ||
        status == StoreOrderStatus.confirmed ||
        status == StoreOrderStatus.preparing ||
        status == StoreOrderStatus.ready ||
        status == StoreOrderStatus.driverAssigned ||
        status == StoreOrderStatus.pickedUp ||
        status == StoreOrderStatus.inDelivery;
  }

  /// Refresh orders
  Future<void> refresh() async {
    await loadOrders();
  }
}
