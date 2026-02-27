import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/controllers/auth_controller.dart';
import '../../core/controllers/request_controller.dart';
import '../../core/controllers/wallet_controller.dart';
import '../../core/services/request_service.dart';
import '../../core/services/driver_location_service.dart';
import '../../core/services/directions_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_helper.dart';
import '../../shared/widgets/rating_dialog.dart';
import '../../shared/widgets/negotiation_timeline_widget.dart';
import '../../shared/widgets/status_timeline_widget.dart';
import '../../core/controllers/request_controller.dart';

/// Driver's active request screen with map and client info
class DriverActiveRequestScreen extends StatefulWidget {
  final ServiceRequest request;

  const DriverActiveRequestScreen({
    super.key,
    required this.request,
  });

  @override
  State<DriverActiveRequestScreen> createState() =>
      _DriverActiveRequestScreenState();
}

class _DriverActiveRequestScreenState extends State<DriverActiveRequestScreen> {
  final RequestService _requestService = Get.find<RequestService>();
  final DriverLocationService _locationService =
      Get.find<DriverLocationService>();
  final DirectionsService _directionsService = Get.find<DirectionsService>();
  final AuthController _authController = Get.find<AuthController>();
  final WalletController _walletController = Get.find<WalletController>();
  final RequestController _requestController = Get.find<RequestController>();

  GoogleMapController? _mapController;
  Worker? _requestListener;

  final Rx<ServiceRequest?> _currentRequest = Rx<ServiceRequest?>(null);
  final RxBool isUpdatingStatus = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DirectionsResult?> _directions = Rx<DirectionsResult?>(null);
  final RxBool showDetails = true.obs;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  StreamSubscription? _locationSubscription;
  LatLng? _lastDriverPosition;

  @override
  void initState() {
    super.initState();
    _currentRequest.value = widget.request;
    _initializeMap();
    // Refresh request to get latest status from server
    _refreshRequest();
    
    // Listen to RequestController for real-time updates
    _requestListener = ever(_requestController.activeRequest, (request) {
      if (request != null && request.id == widget.request.id) {
        _currentRequest.value = request;
        debugPrint(
          '[DriverActiveRequest] 🔄 Real-time update: status=${request.status}',
        );
      }
    });
  }

  /// Refresh the request from server to get latest status
  Future<void> _refreshRequest() async {
    try {
      final userId = _authController.currentUser.value?.id;
      if (userId == null) return;

      // Reload active requests to get fresh data
      final requests = await _requestService.getActiveRequestsForDriver(userId);
      final updatedRequest = requests.firstWhereOrNull(
        (r) => r.id == widget.request.id,
      );

      if (updatedRequest != null) {
        _currentRequest.value = updatedRequest;
        debugPrint(
          '[DriverActiveRequest] 🔄 Refreshed request ${updatedRequest.id}, status: ${updatedRequest.status}',
        );
      }
    } catch (e) {
      debugPrint('[DriverActiveRequest] ❌ Error refreshing request: $e');
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _requestListener?.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _initializeMap() {
    // Setup markers
    _addMarkers();

    // Listen to driver location updates
    _subscribeToDriverLocation();

    // Load directions
    _loadDirections();
  }

  void _addMarkers() {
    // Pickup marker
    if (_currentRequest.value?.pickupLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: LatLng(
            _currentRequest.value!.pickupLocation!.latitude,
            _currentRequest.value!.pickupLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: 'driver.active_request.pickup_location'.tr,
            snippet: _currentRequest.value!.pickupLocation!.address,
          ),
        ),
      );
    }

    // Destination marker
    if (_currentRequest.value?.destinationLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(
            _currentRequest.value!.destinationLocation!.latitude,
            _currentRequest.value!.destinationLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: 'driver.active_request.destination'.tr,
            snippet: _currentRequest.value!.destinationLocation!.address,
          ),
        ),
      );
    }
  }

  void _subscribeToDriverLocation() {
    final driverId = _authController.currentUser.value?.id;
    if (driverId == null) return;

    _locationSubscription = _locationService
        .watchDriverLocation(driverId)
        .listen((location) {
          if (location != null && mounted) {
            final newPosition = LatLng(location.latitude, location.longitude);

            setState(() {
              // Remove old driver marker
              _markers.removeWhere((m) => m.markerId.value == 'driver');

              // Add new driver marker with smooth animation
              _markers.add(
                Marker(
                  markerId: const MarkerId('driver'),
                  position: newPosition,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                  rotation: location.heading ?? 0,
                  anchor: const Offset(0.5, 0.5),
                  flat: true,
                ),
              );
            });

            // Animate camera to new position
            if (_lastDriverPosition != null) {
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(newPosition),
              );
            } else {
              // First position, show route
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(newPosition),
              );
            }

            _lastDriverPosition = newPosition;

            // Reload directions if driver moved significantly
            _loadDirections();
          }
        });
  }

  Future<void> _loadDirections() async {
    if (_lastDriverPosition == null || _currentRequest.value == null) return;

    LatLng? destination;

    // Determine destination based on status
    if (_currentRequest.value?.status == RequestStatus.accepted ||
        _currentRequest.value?.status == RequestStatus.driver_arriving) {
      // Route to pickup
      final pickupLoc = _currentRequest.value?.pickupLocation;
      if (pickupLoc == null) return;
      
      destination = LatLng(
        pickupLoc.latitude,
        pickupLoc.longitude,
      );
    } else {
      // Route to destination
      final destLoc = _currentRequest.value?.destinationLocation;
      if (destLoc == null) return;
      
      destination = LatLng(
        destLoc.latitude,
        destLoc.longitude,
      );
    }
    
    if (destination == null) return;

    final result = await _directionsService.getDirections(
      origin: _lastDriverPosition!,
      destination: destination,
    );

    if (result != null && mounted) {
      _directions.value = result;

      setState(() {
        _polylines.clear();
        _polylines.add(
          _directionsService.createPolyline(
            polylineId: 'route',
            points: result.polylinePoints,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    }
  }

  Future<void> _makePhoneCall() async {
    final phoneNumber = _currentRequest.value?.clientPhone;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar(
        'common.error'.tr,
        'call.no_phone_number'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final uri = Uri.parse('tel:$phoneNumber');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Get.snackbar(
          'common.error'.tr,
          'call.call_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'common.error'.tr,
        'call.call_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _openNavigation() async {
    try {
      final request = _currentRequest.value;
      if (request == null) {
        debugPrint('[Navigation] ❌ No request found');
        Get.snackbar(
          'navigation.error'.tr,
          'navigation.no_request'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      debugPrint('[Navigation] 📍 Request ID: ${request.id}, Status: ${request.status}');
      debugPrint('[Navigation] 📍 Pickup: ${request.pickupLocation?.latitude}, ${request.pickupLocation?.longitude}');
      debugPrint('[Navigation] 📍 Destination: ${request.destinationLocation?.latitude}, ${request.destinationLocation?.longitude}');

      // Determine destination based on request status
      double? destLat;
      double? destLng;
      String destinationType = '';
      String locationName = '';

      if (request.status == RequestStatus.accepted ||
          request.status == RequestStatus.driver_arriving) {
        // Driver hasn't picked up yet, navigate to pickup location
        destLat = request.pickupLocation?.latitude;
        destLng = request.pickupLocation?.longitude;
        destinationType = 'pickup';
        locationName = request.pickupLocation?.address ?? 'pickup location';
        debugPrint('[Navigation] 🎯 Navigating to PICKUP: $destLat, $destLng');
        
        // Fallback: if pickup is null but destination exists, use destination
        if ((destLat == null || destLng == null) && 
            request.destinationLocation?.latitude != null &&
            request.destinationLocation?.longitude != null) {
          destLat = request.destinationLocation!.latitude;
          destLng = request.destinationLocation!.longitude;
          destinationType = 'destination';
          locationName = request.destinationLocation!.address ?? 'destination';
          debugPrint('[Navigation] ⚠️ Pickup is null, using destination as fallback: $destLat, $destLng');
        }
      } else if (request.status == RequestStatus.in_progress) {
        // Driver has picked up, navigate to delivery location
        destLat = request.destinationLocation?.latitude;
        destLng = request.destinationLocation?.longitude;
        destinationType = 'delivery';
        locationName = request.destinationLocation?.address ?? 'delivery location';
        debugPrint('[Navigation] 🎯 Navigating to DELIVERY: $destLat, $destLng');
        
        // Fallback: if destination is null but pickup exists, use pickup
        if ((destLat == null || destLng == null) && 
            request.pickupLocation?.latitude != null &&
            request.pickupLocation?.longitude != null) {
          destLat = request.pickupLocation!.latitude;
          destLng = request.pickupLocation!.longitude;
          destinationType = 'pickup';
          locationName = request.pickupLocation!.address ?? 'pickup location';
          debugPrint('[Navigation] ⚠️ Destination is null, using pickup as fallback: $destLat, $destLng');
        }
      } else {
        Get.snackbar(
          'navigation.error'.tr,
          'navigation.invalid_status'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      if (destLat == null || destLng == null) {
        debugPrint('[Navigation] ❌ Location is NULL for $destinationType');
        debugPrint('[Navigation] ❌ Request data: pickup=${request.pickupLocation}, dest=${request.destinationLocation}');
        Get.snackbar(
          'navigation.error'.tr,
          'navigation.no_location'.tr + ' ($destinationType)',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      debugPrint('[Navigation] ✅ Launching navigation to: $locationName ($destLat, $destLng)');

      // Try Google Maps navigation with turn-by-turn directions
      // Use google.navigation scheme for Android, or fallback to maps URL
      final Uri googleMapsUri = Uri.parse(
          'google.navigation:q=$destLat,$destLng&mode=d');
      final Uri mapsUrlUri = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$destLat,$destLng&travelmode=driving');

      bool launched = false;

      // Try native Google Maps navigation first
      if (await canLaunchUrl(googleMapsUri)) {
        launched = await launchUrl(
          googleMapsUri,
          mode: LaunchMode.externalApplication,
        );
      }

      // Fallback to web URL if native app not available
      if (!launched && await canLaunchUrl(mapsUrlUri)) {
        launched = await launchUrl(
          mapsUrlUri,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        Get.snackbar(
          'navigation.error'.tr,
          'navigation.no_maps_app'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'navigation.success'.tr,
          destinationType == 'pickup'
              ? 'navigation.to_pickup'.tr
              : 'navigation.to_delivery'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'navigation.error'.tr,
        'navigation.failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Zoom in on the map
  void _zoomIn() {
    _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  /// Zoom out on the map
  void _zoomOut() {
    _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  /// Recenter map to show all relevant markers (pickup, destination, driver)
  Future<void> _recenterMap() async {
    if (_mapController == null) return;

    final request = _currentRequest.value;
    if (request == null) return;

    try {
      // Collect all positions to show
      final List<LatLng> positions = [];

      // Add pickup location
      if (request.pickupLocation != null) {
        positions.add(LatLng(
          request.pickupLocation!.latitude,
          request.pickupLocation!.longitude,
        ));
      }

      // Add destination location
      if (request.destinationLocation != null) {
        positions.add(LatLng(
          request.destinationLocation!.latitude,
          request.destinationLocation!.longitude,
        ));
      }

      // Add driver's current location
      if (_lastDriverPosition != null) {
        positions.add(_lastDriverPosition!);
      }

      // If we have positions, fit them in view
      if (positions.isNotEmpty) {
        // Calculate bounds
        double minLat = positions.first.latitude;
        double maxLat = positions.first.latitude;
        double minLng = positions.first.longitude;
        double maxLng = positions.first.longitude;

        for (final pos in positions) {
          if (pos.latitude < minLat) minLat = pos.latitude;
          if (pos.latitude > maxLat) maxLat = pos.latitude;
          if (pos.longitude < minLng) minLng = pos.longitude;
          if (pos.longitude > maxLng) maxLng = pos.longitude;
        }

        final bounds = LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        );

        await _mapController!.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 100), // 100px padding
        );
      }
    } catch (e) {
      debugPrint('[DriverActiveRequest] Error recentering map: $e');
    }
  }

  Future<void> _cancelRequest() async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('driver.active_request.cancel_title'.tr),
        content: Text('driver.active_request.cancel_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.no'.tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Get.back(result: true),
            child: Text('common.yes'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isUpdatingStatus.value = true;
    errorMessage.value = '';

    try {
      final userId = _authController.currentUser.value?.id;
      final requestId = _currentRequest.value?.id;
      if (userId == null || requestId == null) return;

      final result = await _requestService.cancelRequest(
        requestId: requestId,
        userId: userId,
        reason: 'Driver cancelled the request',
      );

      if (result != null) {
        Get.snackbar(
          'common.success'.tr,
          'driver.active_request.cancelled'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Go back to home
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      } else {
        errorMessage.value = 'errors.failed_to_cancel_request'.tr;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'common.error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdatingStatus.value = false;
    }
  }

  Future<void> _updateStatus(RequestStatus newStatus) async {
    String confirmMessage = '';

    switch (newStatus) {
      case RequestStatus.driver_arriving:
        confirmMessage = 'driver.active_request.arriving_confirmation'.tr;
        break;
      case RequestStatus.in_progress:
        confirmMessage = 'driver.active_request.start_confirmation'.tr;
        break;
      case RequestStatus.completed:
        confirmMessage = 'driver.active_request.complete_confirmation'.tr;
        break;
      default:
        return;
    }

    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('common.confirm'.tr),
        content: Text(confirmMessage),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text('common.confirm'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isUpdatingStatus.value = true;
    errorMessage.value = '';

    try {
      final userId = _authController.currentUser.value?.id;
      final requestId = _currentRequest.value?.id;
      if (userId == null || requestId == null) return;

      final updatedRequest = await _requestService.updateRequestStatus(
        requestId: requestId,
        newStatus: newStatus,
        userId: userId,
      );

      if (updatedRequest != null) {
        _currentRequest.value = updatedRequest;

        Get.snackbar(
          'common.success'.tr,
          'driver.active_request.status_updated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Don't auto-close when completed - driver needs to confirm payment
        // if (newStatus == RequestStatus.completed) {
        //   await Future.delayed(const Duration(seconds: 2));
        //   Get.back();
        // }
      } else {
        errorMessage.value = 'errors.failed_to_update_status'.tr;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'common.error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdatingStatus.value = false;
    }
  }

  Widget _buildStatusButton() {
    final status = _currentRequest.value?.status;
    if (status == null) return const SizedBox.shrink();

    // If completed and not paid, show confirm payment button
    if (status == RequestStatus.completed &&
        _currentRequest.value?.isPaid == false) {
      return _buildConfirmPaymentButton();
    }

    // If driver_proposed, show waiting for client approval UI
    if (status == RequestStatus.driver_proposed) {
      return _buildWaitingForClientButton();
    }

    String buttonText = '';
    RequestStatus? nextStatus;
    Color buttonColor = Colors.blue;
    IconData buttonIcon = Iconsax.tick_circle;

    switch (status) {
      case RequestStatus.accepted:
        buttonText = 'driver.active_request.im_arriving'.tr;
        nextStatus = RequestStatus.driver_arriving;
        buttonColor = Colors.orange;
        buttonIcon = Iconsax.routing;
        break;
      case RequestStatus.driver_arriving:
        buttonText = 'driver.active_request.start_service'.tr;
        nextStatus = RequestStatus.in_progress;
        buttonColor = Colors.green;
        buttonIcon = Iconsax.play_circle;
        break;
      case RequestStatus.in_progress:
        buttonText = 'driver.active_request.complete_service'.tr;
        nextStatus = RequestStatus.completed;
        buttonColor = Colors.blue;
        buttonIcon = Iconsax.tick_circle;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton.icon(
          onPressed: isUpdatingStatus.value
              ? null
              : () => _updateStatus(nextStatus!),
          icon: isUpdatingStatus.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(buttonIcon),
          label: Text(
            buttonText,
            style: AppTypography.titleMedium(
              context,
            ).copyWith(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPaymentButton() {
    final request = _currentRequest.value;
    if (request == null) return const SizedBox.shrink();

    // Use agreedPrice if available (after proposal), otherwise use totalPrice (initial estimate)
    final agreedPrice = request.agreedPrice ?? request.totalPrice;
    final commissionRate = _walletController.commissionRate.value;
    final commission = agreedPrice * commissionRate;
    final driverEarnings = agreedPrice - commission;

    return Column(
      children: [
        // Payment info card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark.success.withValues(alpha: 0.1)
                : AppColors.light.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark.success.withValues(alpha: 0.3)
                  : AppColors.light.success.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: AppTypography.bodyMedium(context),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(agreedPrice, _currentRequest.value!.currencySymbol),
                    style: AppTypography.titleMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Platform Commission (${(commissionRate * 100).toStringAsFixed(0)}%):',
                    style: AppTypography.bodySmall(context),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(commission, _currentRequest.value!.currencySymbol),
                    style: AppTypography.bodySmall(context),
                  ),
                ],
              ),
              Divider(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Earnings:',
                    style: AppTypography.titleMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.dark.success
                          : AppColors.light.success,
                    ),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(driverEarnings, _currentRequest.value!.currencySymbol),
                    style: AppTypography.titleLarge(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.dark.success
                          : AppColors.light.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Confirm button
        Obx(
          () => SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              onPressed: _walletController.isLoading.value
                  ? null
                  : () => _confirmCashPayment(),
              icon: _walletController.isLoading.value
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Iconsax.wallet_money),
              label: Text(
                'Confirm Cash Received',
                style: AppTypography.titleMedium(
                  context,
                ).copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.dark.success
                    : AppColors.light.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build waiting for client approval button (when status is driver_proposed)
  Widget _buildWaitingForClientButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'driver.active_request.waiting_client_accept'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.active_request.waiting_client_message'.tr,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          // Refresh button
          OutlinedButton.icon(
            onPressed: isUpdatingStatus.value ? null : _refreshRequest,
            icon: isUpdatingStatus.value
                ? SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                    ),
                  )
                : Icon(Iconsax.refresh, size: 18.sp),
            label: Text('common.refresh'.tr),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmCashPayment() async {
    final request = _currentRequest.value;
    if (request == null || request.id == null) return;

    final userId = _authController.currentUser.value?.id;
    if (userId == null) return;

    // Show confirmation dialog
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirm Cash Payment'),
        content: const Text(
          'Have you received the cash payment from the client? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await _walletController.confirmCashPayment(
      requestId: request.id!,
      driverId: userId,
      notes: 'Cash payment received for service request #${request.id}',
    );

    if (success) {
      // Refresh request to get updated payment status
      await _refreshRequest();

      // Show rating dialog to rate the client
      if (mounted) {
        await RatingDialog.show(
          context: context,
          userId: userId,
          requestId: request.id!,
          ratedUserId: request.clientId,
          ratedUserName: request.clientName ?? 'Client',
          ratingType: RatingType.driver_to_client,
        );
      }

      // Navigate back to driver home
      Get.offAllNamed('/home', arguments: {'initialRole': UserRole.driver});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                _currentRequest.value?.pickupLocation?.latitude ?? 33.5731, // Default to Casablanca, Morocco
                _currentRequest.value?.pickupLocation?.longitude ?? -7.5898,
              ),
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) async {
              _mapController = controller;
              // Recenter map after creation to show all markers
              await Future.delayed(const Duration(milliseconds: 500));
              _recenterMap();
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Top bar with back button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8.h,
                left: 16.w,
                right: 16.w,
                bottom: 16.h,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.background,
                    colors.background.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Obx(
                      () => Text(
                        _getStatusText(
                          _currentRequest.value?.status ??
                              RequestStatus.pending,
                        ),
                        style: AppTypography.titleLarge(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Map Control Buttons (Zoom & Location)
          Positioned(
            right: 16.w,
            bottom: MediaQuery.of(context).size.height * 0.42 + 24.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location/Recenter Button
                Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Iconsax.location, color: colors.primary, size: 24.sp),
                    onPressed: _recenterMap,
                    tooltip: 'Recenter map',
                  ),
                ),
                SizedBox(height: 12.h),
                // Zoom In Button
                Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Iconsax.add, color: colors.textPrimary, size: 20.sp),
                    onPressed: _zoomIn,
                    tooltip: 'Zoom in',
                  ),
                ),
                SizedBox(height: 8.h),
                // Zoom Out Button
                Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Iconsax.minus, color: colors.textPrimary, size: 20.sp),
                    onPressed: _zoomOut,
                    tooltip: 'Zoom out',
                  ),
                ),
              ],
            ),
          ),

          // Modern Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.42,
            minChildSize: 0.12,
            maxChildSize: 0.92,
            snap: true,
            snapSizes: const [0.12, 0.42, 0.92],
            builder: (context, scrollController) {
              final request = _currentRequest.value;
              return Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag Handle
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 6.h),
                      width: 36.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: colors.textSecondary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    // Main Content
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          // Header: Client + Quick Actions
                          Row(
                            children: [
                              // Avatar with status indicator
                              Stack(
                                children: [
                                  FutureBuilder<String?>(
                                    future: _getClientAvatarUrl(request?.clientId),
                                    builder: (context, snapshot) {
                                      final avatarUrl = snapshot.data;
                                      
                                      if (avatarUrl != null && avatarUrl.isNotEmpty) {
                                        return CircleAvatar(
                                          radius: 22.r,
                                          backgroundColor: colors.primary.withValues(alpha: 0.1),
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: avatarUrl,
                                              width: 44.w,
                                              height: 44.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Container(
                                                color: colors.primary.withValues(alpha: 0.1),
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation(colors.primary),
                                                  ),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) => Icon(
                                                Iconsax.user,
                                                size: 18.sp,
                                                color: colors.primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      
                                      return CircleAvatar(
                                        radius: 22.r,
                                        backgroundColor: colors.primary.withValues(alpha: 0.1),
                                        child: Icon(Iconsax.user, size: 18.sp, color: colors.primary),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 12.w,
                                      height: 12.w,
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(request?.status, colors),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: colors.surface, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              // Client Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      request?.clientName ?? 'Client',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: colors.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: colors.primary.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(4.r),
                                          ),
                                          child: Text(
                                            _getServiceTypeText(request?.serviceType),
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w600,
                                              color: colors.primary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        if (request?.distance != null)
                                          Text(
                                            '${request!.distance!.toStringAsFixed(1)} km',
                                            style: TextStyle(fontSize: 10.sp, color: colors.textSecondary),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Quick Actions (icon only)
                              _buildIconButton(Iconsax.message, colors.primary, () {
                                if (request != null) {
                                  Get.toNamed('/chat/${request.id}', arguments: request);
                                }
                              }),
                              SizedBox(width: 6.w),
                              _buildIconButton(Iconsax.call, colors.success, _makePhoneCall),
                              SizedBox(width: 6.w),
                              _buildIconButton(Iconsax.routing, colors.info, _openNavigation),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Status Timeline (always visible, compact)
                          _buildModernTimeline(request, colors),

                          SizedBox(height: 10.h),

                          // ETA Card (if directions available)
                          Obx(() {
                            if (_directions.value == null) return const SizedBox.shrink();
                            return Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colors.primary.withValues(alpha: 0.08),
                                    colors.primary.withValues(alpha: 0.03),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: colors.primary.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(Iconsax.timer_1, color: colors.primary, size: 16.sp),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _directions.value!.durationText,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: colors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          '${_directions.value!.distanceText} away',
                                          style: TextStyle(fontSize: 10.sp, color: colors.textSecondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(request?.status, colors).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      _getShortStatusText(request?.status),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(request?.status, colors),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          SizedBox(height: 10.h),

                          // Service Details Card
                          if (request?.itemDescription != null || request?.specialInstructions != null)
                            _buildServiceDetailsCard(request!, colors),

                          // Locations Card
                          _buildLocationsCard(request, colors),

                          SizedBox(height: 10.h),

                          // Price Summary
                          if (request != null)
                            _buildPriceSummaryCard(request, colors),

                          SizedBox(height: 12.h),

                          // Main Action Button
                          Obx(() => _buildStatusButton()),

                          // Cancel option
                          if (request?.status != RequestStatus.completed)
                            Padding(
                              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                              child: TextButton.icon(
                                onPressed: _cancelRequest,
                                icon: Icon(Iconsax.close_circle, size: 16.sp, color: colors.error),
                                label: Text(
                                  'Cancel Request',
                                  style: TextStyle(fontSize: 12.sp, color: colors.error),
                                ),
                              ),
                            ),

                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetails(AppColorScheme colors) {
    final request = _currentRequest.value;
    if (request == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.warning.withValues(alpha: 0.15),
            colors.warning.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colors.warning.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  request.serviceType == ServiceType.purchase
                      ? Iconsax.bag_2
                      : Iconsax.clipboard_text,
                  color: colors.warning,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  request.serviceType == ServiceType.purchase
                      ? 'driver.purchase_required'.tr
                      : 'driver.task_required'.tr,
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (request.itemDescription != null &&
              request.itemDescription!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What client needs:',
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.textSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    request.itemDescription!,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (request.estimatedPurchaseCost != null &&
              request.estimatedPurchaseCost! > 0) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'driver.estimated_cost'.tr,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(request.estimatedPurchaseCost!, request.currencySymbol),
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: colors.info.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(Iconsax.info_circle, color: colors.info, size: 16.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'driver.purchase_notice'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    AppColorScheme colors,
    String label,
    String address,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: iconColor,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                address,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusText(RequestStatus status) {
    switch (status) {
      case RequestStatus.accepted:
        return 'driver.active_request.status_accepted'.tr;
      case RequestStatus.driver_arriving:
        return 'driver.active_request.status_arriving'.tr;
      case RequestStatus.in_progress:
        return 'driver.active_request.status_in_progress'.tr;
      case RequestStatus.completed:
        return 'driver.active_request.status_completed'.tr;
      default:
        return 'driver.active_request.title'.tr;
    }
  }

  String _getServiceTypeText(ServiceType? serviceType) {
    if (serviceType == null) return 'Service';
    switch (serviceType) {
      case ServiceType.delivery:
        return 'Delivery';
      case ServiceType.purchase:
        return 'Purchase';
      case ServiceType.task:
        return 'Task';
      case ServiceType.ride:
        return 'Ride';
      default:
        return 'Service';
    }
  }

  Color _getStatusColor(RequestStatus? status, AppColorScheme colors) {
    switch (status) {
      case RequestStatus.accepted:
        return colors.warning;
      case RequestStatus.driver_arriving:
        return Colors.orange;
      case RequestStatus.in_progress:
        return colors.info;
      case RequestStatus.completed:
        return colors.success;
      default:
        return colors.textSecondary;
    }
  }

  String _getShortStatusText(RequestStatus? status) {
    switch (status) {
      case RequestStatus.accepted:
        return 'Accepted';
      case RequestStatus.driver_arriving:
        return 'On the way';
      case RequestStatus.in_progress:
        return 'In Progress';
      case RequestStatus.completed:
        return 'Completed';
      default:
        return 'Pending';
    }
  }

  Future<String?> _getClientAvatarUrl(int? clientId) async {
    if (clientId == null) return null;
    
    try {
      final client = Get.find<Client>();
      final response = await client.user.getUserById(userId: clientId);
      return response.user?.profilePhotoUrl;
    } catch (e) {
      debugPrint('[DriverActiveRequest] Error fetching client avatar: $e');
      return null;
    }
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 18.sp),
        ),
      ),
    );
  }

  Widget _buildModernTimeline(ServiceRequest? request, AppColorScheme colors) {
    if (request == null) return const SizedBox.shrink();
    
    final steps = [
      ('Accepted', RequestStatus.accepted, Iconsax.tick_circle),
      ('Arriving', RequestStatus.driver_arriving, Iconsax.car),
      ('In Progress', RequestStatus.in_progress, Iconsax.activity),
      ('Done', RequestStatus.completed, Iconsax.medal_star),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Connector line
            final stepIndex = index ~/ 2;
            final isCompleted = _isStatusCompleted(request.status, steps[stepIndex + 1].$2);
            final isActive = request.status == steps[stepIndex].$2;
            return Expanded(
              child: Container(
                height: 2.h,
                color: isCompleted || isActive
                    ? colors.primary
                    : colors.textSecondary.withValues(alpha: 0.2),
              ),
            );
          }
          // Step circle
          final stepIndex = index ~/ 2;
          final (label, status, icon) = steps[stepIndex];
          final isCompleted = _isStatusCompleted(request.status, status);
          final isActive = request.status == status;
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? colors.success
                      : isActive
                          ? colors.primary
                          : colors.textSecondary.withValues(alpha: 0.15),
                  border: isActive
                      ? Border.all(color: colors.primary.withValues(alpha: 0.3), width: 3)
                      : null,
                ),
                child: Icon(
                  isCompleted ? Iconsax.tick_circle : icon,
                  size: 14.sp,
                  color: isCompleted || isActive ? Colors.white : colors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? colors.primary : colors.textSecondary,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildServiceDetailsCard(ServiceRequest request, AppColorScheme colors) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.warning.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                request.serviceType == ServiceType.purchase
                    ? Iconsax.bag_2
                    : request.serviceType == ServiceType.task
                        ? Iconsax.clipboard_text
                        : Iconsax.box,
                size: 16.sp,
                color: colors.warning,
              ),
              SizedBox(width: 8.w),
              Text(
                'Service Details',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          if (request.itemDescription != null && request.itemDescription!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              request.itemDescription!,
              style: TextStyle(fontSize: 11.sp, color: colors.textSecondary, height: 1.4),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (request.specialInstructions != null && request.specialInstructions!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.info_circle, size: 12.sp, color: colors.info),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    request.specialInstructions!,
                    style: TextStyle(fontSize: 10.sp, color: colors.info, fontStyle: FontStyle.italic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (request.estimatedPurchaseCost != null && request.estimatedPurchaseCost! > 0) ...[
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Est. Purchase Cost', style: TextStyle(fontSize: 10.sp, color: colors.textSecondary)),
                Text(
                  CurrencyHelper.formatWithSymbol(request.estimatedPurchaseCost!, request.currencySymbol),
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, color: colors.warning),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationsCard(ServiceRequest? request, AppColorScheme colors) {
    if (request == null) return const SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Pickup
          if (request.pickupLocation != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.location, size: 12.sp, color: colors.success),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup',
                        style: TextStyle(fontSize: 9.sp, color: colors.textSecondary, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        request.pickupLocation!.address ?? 'Pickup location',
                        style: TextStyle(fontSize: 11.sp, color: colors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          // Connector line
          if (request.pickupLocation != null && request.destinationLocation != null)
            Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: Row(
                children: [
                  Container(width: 2.w, height: 16.h, color: colors.textSecondary.withValues(alpha: 0.2)),
                ],
              ),
            ),
          // Destination
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.location_tick, size: 12.sp, color: colors.error),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination',
                      style: TextStyle(fontSize: 9.sp, color: colors.textSecondary, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      request.destinationLocation.address ?? 'Destination',
                      style: TextStyle(fontSize: 11.sp, color: colors.textPrimary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummaryCard(ServiceRequest request, AppColorScheme colors) {
    final agreedPrice = request.agreedPrice ?? request.totalPrice;
    
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.success.withValues(alpha: 0.08),
            colors.success.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.success.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Iconsax.wallet_money, size: 16.sp, color: colors.success),
                  SizedBox(width: 6.w),
                  Text(
                    'Your Earnings',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: colors.textPrimary),
                  ),
                ],
              ),
              Text(
                CurrencyHelper.formatWithSymbol(agreedPrice, request.currencySymbol),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, color: colors.success),
              ),
            ],
          ),
          if (request.distance != null || request.estimatedDuration != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                if (request.distance != null) ...[
                  Icon(Iconsax.routing_2, size: 12.sp, color: colors.textSecondary),
                  SizedBox(width: 4.w),
                  Text(
                    '${request.distance!.toStringAsFixed(1)} km',
                    style: TextStyle(fontSize: 10.sp, color: colors.textSecondary),
                  ),
                  SizedBox(width: 12.w),
                ],
                if (request.estimatedDuration != null) ...[
                  Icon(Iconsax.clock, size: 12.sp, color: colors.textSecondary),
                  SizedBox(width: 4.w),
                  Text(
                    '~${request.estimatedDuration} min',
                    style: TextStyle(fontSize: 10.sp, color: colors.textSecondary),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Build compact action button widget (icon only)
  Widget _buildCompactActionButton({
    required AppColorScheme colors,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 0.8,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 16.sp),
                SizedBox(height: 2.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build horizontal timeline widget (scrollable to handle overflow)
  Widget _buildHorizontalTimeline({
    required ServiceRequest request,
    required AppColorScheme colors,
  }) {
    final statuses = [
      RequestStatus.driver_proposed,
      RequestStatus.accepted,
      RequestStatus.driver_arriving,
      RequestStatus.in_progress,
      RequestStatus.completed,
    ];

    final statusLabels = {
      RequestStatus.driver_proposed: 'driver.active_request.timeline_proposed'.tr,
      RequestStatus.accepted: 'driver.active_request.timeline_accepted'.tr,
      RequestStatus.driver_arriving: 'driver.active_request.timeline_arriving'.tr,
      RequestStatus.in_progress: 'driver.active_request.timeline_progress'.tr,
      RequestStatus.completed: 'driver.active_request.timeline_done'.tr,
    };

    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(statuses.length, (index) {
            final status = statuses[index];
            final isCompleted = _isStatusCompleted(request.status, status);
            final isActive = request.status == status;

            return Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive || isCompleted
                            ? colors.primary
                            : colors.textSecondary.withValues(alpha: 0.2),
                      ),
                      child: isCompleted || isActive
                          ? Icon(
                              isCompleted ? Iconsax.tick_circle : Iconsax.clock,
                              color: Colors.white,
                              size: 10.sp,
                            )
                          : null,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      statusLabels[status] ?? '',
                      style: TextStyle(
                        fontSize: 7.sp,
                        color: isActive || isCompleted
                            ? colors.primary
                            : colors.textSecondary,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (index < statuses.length - 1) ...[
                  SizedBox(width: 4.w),
                  Container(
                    width: 10.w,
                    height: 1.5.h,
                    color: isCompleted
                        ? colors.primary
                        : colors.textSecondary.withValues(alpha: 0.2),
                  ),
                  SizedBox(width: 4.w),
                ] else
                  SizedBox(width: 4.w),
              ],
            );
          }),
        ),
      ),
    );
  }

  bool _isStatusCompleted(RequestStatus current, RequestStatus target) {
    final order = [
      RequestStatus.driver_proposed,
      RequestStatus.accepted,
      RequestStatus.driver_arriving,
      RequestStatus.in_progress,
      RequestStatus.completed,
    ];
    return order.indexOf(current) > order.indexOf(target);
  }

  /// Build action button widget
  Widget _buildActionButton({
    required AppColorScheme colors,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: color.withValues(alpha: 0.2),
              width: 0.8,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18.sp),
              SizedBox(height: 2.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9.sp,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build earnings breakdown card showing negotiation outcome and final earnings
  Widget _buildEarningsBreakdown(AppColorScheme colors) {
    final request = _currentRequest.value!;
    final controller = Get.find<RequestController>();
    final didNegotiate = controller.didNegotiate(request);
    final finalEarnings = controller.getFinalEarnings(request);

    if (request.agreedPrice == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.success.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.wallet_money, color: colors.success, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Your Earnings',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // If negotiated, show comparison
          if (didNegotiate &&
              request.clientOfferedPrice != null &&
              request.driverCounterPrice != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'timeline.client_offered'.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(request.clientOfferedPrice!, request.currencySymbol),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colors.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'timeline.you_counter_offered'.tr,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(request.driverCounterPrice!, request.currencySymbol),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: colors.border),
            SizedBox(height: 12.h),
          ],

          // Final earnings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'timeline.service_price'.tr,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              Text(
                CurrencyHelper.formatWithSymbol(request.agreedPrice!, request.currencySymbol),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'timeline.platform_fee'.tr,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              Text(
                '-${CurrencyHelper.formatWithSymbol(request.agreedPrice! * 0.05, request.currencySymbol)}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colors.error,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.success.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'timeline.final_earnings'.tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(finalEarnings, request.currencySymbol),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
