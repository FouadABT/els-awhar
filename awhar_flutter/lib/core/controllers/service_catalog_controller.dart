import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'dart:async';

import 'auth_controller.dart';
import '../services/live_drivers_service.dart';
import '../utils/currency_helper.dart';

/// Controller for managing service catalog browsing and search
class ServiceCatalogController extends GetxController {
  final Client _client = Get.find<Client>();
  final AuthController _authController = Get.find<AuthController>();
  late final LiveDriversService _liveDriversService;

  // ============================================================
  // STATE
  // ============================================================

  /// All service categories
  final RxList<ServiceCategory> categories = <ServiceCategory>[].obs;

  /// Drivers with their services (search results)
  final RxList<DriverProfile> drivers = <DriverProfile>[].obs;

  /// Services for currently viewed driver
  final RxList<DriverService> driverServices = <DriverService>[].obs;

  /// Currently selected category filter
  final Rx<ServiceCategory?> selectedCategory = Rx<ServiceCategory?>(null);

  /// Currently selected service filter
  final Rx<Service?> selectedService = Rx<Service?>(null);

  /// Loading states
  final RxBool isLoadingCategories = false.obs;
  final RxBool isLoadingDrivers = false.obs;
  final RxBool isLoadingServices = false.obs;

  /// Error messages
  final RxString errorMessage = ''.obs;

  /// Search filters
  final RxDouble minPrice = 0.0.obs;
  final RxDouble maxPrice = 1000.0.obs;
  final RxDouble maxDistance = 50.0.obs;
  final RxDouble minRating = 0.0.obs;
  final RxBool onlineOnly = false.obs;

  /// Search query
  final RxString searchQuery = ''.obs;

  // ============================================================
  // FAVORITES
  // ============================================================

  /// Set of favorited driver IDs
  final RxSet<int> favoritedDriverIds = <int>{}.obs;

  /// List of favorited drivers
  final RxList<DriverProfile> favoriteDrivers = <DriverProfile>[].obs;

  /// Loading state for favorites
  final RxBool isLoadingFavorites = false.obs;

  // ============================================================
  // LIVE DRIVERS
  // ============================================================

  /// Live online drivers
  final RxList<DriverProfile> liveDrivers = <DriverProfile>[].obs;

  /// Loading state for live drivers
  final RxBool isLoadingLiveDrivers = false.obs;

  /// Timer for periodic location refresh
  Timer? _liveDriversRefreshTimer;

  // ============================================================
  // INITIALIZATION
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _liveDriversService = Get.find<LiveDriversService>();
    loadCategories();
    loadNearbyDrivers();
    loadFavorites();
    
    // Listen to live drivers service changes
    ever(_liveDriversService.onlineDriverIds, (_) {
      if (liveDrivers.isNotEmpty) {
        loadLiveDrivers();
      }
    });
  }
  
  @override
  void onClose() {
    _liveDriversRefreshTimer?.cancel();
    super.onClose();
  }

  // ============================================================
  // CATEGORY MANAGEMENT
  // ============================================================

  /// Load all service categories
  Future<void> loadCategories() async {
    if (isLoadingCategories.value) return;

    isLoadingCategories.value = true;
    errorMessage.value = '';

    try {
      final result = await _client.service.getCategories(activeOnly: true);
      categories.value = result;
    } catch (e) {
      errorMessage.value = 'Failed to load categories: $e';
      if (kDebugMode) print('Error loading categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  /// Select a category to filter services
  void selectCategory(ServiceCategory? category) {
    selectedCategory.value = category;
    loadNearbyDrivers();
  }

  /// Select a specific service
  void selectService(Service? service) {
    selectedService.value = service;
    loadNearbyDrivers();
  }

  // ============================================================
  // DRIVER SEARCH
  // ============================================================

  /// Load nearby drivers with services
  Future<void> loadNearbyDrivers() async {
    if (isLoadingDrivers.value) return;

    isLoadingDrivers.value = true;
    errorMessage.value = '';

    try {
      // TODO: Get actual user location from GPS
      // For now use Casablanca coordinates
      final double userLat = 33.5731;
      final double userLng = -7.5898;

      final result = await _client.service.searchDriversWithServices(
        clientLat: userLat,
        clientLng: userLng,
        radiusKm: maxDistance.value,
        priceMin: minPrice.value > 0 ? minPrice.value : null,
        priceMax: maxPrice.value < 1000 ? maxPrice.value : null,
        minRating: minRating.value > 0 ? minRating.value : null,
        onlineOnly: onlineOnly.value,
        categoryId: selectedCategory.value?.id,
        limit: 50,
      );

      drivers.value = result;
    } catch (e) {
      errorMessage.value = 'Failed to load nearby drivers: $e';
      if (kDebugMode) print('Error loading nearby drivers: $e');
    } finally {
      isLoadingDrivers.value = false;
    }
  }

  /// Search drivers by query string
  Future<void> searchDrivers(String query) async {
    searchQuery.value = query;

    // If query is empty, load nearby drivers
    if (query.isEmpty) {
      await loadNearbyDrivers();
      return;
    }

    isLoadingDrivers.value = true;
    errorMessage.value = '';

    try {
      // For now, filter existing drivers by name
      // TODO: Implement backend search endpoint with full-text search
      final filtered = drivers.where((driver) {
        return driver.displayName.toLowerCase().contains(query.toLowerCase());
      }).toList();

      drivers.value = filtered;
    } catch (e) {
      errorMessage.value = 'Search failed: $e';
      if (kDebugMode) print('Error searching drivers: $e');
    } finally {
      isLoadingDrivers.value = false;
    }
  }

  // ============================================================
  // DRIVER CATALOG
  // ============================================================

  /// Get full catalog of services for a specific driver
  Future<void> getDriverCatalog(int driverId) async {
    isLoadingServices.value = true;
    errorMessage.value = '';

    try {
      final result = await _client.service.getDriverCatalog(
        driverId: driverId,
        activeOnly: true,
      );
      driverServices.value = result;
    } catch (e) {
      errorMessage.value = 'Failed to load driver services: $e';
      if (kDebugMode) print('Error loading driver catalog: $e');
    } finally {
      isLoadingServices.value = false;
    }
  }

  // ============================================================
  // ANALYTICS
  // ============================================================

  /// Track service view
  Future<void> trackServiceView(int serviceId) async {
    try {
      await _client.service.trackServiceView(driverServiceId: serviceId);
    } catch (e) {
      if (kDebugMode) print('Error tracking service view: $e');
    }
  }

  /// Track service inquiry
  Future<void> trackServiceInquiry(int serviceId) async {
    try {
      await _client.service.trackServiceInquiry(driverServiceId: serviceId);
    } catch (e) {
      if (kDebugMode) print('Error tracking service inquiry: $e');
    }
  }

  // ============================================================
  // FILTERS
  // ============================================================

  /// Apply multiple filters at once
  Future<void> applyFilters({
    double? minPrice,
    double? maxPrice,
    double? maxDistance,
    double? minRating,
    bool? onlineOnly,
  }) async {
    if (minPrice != null) this.minPrice.value = minPrice;
    if (maxPrice != null) this.maxPrice.value = maxPrice;
    if (maxDistance != null) this.maxDistance.value = maxDistance;
    if (minRating != null) this.minRating.value = minRating;
    if (onlineOnly != null) this.onlineOnly.value = onlineOnly;

    await loadNearbyDrivers();
  }

  /// Reset all filters to default
  Future<void> resetFilters() async {
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
    maxDistance.value = 50.0;
    minRating.value = 0.0;
    onlineOnly.value = false;
    selectedCategory.value = null;
    selectedService.value = null;
    searchQuery.value = '';

    await loadNearbyDrivers();
  }

  /// Set max distance filter and reload
  void setMaxDistance(double distance) {
    maxDistance.value = distance;
    loadNearbyDrivers();
  }

  /// Set minimum rating filter and reload
  void setMinRating(double rating) {
    minRating.value = rating;
    loadNearbyDrivers();
  }

  /// Get count of active filters
  int get activeFilterCount {
    int count = 0;
    if (minPrice.value > 0) count++;
    if (maxPrice.value < 1000) count++;
    if (maxDistance.value < 50) count++;
    if (minRating.value > 0) count++;
    if (onlineOnly.value) count++;
    if (selectedCategory.value != null) count++;
    if (selectedService.value != null) count++;
    return count;
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Get distance to driver in km
  /// TODO: Calculate actual distance using GPS coordinates
  double? getDistanceToDriver(DriverProfile driver) {
    // Placeholder - return null for now
    // Will be implemented when we have proper location services
    return null;
  }

  /// Get price range from list of services
  String getPriceRange(List<DriverService> services) {
    if (services.isEmpty) return 'N/A';

    final prices = services
        .where((s) => s.basePrice != null)
        .map((s) => s.basePrice!)
        .toList();

    if (prices.isEmpty) return 'Contact for pricing';

    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);

    if (minPrice == maxPrice) {
      return CurrencyHelper.format(minPrice);
    }

    return CurrencyHelper.formatRange(minPrice, maxPrice);
  }

  /// Refresh all data
  Future<void> refresh() async {
    await Future.wait([
      loadCategories(),
      loadNearbyDrivers(),
      loadFavorites(),
    ]);
  }

  // ============================================================
  // FAVORITES MANAGEMENT
  // ============================================================

  /// Load favorited drivers for current user
  Future<void> loadFavorites() async {
    final user = _authController.currentUser.value;
    if (user == null || user.id == null) return;

    isLoadingFavorites.value = true;

    try {
      // Load favorite driver IDs
      final ids = await _client.service.getFavoriteDriverIds(clientId: user.id!);
      favoritedDriverIds.value = ids.toSet();

      // Load full driver profiles
      if (ids.isNotEmpty) {
        final drivers = await _client.service.getFavoriteDrivers(clientId: user.id!);
        favoriteDrivers.value = drivers;
      } else {
        favoriteDrivers.value = [];
      }
    } catch (e) {
      if (kDebugMode) print('Error loading favorites: $e');
    } finally {
      isLoadingFavorites.value = false;
    }
  }

  /// Toggle favorite status for a driver
  Future<void> toggleFavorite(int driverId) async {
    final user = _authController.currentUser.value;
    if (user == null || user.id == null) return;

    try {
      final isFavorited = await _client.service.toggleFavorite(
        clientId: user.id!,
        driverId: driverId,
      );

      if (isFavorited) {
        favoritedDriverIds.add(driverId);
        // Reload favorites to get full driver profile
        await loadFavorites();
      } else {
        favoritedDriverIds.remove(driverId);
        favoriteDrivers.removeWhere((d) => d.id == driverId);
      }
    } catch (e) {
      if (kDebugMode) print('Error toggling favorite: $e');
    }
  }

  /// Check if a driver is favorited
  bool isFavorite(int driverId) {
    return favoritedDriverIds.contains(driverId);
  }

  // ============================================================
  // LIVE DRIVERS MANAGEMENT
  // ============================================================

  /// Load online drivers nearby with real-time updates
  Future<void> loadLiveDrivers() async {
    if (isLoadingLiveDrivers.value) return;

    isLoadingLiveDrivers.value = true;
    errorMessage.value = '';

    try {
      // Get user's actual location (using same as nearby drivers for consistency)
      const double centerLat = 33.5731; // Casablanca - TODO: Get actual user location from GPS
      const double centerLng = -7.5898;
      
      print('[ServiceCatalog] 🌍 Loading live drivers near ($centerLat, $centerLng), radius: ${maxDistance.value} km');
      
      // Get online driver IDs from Firebase (real-time)
      final onlineDriverIds = _liveDriversService.onlineDriverIds.value.toList();
      print('[ServiceCatalog] 🔥 Firebase detected ${onlineDriverIds.length} drivers online: $onlineDriverIds');

      if (onlineDriverIds.isEmpty) {
        liveDrivers.value = [];
        print('[ServiceCatalog] 📍 No live drivers detected');
        return;
      }

      // Business Model: Show ALL online drivers regardless of service configuration
      // Firebase IDs are USER IDs; we need to map them to driver profiles by userId
      final liveDriverList = <DriverProfile>[];

      print('[ServiceCatalog] 📡 Fetching profiles for ${onlineDriverIds.length} online drivers...');

      // Load all drivers once (large radius) and filter by userId
      final allDrivers = await _client.service.searchDriversWithServices(
        clientLat: centerLat,
        clientLng: centerLng,
        radiusKm: 500, // Wide net to include all drivers
        onlineOnly: false,
        limit: 1000,
      );
      print('[ServiceCatalog] 📊 Loaded ${allDrivers.length} drivers from catalog for matching');

      for (int userId in onlineDriverIds) {
        try {
          final driverProfile = allDrivers.firstWhereOrNull((d) => d.userId == userId);

          if (driverProfile != null) {
            liveDriverList.add(driverProfile);
            print('[ServiceCatalog]   ✅ User $userId -> Driver ${driverProfile.id}: ${driverProfile.displayName}');
          } else {
            print('[ServiceCatalog]   ⚠️ User $userId online in Firebase but no driver profile found');
          }
        } catch (e, stackTrace) {
          print('[ServiceCatalog]   ❌ Failed to process user $userId: $e');
          print('[ServiceCatalog]   Stack: $stackTrace');
        }
      }

      liveDrivers.value = liveDriverList;
      print('[ServiceCatalog] ✅ Found ${liveDriverList.length} live drivers');
      for (var driver in liveDriverList) {
        print('[ServiceCatalog]   ✅ Live: ID=${driver.id}, UserId=${driver.userId}, Name=${driver.displayName}, Online=${driver.isOnline}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to load live drivers: $e';
      print('[ServiceCatalog] ❌ Error loading live drivers: $e');
    } finally {
      isLoadingLiveDrivers.value = false;
    }
  }

  /// Start monitoring live drivers with periodic refresh
  void startLiveDriversMonitoring() {
    // Start listening to Firebase presence
    _liveDriversService.startListening();
    
    // Initial load
    loadLiveDrivers();
    
    // Refresh every 30 seconds for location updates
    _liveDriversRefreshTimer?.cancel();
    _liveDriversRefreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => loadLiveDrivers(),
    );
    
    print('[ServiceCatalog] 🎬 Started live drivers monitoring');
  }

  /// Stop monitoring live drivers
  void stopLiveDriversMonitoring() {
    _liveDriversRefreshTimer?.cancel();
    _liveDriversRefreshTimer = null;
    liveDrivers.clear();
    print('[ServiceCatalog] ⏸️ Stopped live drivers monitoring');
  }

  /// Get last seen text for a driver
  String getLastSeenText(DriverProfile driver) {
    // If we don't have a location timestamp but driver is marked online, show a friendly status
    if (driver.lastLocationUpdatedAt == null) {
      return driver.isOnline == true ? 'Online now' : 'Location unavailable';
    }
    
    final lastSeen = driver.lastLocationUpdatedAt!;
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inSeconds < 60) {
      return 'Active now';
    } else if (difference.inMinutes < 60) {
      return 'Active ${difference.inMinutes}m ago';
    } else {
      return 'Active ${difference.inHours}h ago';
    }
  }
}
