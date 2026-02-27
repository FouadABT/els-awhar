import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:geolocator/geolocator.dart';
import 'auth_controller.dart';

/// Driver Store Delivery Controller
/// Handles driver's store delivery requests and active deliveries
class DriverStoreDeliveryController extends GetxController {
  late final Client _client;
  late final AuthController _authController;

  /// Get current user ID
  int? get _userId => _authController.currentUser.value?.id;

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// Available store delivery requests
  final RxList<StoreDeliveryRequest> availableRequests =
      <StoreDeliveryRequest>[].obs;

  /// Active store deliveries (accepted but not yet delivered)
  final RxList<StoreOrder> activeDeliveries = <StoreOrder>[].obs;

  /// Completed store deliveries
  final RxList<StoreOrder> completedDeliveries = <StoreOrder>[].obs;

  /// Current delivery in progress
  final Rx<StoreOrder?> currentDelivery = Rx<StoreOrder?>(null);

  /// Current delivery store info
  final Rx<Store?> currentStore = Rx<Store?>(null);

  /// Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingRequests = false.obs;
  final RxBool isProcessing = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  /// Success message
  final RxString successMessage = ''.obs;

  /// Driver's current location
  final RxDouble currentLat = 0.0.obs;
  final RxDouble currentLng = 0.0.obs;

  // ============================================================
  // GETTERS
  // ============================================================

  /// Get direct requests (addressed specifically to this driver)
  List<StoreDeliveryRequest> get directRequests =>
      availableRequests.where((r) => r.requestType == 'direct').toList();

  /// Get public requests
  List<StoreDeliveryRequest> get publicRequests =>
      availableRequests.where((r) => r.requestType == 'public').toList();

  /// Whether driver has active delivery
  bool get hasActiveDelivery => currentDelivery.value != null;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _client = Get.find<Client>();
    _authController = Get.find<AuthController>();
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('[DriverStoreDeliveryController] 🚀 onReady - Starting data load...');
    loadAvailableRequests();
    loadActiveDeliveries();
    loadCompletedDeliveries();
  }

  @override
  /// Refresh all data
  Future<void> refresh() async {
    debugPrint('[DriverStoreDeliveryController] 🔄 Refreshing all data...');
    await Future.wait([
      loadAvailableRequests(),
      loadActiveDeliveries(),
      loadCompletedDeliveries(),
    ]);
  }

  /// Update driver's current location
  void updateLocation(double lat, double lng) {
    currentLat.value = lat;
    currentLng.value = lng;
  }

  // ============================================================
  // LOAD REQUESTS & DELIVERIES
  // ============================================================

  /// Load available store delivery requests
  Future<void> loadAvailableRequests() async {
    if (_userId == null) {
      debugPrint('[DriverStoreDeliveryController] ⚠️ userId is null');
      return;
    }

    try {
      isLoadingRequests.value = true;
      errorMessage.value = '';

      debugPrint(
        '[DriverStoreDeliveryController] 📱 Starting load with userId: $_userId',
      );

      // Get driver's current location (from user record or GPS)
      double lat = currentLat.value;
      double lng = currentLng.value;

      // If location is not set (0,0), try to get from user record or GPS
      if (lat == 0 && lng == 0) {
        final user = _authController.currentUser.value;
        if (user?.currentLatitude != null && user?.currentLongitude != null) {
          lat = user!.currentLatitude!;
          lng = user.currentLongitude!;
          debugPrint(
            '[DriverStoreDeliveryController] 📍 Using saved location: $lat, $lng',
          );
        } else {
          // Try GPS
          try {
            final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            lat = position.latitude;
            lng = position.longitude;
            debugPrint(
              '[DriverStoreDeliveryController] 📡 Using GPS location: $lat, $lng',
            );
          } catch (e) {
            debugPrint('[DriverStoreDeliveryController] ❌ GPS error: $e');
            // Use default Casablanca location for testing
            lat = 33.5731;
            lng = -7.5898;
            debugPrint(
              '[DriverStoreDeliveryController] 📍 Using default location: $lat, $lng',
            );
          }
        }
        // Update stored location
        currentLat.value = lat;
        currentLng.value = lng;
      }

      debugPrint(
        '[DriverStoreDeliveryController] 🌍 Loading requests at location: ($lat, $lng)',
      );

      final requests = await _client.storeDelivery.getStoreDeliveryRequests(
        driverId: _userId!,
        latitude: lat,
        longitude: lng,
        radiusKm: 50, // Increased radius for testing
      );

      debugPrint(
        '[DriverStoreDeliveryController] ✅ Loaded ${requests.length} total requests',
      );
      
      // Log direct vs public
      final directCount = requests.where((r) => r.requestType == 'direct').length;
      final publicCount = requests.where((r) => r.requestType == 'public').length;
      debugPrint(
        '[DriverStoreDeliveryController] 📊 Direct: $directCount | Public: $publicCount',
      );
      
      // Log each request
      for (final req in requests) {
        debugPrint(
          '[DriverStoreDeliveryController] 📦 Request ${req.id}: type=${req.requestType}, targetDriverId=${req.targetDriverId}, status=${req.status}',
        );
      }
      
      availableRequests.assignAll(requests);
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] ❌ Error loading requests: $e');
      errorMessage.value = 'Failed to load delivery requests';
    } finally {
      isLoadingRequests.value = false;
    }
  }

  /// Load driver's active store deliveries
  Future<void> loadActiveDeliveries() async {
    if (_userId == null) {
      debugPrint('[DriverStoreDeliveryController] ⚠️ Cannot load active deliveries - userId is null');
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      debugPrint('[DriverStoreDeliveryController] 📦 Loading active deliveries for userId: $_userId');

      final orders = await _client.storeOrder.getDriverStoreOrders(
        driverId: _userId!,
        activeOnly: true,
        limit: 100,
        offset: 0,
      );

      debugPrint('[DriverStoreDeliveryController] ✅ Loaded ${orders.length} active deliveries');
      activeDeliveries.assignAll(orders);

      // Set current delivery (first active one)
      if (orders.isNotEmpty) {
        currentDelivery.value = orders.first;
        await loadStoreDetails(orders.first.storeId);
        debugPrint('[DriverStoreDeliveryController] 🚚 Current delivery set: Order #${orders.first.id}');
      } else {
        currentDelivery.value = null;
        currentStore.value = null;
        debugPrint('[DriverStoreDeliveryController] ℹ️ No active delivery');
      }
    } catch (e) {
      debugPrint(
        '[DriverStoreDeliveryController] ❌ Error loading active deliveries: $e',
      );
      errorMessage.value = 'Failed to load deliveries';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load driver's completed store deliveries (last 10)
  Future<void> loadCompletedDeliveries() async {
    if (_userId == null) {
      debugPrint('[DriverStoreDeliveryController] ⚠️ Cannot load completed deliveries - userId is null');
      return;
    }

    try {
      debugPrint('[DriverStoreDeliveryController] 📦 Loading completed deliveries for userId: $_userId');

      final orders = await _client.storeOrder.getDriverStoreOrders(
        driverId: _userId!,
        activeOnly: false,
        limit: 10,
        offset: 0,
      );

      // Filter only delivered orders
      final completed = orders.where((o) => 
        o.status == StoreOrderStatus.delivered
      ).toList();

      debugPrint('[DriverStoreDeliveryController] ✅ Loaded ${completed.length} completed deliveries');
      completedDeliveries.assignAll(completed);
    } catch (e) {
      debugPrint(
        '[DriverStoreDeliveryController] ❌ Error loading completed deliveries: $e',
      );
    }
  }

  /// Load store details for current delivery
  Future<void> loadStoreDetails(int storeId) async {
    try {
      final store = await _client.store.getStoreById(storeId);
      currentStore.value = store;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error loading store: $e');
    }
  }

  // ============================================================
  // REQUEST ACTIONS
  // ============================================================

  /// Accept a store delivery request
  Future<bool> acceptRequest(int requestId) async {
    if (_userId == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final order = await _client.storeDelivery.acceptStoreDelivery(
        driverId: _userId!,
        requestId: requestId,
      );

      if (order != null) {
        successMessage.value = 'Delivery accepted';
        currentDelivery.value = order;
        await loadStoreDetails(order.storeId);
        await loadAvailableRequests(); // Remove from available
        await loadActiveDeliveries();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error accepting request: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Reject a store delivery request
  Future<bool> rejectRequest(int requestId, {String? reason}) async {
    if (_userId == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final success = await _client.storeDelivery.rejectStoreDelivery(
        driverId: _userId!,
        requestId: requestId,
        reason: reason,
      );

      if (success) {
        successMessage.value = 'Request declined';
        await loadAvailableRequests();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error rejecting request: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  // ============================================================
  // DELIVERY FLOW
  // ============================================================

  /// Mark arrived at store
  Future<bool> arrivedAtStore() async {
    if (_userId == null || currentDelivery.value == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final order = await _client.storeDelivery.arrivedAtStore(
        driverId: _userId!,
        orderId: currentDelivery.value!.id!,
      );

      if (order != null) {
        currentDelivery.value = order;
        successMessage.value = 'Marked as arrived at store';
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error marking arrived: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Mark order as picked up (and enter amount paid to store)
  Future<bool> pickedUp(double amountPaidToStore) async {
    if (_userId == null || currentDelivery.value == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final order = await _client.storeDelivery.pickedUp(
        driverId: _userId!,
        orderId: currentDelivery.value!.id!,
        amountPaidToStore: amountPaidToStore,
      );

      if (order != null) {
        currentDelivery.value = order;
        successMessage.value = 'Order picked up';
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error marking picked up: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Mark arrived at client
  Future<bool> arrivedAtClient() async {
    if (_userId == null || currentDelivery.value == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final order = await _client.storeDelivery.arrivedAtClient(
        driverId: _userId!,
        orderId: currentDelivery.value!.id!,
      );

      if (order != null) {
        currentDelivery.value = order;
        successMessage.value = 'Arrived at customer';
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error marking arrived: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  /// Mark order as delivered
  Future<bool> delivered(double amountCollected) async {
    if (_userId == null || currentDelivery.value == null) return false;

    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final order = await _client.storeDelivery.delivered(
        driverId: _userId!,
        orderId: currentDelivery.value!.id!,
        amountCollected: amountCollected,
      );

      if (order != null) {
        successMessage.value = 'Order delivered successfully!';
        currentDelivery.value = null;
        currentStore.value = null;
        await loadActiveDeliveries();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriverStoreDeliveryController] Error marking delivered: $e');
      errorMessage.value = e.toString();
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Get status display text
  String getStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
        return 'Go to Store';
      case StoreOrderStatus.pickedUp:
        return 'Delivering';
      case StoreOrderStatus.inDelivery:
        return 'At Customer';
      case StoreOrderStatus.delivered:
        return 'Completed';
      default:
        return status.name;
    }
  }

  /// Get next action text
  String getNextActionText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 'Arrived at Store';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up Order';
      case StoreOrderStatus.inDelivery:
        return 'Delivered';
      default:
        return 'Next';
    }
  }

  /// Get status color
  Color getStatusColor(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.ready:
      case StoreOrderStatus.driverAssigned:
        return Colors.blue;
      case StoreOrderStatus.pickedUp:
        return Colors.purple;
      case StoreOrderStatus.inDelivery:
        return Colors.teal;
      case StoreOrderStatus.delivered:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Calculate driver earnings for a request
  double calculateEarnings(StoreDeliveryRequest request) {
    return request.driverEarnings;
  }
}
