import 'dart:math';

import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/auth_controller.dart';
import 'package:awhar_flutter/core/services/location_service.dart';
import 'package:awhar_flutter/core/services/request_service.dart';
import 'package:awhar_flutter/core/services/analytics_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Controller for managing service requests
class RequestController extends GetxController {
  final RequestService _requestService = Get.find<RequestService>();
  final AuthController _authController = Get.find<AuthController>();
  final LocationService _locationService = Get.find<LocationService>();

  // Reactive state - Single active request (for clients, or first one for drivers)
  final Rx<ServiceRequest?> activeRequest = Rx<ServiceRequest?>(null);
  // Multiple active requests (for drivers with batch deliveries)
  final RxList<ServiceRequest> activeRequests = <ServiceRequest>[].obs;
  final RxList<ServiceRequest> nearbyRequests = <ServiceRequest>[].obs;
  final RxList<ServiceRequest> requestHistory = <ServiceRequest>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString driverCity = ''.obs;

  // Request creation form state
  final Rx<ServiceType> selectedServiceType = ServiceType.delivery.obs;
  final Rx<Location?> pickupLocation = Rx<Location?>(null);
  final Rx<Location?> destinationLocation = Rx<Location?>(null);
  final RxString notes = ''.obs;
  final RxDouble estimatedPrice = 0.0.obs;
  final RxDouble estimatedDistance = 0.0.obs;

  // NEW: Price negotiation fields
  final RxDouble clientOfferedPrice = 0.0.obs;
  final RxDouble suggestedMinPrice = 0.0.obs;
  final RxDouble suggestedMaxPrice = 0.0.obs;
  final RxDouble suggestedRecommendedPrice = 0.0.obs;

  // NEW: Delivery-specific fields
  final RxString itemDescription = ''.obs;
  final RxString recipientName = ''.obs;
  final RxString recipientPhone = ''.obs;
  final RxString specialInstructions = ''.obs;
  final RxString packageSize = 'Medium'.obs;
  final RxBool isFragile = false.obs;

  // CONCIERGE/PURCHASE Fields
  final RxBool isPurchaseRequired = false.obs;
  final RxDouble estimatedPurchaseCost = 0.0.obs;
  final RxDouble deliveryFeeOffer = 0.0.obs; // What client pays driver
  final RxList<String> attachments = <String>[].obs; // Paths to local images
  final RxBool isFlexiblePickup =
      true.obs; // "Anywhere nearby" vs "Specific place"
  final RxString itemDescriptionText = ''.obs; // "What do you need?"

  // NEW: Pending requests (for client to see offers)
  final RxList<ServiceRequest> pendingRequests = <ServiceRequest>[].obs;

  // CATALOG INTEGRATION: Track catalog-originated requests
  final RxBool fromCatalog = false.obs;
  final Rx<DriverService?> catalogService = Rx<DriverService?>(null);
  final Rx<DriverProfile?> catalogDriver = Rx<DriverProfile?>(null);
  final RxInt catalogServiceId = 0.obs;

  // PHASE 5: Computed properties for negotiation timeline & history
  /// Check if the given request involved price negotiation
  bool didNegotiate(ServiceRequest request) {
    final clientPrice = request.clientOfferedPrice ?? 0.0;
    final agreedPrice = request.agreedPrice ?? 0.0;
    return clientPrice > 0 &&
        agreedPrice > 0 &&
        (clientPrice - agreedPrice).abs() > 0.01;
  }

  /// Get negotiation outcome for a request
  String getNegotiationOutcome(ServiceRequest request) {
    if (didNegotiate(request)) {
      return 'negotiated';
    } else if ((request.clientOfferedPrice ?? 0) > 0 &&
        (request.agreedPrice ?? 0) > 0 &&
        (request.clientOfferedPrice! - request.agreedPrice!).abs() < 0.01) {
      return 'accepted';
    }
    return 'none';
  }

  /// Calculate final earnings for driver (after 5% commission)
  double getFinalEarnings(ServiceRequest request) {
    final agreedPrice = request.agreedPrice ?? 0.0;
    return agreedPrice * 0.95; // Driver gets 95%, platform takes 5%
  }

  @override
  void onInit() {
    super.onInit();
    _initializeDefaultPickupLocation();
    loadActiveRequest();
  }

  /// Initialize pickup location with current location
  Future<void> _initializeDefaultPickupLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      if (position != null) {
        pickupLocation.value = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          address: null,
          placeName: 'Current Location',
          city: null,
          country: 'Morocco',
        );
      }
    } catch (e) {
      print('[RequestController] Error getting current location: $e');
    }
  }

  /// Create a new service request with client offered price
  Future<bool> createRequest() async {
    if (_authController.currentUser.value == null) {
      errorMessage.value = 'errors.authentication_failed'.tr;
      return false;
    }

    // Pickup is optional for flexible/concierge requests
    if (!isFlexiblePickup.value && pickupLocation.value == null) {
      errorMessage.value = 'errors.pickup_location_required'.tr;
      return false;
    }

    if (destinationLocation.value == null) {
      errorMessage.value = 'errors.destination_required'.tr;
      return false;
    }

    if (clientOfferedPrice.value < 15) {
      errorMessage.value = 'negotiation.price_too_low'.tr;
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = await _requestService.createRequest(
        clientId: _authController.currentUser.value!.id!,
        serviceType: selectedServiceType.value,
        pickupLocation: isFlexiblePickup.value ? null : pickupLocation.value,
        destinationLocation: destinationLocation.value!,
        notes: notes.value.isEmpty ? null : notes.value,
        clientOfferedPrice: clientOfferedPrice.value > 0
            ? clientOfferedPrice.value
            : null,
        isPurchaseRequired: isPurchaseRequired.value,
        estimatedPurchaseCost: estimatedPurchaseCost.value > 0
            ? estimatedPurchaseCost.value
            : null,
        itemDescription: itemDescriptionText.value.isEmpty
            ? null
            : itemDescriptionText.value,
        // NEW: Pass catalog context if from catalog
        catalogServiceId: fromCatalog.value ? catalogServiceId.value : null,
        catalogDriverId: fromCatalog.value && catalogDriver.value != null
            ? catalogDriver.value!.id
            : null,
      );

      if (request != null) {
        activeRequest.value = request;
         print('[RequestController] ✅ Request created: ID ${request.id}, from catalog: ${fromCatalog.value}');
        
        // ANALYTICS: Track request created
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            await analytics.trackRequestCreated(
              requestId: request.id!,
              serviceType: selectedServiceType.value.name,
              estimatedPrice: clientOfferedPrice.value,
              city: destinationLocation.value?.city,
              fromCatalog: fromCatalog.value,
              catalogDriverId: catalogDriver.value?.id,
            );
          }
        } catch (e) {
          print('[RequestController] ⚠️ Analytics tracking failed: $e');
        }
        
        // Reset form
        _resetForm();
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'errors.request_creation_failed'.tr;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString().contains('errors.')
          ? e.toString().tr
          : 'errors.request_creation_failed'.tr;
       print('[RequestController] ❌ Request creation failed: $e');
      isLoading.value = false;
      return false;
    }
  }

  /// Reset form after successful creation
  void _resetForm() {
    notes.value = '';
    clientOfferedPrice.value = 0.0;
    suggestedMinPrice.value = 0.0;
    suggestedMaxPrice.value = 0.0;
    suggestedRecommendedPrice.value = 0.0;
    estimatedDistance.value = 0.0;
    estimatedPrice.value = 0.0;
    destinationLocation.value = null;
    itemDescriptionText.value = '';
    estimatedPurchaseCost.value = 0.0;
    deliveryFeeOffer.value = 0.0;
    isPurchaseRequired.value = false;
    isFlexiblePickup.value = true;
    attachments.clear();
    // Clear catalog fields
    fromCatalog.value = false;
    catalogService.value = null;
    catalogDriver.value = null;
    catalogServiceId.value = 0;
    // Keep pickup as current location
  }

  /// Pre-fill request form from catalog service
  void initializeFromCatalog({
    required DriverService service,
    required DriverProfile driver,
  }) {
    fromCatalog.value = true;
    catalogService.value = service;
    catalogDriver.value = driver;
    catalogServiceId.value = service.id ?? 0;

    // Auto-detect service type from category if available
    // Mapping: Moving/Relocation → Task, Delivery → Delivery, Shopping → Purchase
    if (service.categoryId != null) {
      // TODO: Fetch category name from backend to determine service type
      // For now, default to delivery and let form show service selector
      selectedServiceType.value = ServiceType.delivery;
    }

    // Pre-fill description with service title and category
    final description = <String>[
      service.title ?? 'Service',
      if (service.description != null && service.description!.isNotEmpty)
        service.description!,
    ].join(' - ');
    
    itemDescriptionText.value = description;

    // Pre-fill suggested price from service pricing
    if (service.basePrice != null && service.basePrice! > 0) {
      suggestedRecommendedPrice.value = service.basePrice!;
      clientOfferedPrice.value = service.basePrice!;
      
      // Show pricing breakdown
      if (service.priceType == PriceType.per_km && service.pricePerKm != null) {
         print('[RequestController] Service pricing: ${service.pricePerKm} MAD/km');
      } else if (service.priceType == PriceType.per_hour && service.pricePerHour != null) {
         print('[RequestController] Service pricing: ${service.pricePerHour} MAD/hr');
      } else {
         print('[RequestController] Service pricing: ${service.basePrice} MAD (fixed)');
      }
    } else if (service.minPrice != null && service.minPrice! > 0) {
      suggestedRecommendedPrice.value = service.minPrice!;
      clientOfferedPrice.value = service.minPrice!;
    }

    // Mark as flexible pickup (driver comes to client)
    isFlexiblePickup.value = true;
    
    // Set smart location defaults from driver's location
    _setSmartLocationDefaults(driver);
    
     print('[RequestController] ✅ Initialized from catalog: Service #${service.id} by Driver ${driver.displayName}');
  }

  /// Set smart location defaults from driver's last known location
  Future<void> _setSmartLocationDefaults(DriverProfile driver) async {
    try {
      // If driver has a last known location, suggest it as reference point
      if (driver.lastLocationLat != null && driver.lastLocationLng != null) {
        // This is just for context - the actual pickup will be client's flexible location
         print(
          '[RequestController] Driver last known location: (${driver.lastLocationLat}, ${driver.lastLocationLng})',
        );
      }
      
      // Try to get current client location for destination
      final position = await _locationService.getCurrentPosition();
      if (position != null && destinationLocation.value == null) {
        destinationLocation.value = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          address: 'Current Location',
          placeName: 'Your current location',
          city: null,
          country: 'Morocco',
        );
         print('[RequestController] Set destination to current location');
      }
    } catch (e) {
       print('[RequestController] Could not set location defaults: $e');
      // Don't fail silently - just log it
    }
  }

  /// Load active request(s) for current user
  /// For drivers: loads all active requests (supports batch deliveries)
  /// For clients: loads single active request
  Future<void> loadActiveRequest() async {
    if (_authController.currentUser.value == null) return;

    try {
      final user = _authController.currentUser.value!;
      final isDriver = user.roles.contains(UserRole.driver);

      print(
        '[RequestController] Loading active request(s) for user ${user.id} (isDriver: $isDriver)',
      );

      if (isDriver) {
        // Load ALL active requests for driver (supports multiple deliveries)
        final requests = await _requestService.getActiveRequestsForDriver(
          user.id!,
        );
        activeRequests.value = requests;
        activeRequest.value = requests.isNotEmpty ? requests.first : null;
        print(
          '[RequestController] Driver has ${requests.length} active request(s): ${requests.map((r) => r.id).toList()}',
        );
      } else {
        // Client can have multiple active orders
        final requests = await _requestService.getActiveRequestsForClient(
          user.id!,
        );
        activeRequests.value = requests;
        activeRequest.value = requests.isNotEmpty ? requests.first : null;
        print(
          '[RequestController] Client has ${requests.length} active order(s): ${requests.map((r) => r.id).toList()}',
        );
      }

      if (activeRequest.value != null) {
        print(
          '[RequestController] First request details: clientId=${activeRequest.value!.clientId}, driverId=${activeRequest.value!.driverId}',
        );
      }
    } catch (e) {
      print('[RequestController] Error loading active request: $e');
    }
  }

  /// Refresh the current active request (re-fetch from server)
  /// Useful for real-time updates when status changes
  Future<void> refreshCurrentRequest() async {
    try {
      if (activeRequest.value == null) {
        print('[RequestController] No active request to refresh');
        return;
      }

      final requestId = activeRequest.value!.id;
      if (requestId == null) return;

      print('[RequestController] 🔄 Refreshing request $requestId...');
      final updatedRequest = await _requestService.getRequestById(requestId);

      if (updatedRequest != null) {
        activeRequest.value = updatedRequest;
        
        // Also update in the activeRequests list
        final index = activeRequests.indexWhere((r) => r.id == requestId);
        if (index >= 0) {
          activeRequests[index] = updatedRequest;
        }

        print('[RequestController] ✅ Request refreshed: status=${updatedRequest.status}');
      }
    } catch (e) {
      print('[RequestController] Error refreshing request: $e');
    }
  }

  /// Load nearby requests for driver
  Future<void> loadNearbyRequests() async {
    if (_authController.currentUser.value == null) {
      print('[RequestController] No user logged in, cannot load requests');
      return;
    }

    print('[RequestController] 🔄 Loading nearby requests...');
    isLoading.value = true;

    try {
      final user = _authController.currentUser.value!;

      // Use saved location if available, otherwise fall back to GPS
      double driverLat;
      double driverLon;

      if (user.currentLatitude != null && user.currentLongitude != null) {
        // Use manually saved location from database
        driverLat = user.currentLatitude!;
        driverLon = user.currentLongitude!;
        print(
          '[RequestController] 📍 Using SAVED location: $driverLat, $driverLon',
        );
      } else {
        // Fall back to current GPS location
        final position = await _locationService.getCurrentPosition();
        if (position == null) {
          print(
            '[RequestController] ❌ Location permission denied or unavailable',
          );
          errorMessage.value = 'errors.location_permission_denied'.tr;
          isLoading.value = false;
          return;
        }
        driverLat = position.latitude;
        driverLon = position.longitude;
        print(
          '[RequestController] 📍 Using GPS location: $driverLat, $driverLon',
        );
      }

      // Get city name from coordinates
      try {
        final address = await _locationService.getAddressFromCoordinates(
          LatLng(driverLat, driverLon),
        );
        if (address != null) {
          // Extract city (second part after first comma)
          final parts = address.split(',');
          if (parts.length > 1) {
            driverCity.value = parts[1].trim();
          }
        }
      } catch (e) {
        print('[RequestController] Could not get city name: $e');
      }

      final requests = await _requestService.getNearbyRequests(
        driverId: user.id!,
        driverLat: driverLat,
        driverLon: driverLon,
        radiusKm: 50.0, // Increased radius for testing
      );

      print(
        '[RequestController] ✅ Found ${requests.length} nearby requests (within 50km)',
      );

      // Log each request for debugging
      for (var request in requests) {
        print(
          '[RequestController]   📦 Request #${request.id}: ${request.pickupLocation?.placeName ?? "Flexible location"} (${request.pickupLocation?.latitude ?? 0.0}, ${request.pickupLocation?.longitude ?? 0.0})',
        );
      }

      nearbyRequests.value = requests;
      isLoading.value = false;
    } catch (e) {
      print('[RequestController] ❌ Error loading nearby requests: $e');
      errorMessage.value = 'errors.failed_to_load_requests'.tr;
      isLoading.value = false;
    }
  }

  /// Accept a request (driver)
  /// Drivers can accept multiple requests (batch deliveries)
  Future<bool> acceptRequest(int requestId) async {
    if (_authController.currentUser.value == null) return false;

    print(
      '[RequestController] Driver ${_authController.currentUser.value!.id} accepting request $requestId',
    );

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = await _requestService.acceptRequest(
        requestId: requestId,
        driverId: _authController.currentUser.value!.id!,
      );

      if (request != null) {
        print(
          '[RequestController] ✅ Request $requestId accepted! New status: ${request.status}',
        );
        print(
          '[RequestController] Request clientId=${request.clientId}, driverId=${request.driverId}',
        );
        
        // ANALYTICS: Track request accepted (driver)
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            await analytics.trackRequestAccepted(
              requestId: requestId,
              driverId: _authController.currentUser.value!.id!,
              agreedPrice: request.agreedPrice,
            );
          }
        } catch (e) {
          print('[RequestController] ⚠️ Analytics tracking failed: $e');
        }

        // Add to active requests list (supports multiple)
        activeRequests.add(request);
        // Keep activeRequest pointing to the most recently accepted one
        activeRequest.value = request;

        nearbyRequests.removeWhere((r) => r.id == requestId);
        isLoading.value = false;
        return true;
      } else {
        print('[RequestController] ❌ Failed to accept request $requestId');
        errorMessage.value = 'errors.failed_to_accept_request'.tr;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print('[RequestController] ❌ Error accepting request: $e');
      if (e.toString().contains('maximum active requests')) {
        errorMessage.value = 'errors.max_active_requests_reached'.tr;
      } else if (e.toString().contains('no longer available')) {
        errorMessage.value = 'errors.request_no_longer_available'.tr;
        // Refresh nearby requests
        loadNearbyRequests();
      } else {
        errorMessage.value = 'errors.failed_to_accept_request'.tr;
      }
      isLoading.value = false;
      return false;
    }
  }

  /// Update request status
  Future<bool> updateStatus(RequestStatus newStatus) async {
    if (_authController.currentUser.value == null ||
        activeRequest.value == null) {
      return false;
    }

    final requestId = activeRequest.value!.id!;
    final oldStatus = activeRequest.value!.status;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = await _requestService.updateRequestStatus(
        requestId: requestId,
        newStatus: newStatus,
        userId: _authController.currentUser.value!.id!,
      );

      if (request != null) {
        activeRequest.value = request;

        // ANALYTICS: Track request status change
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            
            // Track completion specifically
            if (newStatus == RequestStatus.completed) {
              await analytics.trackRequestCompleted(
                requestId: requestId,
                serviceType: request.serviceType.name,
                finalPrice: request.agreedPrice ?? request.totalPrice,
                durationMinutes: request.createdAt != null
                    ? DateTime.now().difference(request.createdAt!).inMinutes
                    : null,
                driverId: request.driverId,
              );
            } else {
              // Track other status changes
              await analytics.trackEvent('request_status_changed', properties: {
                'request_id': requestId,
                'old_status': oldStatus?.name ?? 'unknown',
                'new_status': newStatus.name,
                'changed_by': _authController.isDriver ? 'driver' : 'client',
              });
            }
          }
        } catch (e) {
          print('[RequestController] ⚠️ Analytics tracking failed: $e');
        }

        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'errors.failed_to_update_status'.tr;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString().contains('Invalid status transition')
          ? 'errors.invalid_status_transition'.tr
          : 'errors.failed_to_update_status'.tr;
      isLoading.value = false;
      return false;
    }
  }

  /// Cancel active request
  Future<bool> cancelRequest(String reason) async {
    if (_authController.currentUser.value == null ||
        activeRequest.value == null) {
      return false;
    }
    
    final requestId = activeRequest.value!.id!;
    final requestCreatedAt = activeRequest.value!.createdAt;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = await _requestService.cancelRequest(
        requestId: requestId,
        userId: _authController.currentUser.value!.id!,
        reason: reason,
      );

      if (request != null) {
        // ANALYTICS: Track request cancelled
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            final minutesAfterCreation = requestCreatedAt != null
                ? DateTime.now().difference(requestCreatedAt).inMinutes
                : null;
            await analytics.trackRequestCancelled(
              requestId: requestId,
              reason: reason,
              cancelledBy: _authController.isDriver ? 'driver' : 'client',
              minutesAfterCreation: minutesAfterCreation,
            );
          }
        } catch (e) {
          print('[RequestController] ⚠️ Analytics tracking failed: $e');
        }
        
        activeRequest.value = null;
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'errors.failed_to_cancel_request'.tr;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = 'errors.failed_to_cancel_request'.tr;
      isLoading.value = false;
      return false;
    }
  }

  /// Load request history
  Future<void> loadRequestHistory() async {
    if (_authController.currentUser.value == null) return;

    isLoading.value = true;

    try {
      final user = _authController.currentUser.value!;
      final isDriver = user.roles.contains(UserRole.driver);

      if (isDriver) {
        requestHistory.value = await _requestService.getDriverRequestHistory(
          driverId: user.id!,
        );
      } else {
        requestHistory.value = await _requestService.getClientRequestHistory(
          clientId: user.id!,
        );
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = 'errors.failed_to_load_history'.tr;
      isLoading.value = false;
    }
  }

  /// Set pickup location
  void setPickupLocation(
    LatLng position, {
    String? address,
    String? placeName,
  }) {
    pickupLocation.value = Location(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
      placeName: placeName,
      city: null,
      country: 'Morocco',
    );
    calculateEstimate();
  }

  /// Set destination location
  void setDestinationLocation(
    LatLng position, {
    String? address,
    String? placeName,
  }) {
    destinationLocation.value = Location(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
      placeName: placeName,
      city: null,
      country: 'Morocco',
    );
    calculateEstimate();
  }

  /// Calculate price and distance estimate using backend price suggestion
  Future<void> calculateEstimate() async {
    if (pickupLocation.value == null || destinationLocation.value == null) {
      estimatedPrice.value = 0.0;
      estimatedDistance.value = 0.0;
      suggestedMinPrice.value = 0.0;
      suggestedMaxPrice.value = 0.0;
      suggestedRecommendedPrice.value = 0.0;
      return;
    }

    try {
      // Get price suggestion from backend
      final suggestion = await _requestService.getPriceSuggestion(
        pickupLat: pickupLocation.value!.latitude,
        pickupLon: pickupLocation.value!.longitude,
        destLat: destinationLocation.value!.latitude,
        destLon: destinationLocation.value!.longitude,
        serviceType: selectedServiceType.value,
      );

      if (suggestion != null) {
        estimatedDistance.value = suggestion['distance'] ?? 0.0;
        suggestedMinPrice.value = suggestion['minPrice'] ?? 0.0;
        suggestedMaxPrice.value = suggestion['maxPrice'] ?? 0.0;
        suggestedRecommendedPrice.value = suggestion['recommended'] ?? 0.0;
        estimatedPrice.value = suggestion['recommended'] ?? 0.0;

        print(
          '[RequestController] Price suggestion: ${suggestedMinPrice.value}-${suggestedMaxPrice.value} MAD (recommended: ${suggestedRecommendedPrice.value})',
        );
      }
    } catch (e) {
      print('[RequestController] Error getting price suggestion: $e');
      // Fallback to simple calculation
      _calculateEstimateSimple();
    }
  }

  /// Simple fallback price estimation (client-side)
  void _calculateEstimateSimple() {
    if (pickupLocation.value == null || destinationLocation.value == null) {
      return;
    }

    // Simple distance calculation (Haversine formula)
    final distance = _calculateDistance(
      pickupLocation.value!.latitude,
      pickupLocation.value!.longitude,
      destinationLocation.value!.latitude,
      destinationLocation.value!.longitude,
    );

    estimatedDistance.value = distance;

    // Simple price estimation
    double basePrice = 10.0;
    double perKm = 5.0;

    switch (selectedServiceType.value) {
      case ServiceType.ride:
        basePrice = 10.0;
        perKm = 5.0;
        break;
      case ServiceType.delivery:
        basePrice = 15.0;
        perKm = 3.0;
        break;
      case ServiceType.purchase:
        basePrice = 20.0;
        perKm = 4.0;
        break;
      case ServiceType.task:
        basePrice = 25.0;
        perKm = 4.0;
        break;
      case ServiceType.moving:
        basePrice = 50.0;
        perKm = 8.0;
        break;
      case ServiceType.other:
        basePrice = 20.0;
        perKm = 6.0;
        break;
    }

    final distancePrice = distance * perKm;
    final subtotal = basePrice + distancePrice;
    final serviceFee = subtotal * 0.10;
    var total = subtotal + serviceFee;

    if (total < 15.0) total = 15.0;

    estimatedPrice.value = double.parse(total.toStringAsFixed(2));
    suggestedRecommendedPrice.value = estimatedPrice.value;
    suggestedMinPrice.value = estimatedPrice.value * 0.8;
    suggestedMaxPrice.value = estimatedPrice.value * 1.3;
  }

  /// Load pending requests for client (waiting for driver offers)
  Future<void> loadPendingRequests() async {
    if (_authController.currentUser.value == null) return;

    try {
      final user = _authController.currentUser.value!;
      if (user.roles.contains(UserRole.driver)) return; // Only for clients

      // Get requests with status=pending for this client
      final requests = await _requestService.getClientPendingRequests(user.id!);
      pendingRequests.value = requests;

      print('[RequestController] Loaded ${requests.length} pending requests');
    } catch (e) {
      print('[RequestController] Error loading pending requests: $e');
    }
  }

  /// Accept driver's proposal (client)
  Future<bool> acceptProposal(int proposalId) async {
    if (_authController.currentUser.value == null) return false;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = await _requestService.acceptProposal(
        proposalId: proposalId,
        clientId: _authController.currentUser.value!.id!,
      );

      if (request != null) {
        activeRequest.value = request;
        pendingRequests.removeWhere((r) => r.id == request.id);
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'negotiation.failed_accept_proposal'.tr;
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  /// Reject driver's proposal (client)
  Future<bool> rejectProposal(int proposalId) async {
    if (_authController.currentUser.value == null) return false;

    try {
      final success = await _requestService.rejectProposal(
        proposalId: proposalId,
        clientId: _authController.currentUser.value!.id!,
      );

      if (success) {
        // Refresh pending requests to update UI
        loadPendingRequests();
      }

      return success;
    } catch (e) {
      print('[RequestController] Error rejecting proposal: $e');
      return false;
    }
  }

  /// Calculate distance using Haversine formula (simple approximation)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // km

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * 3.14159265359 / 180;
  }

  /// Reset form
  void resetForm() {
    selectedServiceType.value = ServiceType.ride;
    destinationLocation.value = null;
    notes.value = '';
    estimatedPrice.value = 0.0;
    estimatedDistance.value = 0.0;
    errorMessage.value = '';
    _initializeDefaultPickupLocation();
  }

  /// Clear error
  void clearError() {
    errorMessage.value = '';
  }
}
