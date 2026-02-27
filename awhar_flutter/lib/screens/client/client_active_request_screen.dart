import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/controllers/auth_controller.dart';
import '../../core/controllers/wallet_controller.dart';
import '../../core/services/request_service.dart';
import '../../core/services/driver_location_service.dart';
import '../../core/services/directions_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_helper.dart';
import '../../shared/widgets/negotiation_timeline_widget.dart' as negotiation;
import '../../shared/widgets/rating_dialog.dart';
import '../../shared/widgets/status_timeline_widget.dart';
import '../../core/controllers/request_controller.dart';
import '../report_screen.dart';

/// Client's active request screen with live driver tracking
class ClientActiveRequestScreen extends StatefulWidget {
  final ServiceRequest request;

  const ClientActiveRequestScreen({
    super.key,
    required this.request,
  });

  @override
  State<ClientActiveRequestScreen> createState() =>
      _ClientActiveRequestScreenState();
}

class _ClientActiveRequestScreenState extends State<ClientActiveRequestScreen> {
  final RequestService _requestService = Get.find<RequestService>();
  final DriverLocationService _locationService =
      Get.find<DriverLocationService>();
  final DirectionsService _directionsService = Get.find<DirectionsService>();

  GoogleMapController? _mapController;

  final Rx<ServiceRequest?> _currentRequest = Rx<ServiceRequest?>(null);
  final Rx<DriverLocation?> _driverLocation = Rx<DriverLocation?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DirectionsResult?> _directions = Rx<DirectionsResult?>(null);
  final RxBool showTimeline = false.obs;
  final RxBool showOrderDetails = false.obs;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  StreamSubscription? _locationSubscription;
  Timer? _refreshTimer;
  LatLng? _lastDriverPosition;

  @override
  void initState() {
    super.initState();
    _currentRequest.value = widget.request;
    _initializeMap();
    _startPeriodicRefresh();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _refreshTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  void _initializeMap() {
    // Setup markers
    _addMarkers();

    // Listen to driver location updates
    if (_currentRequest.value?.driverId != null) {
      _subscribeToDriverLocation();
    }
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
            title: 'client.active_request.pickup_location'.tr,
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
            title: 'client.active_request.destination'.tr,
            snippet: _currentRequest.value!.destinationLocation!.address,
          ),
        ),
      );
    }
  }

  void _subscribeToDriverLocation() {
    final driverId = _currentRequest.value?.driverId;
    if (driverId == null) return;

    _locationSubscription = _locationService
        .watchDriverLocation(driverId)
        .listen((location) {
          if (location != null && mounted) {
            _driverLocation.value = location;

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
                  infoWindow: InfoWindow(
                    title: 'client.active_request.driver_info'.tr,
                    snippet: location.isMoving
                        ? 'client.active_request.driver_on_the_way'.tr
                        : 'client.active_request.driver_arrived'.tr,
                  ),
                ),
              );
            });

            // Load/update directions
            if (_lastDriverPosition == null ||
                _shouldUpdateDirections(newPosition)) {
              _loadDirections();
            }

            _lastDriverPosition = newPosition;

            // Auto-adjust camera
            _fitBounds();
          }
        });
  }

  bool _shouldUpdateDirections(LatLng newPosition) {
    if (_lastDriverPosition == null) return true;

    // Update if driver moved more than 100 meters
    final distance = _calculateDistance(
      _lastDriverPosition!.latitude,
      _lastDriverPosition!.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );

    return distance > 0.1; // 100 meters
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const p = 0.017453292519943295;
    final a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _loadDirections() async {
    if (_lastDriverPosition == null) return;

    LatLng? destination;

    // Determine destination based on status
    if (_currentRequest.value?.status == RequestStatus.accepted ||
        _currentRequest.value?.status == RequestStatus.driver_arriving) {
      // Route to pickup
      final pickup = _currentRequest.value?.pickupLocation;
      if (pickup != null) {
        destination = LatLng(pickup.latitude, pickup.longitude);
      }
    } else {
      // Route to destination
      final dest = _currentRequest.value?.destinationLocation;
      if (dest != null) {
        destination = LatLng(dest.latitude, dest.longitude);
      }
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
    final phoneNumber = _currentRequest.value?.driverPhone;
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

  void _fitBounds() {
    if (_mapController == null) return;

    final driverLoc = _driverLocation.value;
    if (driverLoc == null) return;

    LatLngBounds bounds;
    final driverLatLng = LatLng(driverLoc.latitude, driverLoc.longitude);

    // Determine target based on status
    LatLng? targetLatLng;
    if (_currentRequest.value?.status == RequestStatus.accepted ||
        _currentRequest.value?.status == RequestStatus.driver_arriving) {
      // Show driver to pickup
      final pickup = _currentRequest.value?.pickupLocation;
      if (pickup != null) {
        targetLatLng = LatLng(pickup.latitude, pickup.longitude);
      }
    } else {
      // Show driver to destination
      final dest = _currentRequest.value?.destinationLocation;
      if (dest != null) {
        targetLatLng = LatLng(dest.latitude, dest.longitude);
      }
    }

    // If no target location, just center on driver
    if (targetLatLng == null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(driverLatLng, 15),
      );
      return;
    }

    if (driverLatLng.latitude > targetLatLng.latitude) {
      bounds = LatLngBounds(
        southwest: targetLatLng,
        northeast: driverLatLng,
      );
    } else {
      bounds = LatLngBounds(
        southwest: driverLatLng,
        northeast: targetLatLng,
      );
    }

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }

  void _startPeriodicRefresh() {
    // Refresh request status every 10 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await _refreshRequest();
    });
  }

  Future<void> _refreshRequest() async {
    try {
      final requestId = _currentRequest.value?.id;
      if (requestId == null) return;

      final updatedRequest = await _requestService.getRequestById(
        requestId,
      );

      if (updatedRequest != null && mounted) {
        _currentRequest.value = updatedRequest;

        // If completed, show completion and go back
        if (updatedRequest.status == RequestStatus.completed) {
          _showCompletionDialog();
        }
      }
    } catch (e) {
      print('[ClientActiveRequestScreen] Error refreshing request: $e');
    }
  }

  void _showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('client.active_request.service_completed'.tr),
        content: Text('client.active_request.rate_service'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to home
            },
            child: Text('common.ok'.tr),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _confirmPayment() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm Cash Payment'),
        content: Text('Did you pay the agreed amount in cash to the driver?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.no'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('common.yes'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isLoading.value = true;

    try {
      final requestId = _currentRequest.value?.id;
      final clientId = Get.find<AuthController>().currentUser.value?.id;

      if (requestId == null || clientId == null) return;

      final walletController = Get.find<WalletController>();
      final success = await walletController.confirmCashPaymentByClient(
        requestId: requestId,
        clientId: clientId,
        notes: 'Cash payment confirmed by client',
      );

      if (success) {
        Get.snackbar(
          'common.success'.tr,
          'Payment confirmed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Show rating dialog to rate the driver
        final request = _currentRequest.value;
        if (mounted && request != null && request.driverId != null) {
          await RatingDialog.show(
            context: context,
            userId: clientId,
            requestId: requestId,
            ratedUserId: request.driverId!,
            ratedUserName: request.driverName ?? 'Driver',
            ratingType: RatingType.client_to_driver,
          );
        }

        // Navigate back to client home
        Get.offAllNamed('/home', arguments: {'initialRole': UserRole.client});
      }
    } catch (e) {
      errorMessage.value = 'Failed to confirm payment: $e';
      Get.snackbar(
        'common.error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _cancelRequest() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('common.warning'.tr),
        content: Text('client.active_request.cancel_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.no'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('common.yes'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isLoading.value = true;

    try {
      final requestId = _currentRequest.value?.id;
      if (requestId == null) return;

      final result = await _requestService.cancelRequest(
        requestId: requestId,
        userId: Get.find<AuthController>().currentUser.value!.id!,
        reason: 'Cancelled by client',
      );

      if (result != null) {
        Get.snackbar(
          'common.success'.tr,
          'Request cancelled successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );

        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      } else {
        errorMessage.value = 'errors.failed_to_cancel_request'.tr;
        Get.snackbar(
          'common.error'.tr,
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
      isLoading.value = false;
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
                _currentRequest.value?.pickupLocation?.latitude ?? 0,
                _currentRequest.value?.pickupLocation?.longitude ?? 0,
              ),
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              _mapController = controller;
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
                        style: AppTypography.titleLarge(
                          context,
                        ).copyWith(color: colors.textPrimary),
                      ),
                    ),
                  ),
                  // Report button
                  Obx(() {
                    final driverId = _currentRequest.value?.driverId;
                    if (driverId == null) return const SizedBox.shrink();
                    return Container(
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
                        icon: Icon(Iconsax.flag, color: colors.textSecondary, size: 20.sp),
                        onPressed: () {
                          Get.to(() => ReportScreen(
                            driverId: driverId,
                            orderId: _currentRequest.value?.id,
                          ));
                        },
                        tooltip: 'report.report_issue'.tr,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Driver info card at bottom - DraggableScrollableSheet
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            snap: true,
            snapSizes: const [0.2, 0.4, 0.9],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag handle
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: colors.textSecondary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    // Scrollable content
                    Expanded(
                      child: Obx(() {
                        // Check if driver proposed - show approve/reject UI
                        if (_currentRequest.value?.status == RequestStatus.driver_proposed) {
                          return _buildDriverProposedContent(colors, scrollController);
                        }
                        
                        // Normal tracking UI
                        return ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        children: [
                          // Driver info header
                          Row(
                            children: [
                              // Driver profile photo
                              CircleAvatar(
                                radius: 32.r,
                                backgroundColor: colors.primary.withValues(
                                  alpha: 0.1,
                                ),
                                child: Icon(
                                  Iconsax.user,
                                  size: 32.sp,
                                  color: colors.primary,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Text(
                                        _currentRequest.value?.driverName ??
                                            'Driver',
                                        style:
                                            AppTypography.titleLarge(
                                              context,
                                            ).copyWith(
                                              color: colors.textPrimary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    // Driver phone number
                                    if (_currentRequest.value?.driverPhone !=
                                        null)
                                      Obx(
                                        () => Row(
                                          children: [
                                            Icon(
                                              Iconsax.call,
                                              size: 12.sp,
                                              color: colors.textSecondary,
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              _currentRequest
                                                  .value!
                                                  .driverPhone!,
                                              style:
                                                  AppTypography.bodySmall(
                                                    context,
                                                  ).copyWith(
                                                    color: colors.textSecondary,
                                                    fontSize: 12.sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 4.h),
                                    Obx(
                                      () => Text(
                                        _driverLocation.value?.isMoving == true
                                            ? 'client.active_request.driver_on_the_way'
                                                  .tr
                                            : 'client.active_request.driver_arrived'
                                                  .tr,
                                        style:
                                            AppTypography.bodySmall(
                                              context,
                                            ).copyWith(
                                              color: colors.textSecondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Chat button
                              Container(
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Iconsax.message,
                                    color: colors.primary,
                                  ),
                                  onPressed: () {
                                    if (_currentRequest.value != null) {
                                      Get.toNamed(
                                        '/chat/${_currentRequest.value!.id}',
                                        arguments: _currentRequest.value,
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Call button
                              Container(
                                decoration: BoxDecoration(
                                  color: colors.success.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Iconsax.call,
                                    color: colors.success,
                                  ),
                                  onPressed: _makePhoneCall,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Status Timeline - Always visible
                          if (_currentRequest.value != null)
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: colors.background,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: colors.border,
                                  width: 1,
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
                                          color: _getStatusColor(
                                            _currentRequest.value!.status,
                                          ).withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Iconsax.task_square,
                                          color: _getStatusColor(
                                            _currentRequest.value!.status,
                                          ),
                                          size: 20.sp,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order Status',
                                              style:
                                                  AppTypography.titleMedium(
                                                    context,
                                                  ).copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              _getStatusText(
                                                _currentRequest.value!.status,
                                              ),
                                              style:
                                                  AppTypography.bodySmall(
                                                    context,
                                                  ).copyWith(
                                                    color: _getStatusColor(
                                                      _currentRequest
                                                          .value!
                                                          .status,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Price badge
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colors.primary.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: Text(
                                          CurrencyHelper.formatWithSymbol(_currentRequest.value!.agreedPrice ?? _currentRequest.value!.totalPrice, _currentRequest.value!.currencySymbol),
                                          style:
                                              AppTypography.bodyMedium(
                                                context,
                                              ).copyWith(
                                                color: colors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                  StatusTimelineWidget(
                                    request: _currentRequest.value!,
                                    isPurchaseRequest:
                                        _currentRequest.value!.serviceType ==
                                            ServiceType.purchase ||
                                        _currentRequest.value!.serviceType ==
                                            ServiceType.task,
                                  ),
                                ],
                              ),
                            ),

                          if (_currentRequest.value != null)
                            SizedBox(height: 16.h),

                          // Expandable Order Details
                          if (_currentRequest.value != null)
                            Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: colors.background,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: colors.border,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    // Header - Tap to expand/collapse
                                    InkWell(
                                      onTap: () {
                                        showOrderDetails.value =
                                            !showOrderDetails.value;
                                      },
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.w),
                                        child: Row(
                                          children: [
                                            Icon(
                                              _getServiceTypeIcon(
                                                _currentRequest
                                                    .value!
                                                    .serviceType,
                                              ),
                                              color: colors.primary,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Text(
                                                'Order Details',
                                                style:
                                                    AppTypography.titleMedium(
                                                      context,
                                                    ).copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            Icon(
                                              showOrderDetails.value
                                                  ? Iconsax.arrow_up_2
                                                  : Iconsax.arrow_down_1,
                                              color: colors.textSecondary,
                                              size: 20.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expandable content
                                    if (showOrderDetails.value) ...[
                                      Divider(height: 1, color: colors.border),
                                      Padding(
                                        padding: EdgeInsets.all(16.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Service Type
                                            _buildInfoRow(
                                              colors,
                                              'Service',
                                              _getServiceTypeName(
                                                _currentRequest
                                                    .value!
                                                    .serviceType,
                                              ),
                                              Iconsax.category,
                                            ),
                                            SizedBox(height: 10.h),
                                            // Pickup Location
                                            if (_currentRequest
                                                    .value!
                                                    .pickupLocation !=
                                                null)
                                              _buildInfoRow(
                                                colors,
                                                'Pickup',
                                                _currentRequest
                                                        .value!
                                                        .pickupLocation!
                                                        .address ??
                                                    'Location set',
                                                Iconsax.location,
                                              ),
                                            if (_currentRequest
                                                    .value!
                                                    .pickupLocation !=
                                                null)
                                              SizedBox(height: 10.h),
                                            // Delivery Location
                                            _buildInfoRow(
                                              colors,
                                              'Delivery',
                                              _currentRequest
                                                      .value!
                                                      .destinationLocation
                                                      .address ??
                                                  'Location set',
                                              Iconsax.location_tick,
                                            ),
                                            // Purchase Details
                                            if (_currentRequest
                                                    .value!
                                                    .isPurchaseRequired ??
                                                false) ...[
                                              SizedBox(height: 10.h),
                                              _buildInfoRow(
                                                colors,
                                                'Item',
                                                _currentRequest
                                                        .value!
                                                        .itemDescription ??
                                                    'Not specified',
                                                Iconsax.shopping_bag,
                                              ),
                                            ],
                                            SizedBox(height: 12.h),
                                            Divider(
                                              height: 1,
                                              color: colors.border,
                                            ),
                                            SizedBox(height: 12.h),
                                            // Price breakdown
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total Amount',
                                                  style:
                                                      AppTypography.bodyMedium(
                                                        context,
                                                      ).copyWith(
                                                        color: colors
                                                            .textSecondary,
                                                      ),
                                                ),
                                                Text(
                                                  CurrencyHelper.formatWithSymbol(_currentRequest.value!.agreedPrice ?? _currentRequest.value!.totalPrice, _currentRequest.value!.currencySymbol),
                                                  style:
                                                      AppTypography.titleMedium(
                                                        context,
                                                      ).copyWith(
                                                        color: colors.primary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (_currentRequest
                                                        .value!
                                                        .agreedPrice !=
                                                    null &&
                                                _currentRequest
                                                        .value!
                                                        .agreedPrice !=
                                                    _currentRequest
                                                        .value!
                                                        .totalPrice) ...[
                                              SizedBox(height: 8.h),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.tag_2,
                                                    size: 14.sp,
                                                    color: colors.success,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    'Price negotiated successfully',
                                                    style:
                                                        AppTypography.bodySmall(
                                                          context,
                                                        ).copyWith(
                                                          color: colors.success,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            // Payment Status
                                            if (_currentRequest.value!.status ==
                                                RequestStatus.completed) ...[
                                              SizedBox(height: 12.h),
                                              Container(
                                                padding: EdgeInsets.all(10.w),
                                                decoration: BoxDecoration(
                                                  color:
                                                      _currentRequest
                                                          .value!
                                                          .isPaid
                                                      ? colors.success
                                                            .withValues(
                                                              alpha: 0.1,
                                                            )
                                                      : colors.warning
                                                            .withValues(
                                                              alpha: 0.1,
                                                            ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      _currentRequest
                                                              .value!
                                                              .isPaid
                                                          ? Iconsax.tick_circle
                                                          : Iconsax.warning_2,
                                                      size: 16.sp,
                                                      color:
                                                          _currentRequest
                                                              .value!
                                                              .isPaid
                                                          ? colors.success
                                                          : colors.warning,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Expanded(
                                                      child: Text(
                                                        _currentRequest
                                                                .value!
                                                                .isPaid
                                                            ? 'Payment Confirmed'
                                                            : 'Awaiting Payment Confirmation',
                                                        style:
                                                            AppTypography.bodySmall(
                                                              context,
                                                            ).copyWith(
                                                              color:
                                                                  _currentRequest
                                                                      .value!
                                                                      .isPaid
                                                                  ? colors
                                                                        .success
                                                                  : colors
                                                                        .warning,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),

                          if (_currentRequest.value != null)
                            SizedBox(height: 16.h),

                          // ETA and distance info
                          if (_directions.value != null)
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.clock,
                                    color: colors.primary,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ETA: ${_directions.value!.durationText}',
                                          style:
                                              AppTypography.titleMedium(
                                                context,
                                              ).copyWith(
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        Text(
                                          '${_directions.value!.distanceText}',
                                          style:
                                              AppTypography.bodyMedium(
                                                context,
                                              ).copyWith(
                                                color: colors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Timeline toggle button
                                  IconButton(
                                    icon: Icon(
                                      showTimeline.value
                                          ? Iconsax.minus_square
                                          : Iconsax.add_square,
                                      color: colors.primary,
                                    ),
                                    onPressed: () {
                                      showTimeline.value = !showTimeline.value;
                                    },
                                  ),
                                ],
                              ),
                            ),

                          if (_directions.value != null) SizedBox(height: 16.h),

                          // Additional Timeline (collapsible) - Negotiation history
                          Obx(
                            () =>
                                showTimeline.value &&
                                    _currentRequest.value != null
                                ? Column(
                                    children: [
                                      // Negotiation Timeline (if negotiation happened)
                                      if (_currentRequest
                                                  .value!
                                                  .driverCounterPrice !=
                                              null ||
                                          _currentRequest.value!.agreedPrice !=
                                              null)
                                        Container(
                                          padding: EdgeInsets.all(16.w),
                                          decoration: BoxDecoration(
                                            color: colors.background,
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            border: Border.all(
                                              color: colors.border,
                                              width: 1,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Iconsax.receipt_text,
                                                    color: colors.primary,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(width: 12.w),
                                                  Text(
                                                    'Negotiation History',
                                                    style:
                                                        AppTypography.titleMedium(
                                                          context,
                                                        ).copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16.h),
                                              _buildNegotiationTimeline(colors),
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 16.h),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),

                          // Price breakdown (show if negotiation happened)
                          if (_currentRequest.value != null)
                            Obx(() => _buildPriceBreakdown(colors)),

                          if (_currentRequest.value != null)
                            SizedBox(height: 16.h),

                          // Purchase details (if purchase/task request)
                          if (_currentRequest.value != null &&
                              (_currentRequest.value!.serviceType ==
                                      ServiceType.purchase ||
                                  _currentRequest.value!.serviceType ==
                                      ServiceType.task))
                            Obx(() => _buildPurchaseDetails(colors)),

                          if (_currentRequest.value != null &&
                              (_currentRequest.value!.serviceType ==
                                      ServiceType.purchase ||
                                  _currentRequest.value!.serviceType ==
                                      ServiceType.task))
                            SizedBox(height: 16.h),

                          // Confirm Payment button (when completed) - Enhanced UI
                          if (_currentRequest.value?.status ==
                              RequestStatus.completed)
                            Obx(
                              () => Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.success.withValues(
                                        alpha: 0.15,
                                      ),
                                      colors.success.withValues(
                                        alpha: 0.05,
                                      ),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    16.r,
                                  ),
                                  border: Border.all(
                                    color: colors.success.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                            color: colors.success.withValues(
                                              alpha: 0.2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Iconsax.tick_circle,
                                            color: colors.success,
                                            size: 24.sp,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Order Completed!',
                                                style:
                                                    AppTypography.titleMedium(
                                                      context,
                                                    ).copyWith(
                                                      color: colors.success,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                'Please confirm your cash payment',
                                                style:
                                                    AppTypography.bodySmall(
                                                      context,
                                                    ).copyWith(
                                                      color:
                                                          colors.textSecondary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    // Payment amount summary
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: colors.background,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Amount Paid (Cash):',
                                            style:
                                                AppTypography.bodyMedium(
                                                  context,
                                                ).copyWith(
                                                  color: colors.textSecondary,
                                                ),
                                          ),
                                          Text(
                                            CurrencyHelper.formatWithSymbol(_currentRequest.value!.agreedPrice ?? _currentRequest.value!.totalPrice, _currentRequest.value!.currencySymbol),
                                            style:
                                                AppTypography.titleLarge(
                                                  context,
                                                ).copyWith(
                                                  color: colors.success,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    // Confirmation button
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50.h,
                                      child: ElevatedButton.icon(
                                        onPressed: isLoading.value
                                            ? null
                                            : _confirmPayment,
                                        icon: isLoading.value
                                            ? SizedBox(
                                                width: 20.w,
                                                height: 20.h,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        Colors.white,
                                                      ),
                                                ),
                                              )
                                            : Icon(
                                                Iconsax.verify,
                                                color: Colors.white,
                                                size: 20.sp,
                                              ),
                                        label: Text(
                                          isLoading.value
                                              ? 'Processing...'
                                              : 'Confirm Payment Received',
                                          style:
                                              AppTypography.titleMedium(
                                                context,
                                              ).copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.success,
                                          disabledBackgroundColor: colors
                                              .success
                                              .withValues(alpha: 0.5),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    // Info text
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.info_circle,
                                          size: 14.sp,
                                          color: colors.textSecondary,
                                        ),
                                        SizedBox(width: 6.w),
                                        Expanded(
                                          child: Text(
                                            'Driver is waiting for your confirmation',
                                            style:
                                                AppTypography.bodySmall(
                                                  context,
                                                ).copyWith(
                                                  color: colors.textSecondary,
                                                  fontSize: 11.sp,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          if (_currentRequest.value?.status ==
                              RequestStatus.completed)
                            SizedBox(height: 16.h),

                          // Cancel button
                          if (_currentRequest.value?.status !=
                                  RequestStatus.completed &&
                              _currentRequest.value?.status !=
                                  RequestStatus.cancelled)
                            Obx(
                              () => SizedBox(
                                width: double.infinity,
                                height: 50.h,
                                child: OutlinedButton.icon(
                                  onPressed: isLoading.value
                                      ? null
                                      : _cancelRequest,
                                  icon: isLoading.value
                                      ? SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  colors.error,
                                                ),
                                          ),
                                        )
                                      : Icon(
                                          Iconsax.close_circle,
                                          color: colors.error,
                                        ),
                                  label: Text(
                                    'client.active_request.cancel_request'.tr,
                                    style: AppTypography.titleMedium(
                                      context,
                                    ).copyWith(color: colors.error),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: colors.error),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                      }),
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

  Widget _buildStatusInfo(AppColorScheme colors) {
    final status = _currentRequest.value?.status;
    if (status == null) return const SizedBox.shrink();

    String statusText = '';
    IconData statusIcon = Iconsax.info_circle;
    Color statusColor = colors.primary;

    switch (status) {
      case RequestStatus.driver_proposed:
        statusText = 'client.active_request.driver_proposed'.tr;
        statusIcon = Iconsax.user_tick;
        statusColor = Colors.orange;
        break;
      case RequestStatus.accepted:
        statusText = 'client.active_request.request_accepted'.tr;
        statusIcon = Iconsax.tick_circle;
        statusColor = colors.success;
        break;
      case RequestStatus.driver_arriving:
        statusText = 'client.active_request.driver_arriving'.tr;
        statusIcon = Iconsax.routing;
        statusColor = Colors.orange;
        break;
      case RequestStatus.in_progress:
        statusText = 'client.active_request.service_in_progress'.tr;
        statusIcon = Iconsax.play_circle;
        statusColor = colors.primary;
        break;
      case RequestStatus.completed:
        statusText = 'client.active_request.service_completed'.tr;
        statusIcon = Iconsax.tick_square;
        statusColor = colors.success;
        break;
      default:
        statusText = 'client.active_request.tracking_driver'.tr;
        statusIcon = Iconsax.location_tick;
        statusColor = colors.primary;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: AppTypography.titleMedium(
                    context,
                  ).copyWith(color: colors.textPrimary),
                ),
                if (_driverLocation.value != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Last updated: ${_formatTime(_driverLocation.value!.timestamp)}',
                    style: AppTypography.bodySmall(
                      context,
                    ).copyWith(color: colors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build content for driver_proposed status - shows proposed driver info with accept/reject
  Widget _buildDriverProposedContent(AppColorScheme colors, ScrollController scrollController) {
    final request = _currentRequest.value;
    if (request == null) return const SizedBox.shrink();
    
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      children: [
        // Header card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withValues(alpha: 0.15),
                Colors.orange.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(
                Iconsax.user_tick,
                color: Colors.orange,
                size: 48.sp,
              ),
              SizedBox(height: 12.h),
              Text(
                'Driver Available!',
                style: AppTypography.titleLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'A driver wants to fulfill your request',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Proposed driver info
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: colors.primary.withValues(alpha: 0.1),
                    child: Icon(Iconsax.user, size: 28.sp, color: colors.primary),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.proposedDriverName ?? 'Driver',
                          style: AppTypography.titleMedium(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (request.proposedDriverPhone != null) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Iconsax.call, size: 14.sp, color: colors.textSecondary),
                              SizedBox(width: 4.w),
                              Text(
                                request.proposedDriverPhone!,
                                style: AppTypography.bodySmall(context).copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(color: colors.border),
              SizedBox(height: 16.h),
              // Price info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service Price',
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(
                      request.totalPrice,
                      request.currencySymbol,
                    ),
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24.h),
        
        // Accept button
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton.icon(
            onPressed: isLoading.value ? null : _approveDriver,
            icon: isLoading.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(Iconsax.tick_circle, color: Colors.white),
            label: Text(
              'Accept Driver',
              style: AppTypography.titleMedium(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Reject button
        SizedBox(
          width: double.infinity,
          height: 54.h,
          child: OutlinedButton.icon(
            onPressed: isLoading.value ? null : _rejectDriver,
            icon: Icon(Iconsax.close_circle, color: colors.error),
            label: Text(
              'Reject & Find Another',
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.error,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Info text
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: colors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(Iconsax.info_circle, size: 18.sp, color: colors.info),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'If you reject, your request will be available for other drivers.',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Approve the proposed driver
  Future<void> _approveDriver() async {
    final request = _currentRequest.value;
    if (request == null || request.id == null) return;
    
    final clientId = Get.find<AuthController>().currentUser.value?.id;
    if (clientId == null) return;
    
    isLoading.value = true;
    
    try {
      final updatedRequest = await _requestService.approveDriver(
        requestId: request.id!,
        clientId: clientId,
      );
      
      if (updatedRequest != null) {
        _currentRequest.value = updatedRequest;
        
        // Subscribe to driver location if now assigned
        if (updatedRequest.driverId != null) {
          _subscribeToDriverLocation();
        }
        
        Get.snackbar(
          'Success',
          'Driver approved! They will start the service soon.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to approve driver: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Reject the proposed driver
  Future<void> _rejectDriver() async {
    final request = _currentRequest.value;
    if (request == null || request.id == null) return;
    
    final clientId = Get.find<AuthController>().currentUser.value?.id;
    if (clientId == null) return;
    
    // Confirm rejection
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Reject Driver?'),
        content: const Text(
          'This will make your request available for other drivers. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    
    if (confirmed != true) return;
    
    isLoading.value = true;
    
    try {
      final updatedRequest = await _requestService.rejectDriver(
        requestId: request.id!,
        clientId: clientId,
      );
      
      if (updatedRequest != null) {
        _currentRequest.value = updatedRequest;
        
        Get.snackbar(
          'Driver Rejected',
          'Your request is now available for other drivers.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject driver: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
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
                      ? '🛍️ Purchase & Delivery'
                      : '📋 Task Service',
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
                    'What you requested:',
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
                  'Est. Item Cost',
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
          if (request.agreedPrice != null) ...[
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Fee',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(request.agreedPrice!, request.currencySymbol),
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: colors.border),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total to Pay',
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol((request.estimatedPurchaseCost ?? 0) + (request.agreedPrice ?? 0), request.currencySymbol),
                  style: AppTypography.headlineSmall(context).copyWith(
                    color: colors.success,
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
                    'Driver will purchase items first. You\'ll pay the total amount upon delivery.',
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

  String _getStatusText(RequestStatus status) {
    switch (status) {
      case RequestStatus.driver_proposed:
        return 'client.active_request.driver_proposed'.tr;
      case RequestStatus.accepted:
        return 'client.active_request.request_accepted'.tr;
      case RequestStatus.driver_arriving:
        return 'client.active_request.driver_arriving'.tr;
      case RequestStatus.in_progress:
        return 'client.active_request.service_in_progress'.tr;
      case RequestStatus.completed:
        return 'client.active_request.service_completed'.tr;
      default:
        return 'client.active_request.title'.tr;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${diff.inHours}h ago';
    }
  }

  /// Build negotiation timeline showing price negotiation journey
  Widget _buildNegotiationTimeline(AppColorScheme colors) {
    final request = _currentRequest.value!;
    final controller = Get.find<RequestController>();
    final didNegotiate = controller.didNegotiate(request);

    List<negotiation.TimelineStep> steps = [];

    // Step 1: Request Posted
    steps.add(
      negotiation.TimelineStep(
        icon: Iconsax.document_text,
        iconColor: colors.success,
        iconBackgroundColor: colors.success.withValues(alpha: 0.1),
        title: 'timeline.request_posted'.tr,
        description: 'timeline.posted_with_offer'.trParams({
          'price': (request.clientOfferedPrice ?? 0).toStringAsFixed(2),
        }),
        timestamp: request.createdAt,
        isCompleted: true,
        isActive: false,
      ),
    );

    // Step 2: Offer Received (if negotiated)
    if (didNegotiate && request.driverCounterPrice != null) {
      steps.add(
        negotiation.TimelineStep(
          icon: Iconsax.receipt_edit,
          iconColor: colors.warning,
          iconBackgroundColor: colors.warning.withValues(alpha: 0.1),
          title: 'timeline.offer_received'.tr,
          description: 'timeline.driver_counter_offer'.trParams({
            'price': request.driverCounterPrice!.toStringAsFixed(2),
          }),
          timestamp: request.acceptedAt,
          isCompleted: true,
          isActive: false,
        ),
      );
    }

    // Step 3: Price Agreed
    if (request.agreedPrice != null) {
      final isDirectAcceptance = !didNegotiate;
      steps.add(
        negotiation.TimelineStep(
          icon: Iconsax.tick_circle,
          iconColor: colors.success,
          iconBackgroundColor: colors.success.withValues(alpha: 0.1),
          title: 'timeline.price_agreed'.tr,
          description: isDirectAcceptance
              ? 'timeline.driver_accepted_your_price'.tr
              : 'timeline.negotiated_price'.trParams({
                  'clientPrice': (request.clientOfferedPrice ?? 0)
                      .toStringAsFixed(2),
                  'agreedPrice': request.agreedPrice!.toStringAsFixed(2),
                }),
          timestamp: request.acceptedAt,
          isCompleted: true,
          isActive: false,
        ),
      );
    }

    // Step 4: Driver Arriving
    steps.add(
      negotiation.TimelineStep(
        icon: Iconsax.car,
        iconColor: request.status == RequestStatus.driver_arriving
            ? colors.primary
            : colors.textSecondary,
        iconBackgroundColor: request.status == RequestStatus.driver_arriving
            ? colors.primary.withValues(alpha: 0.1)
            : colors.surface,
        title: 'Driver Arriving',
        description: 'Driver is heading to pickup location',
        timestamp: null,
        isCompleted:
            request.status == RequestStatus.in_progress ||
            request.status == RequestStatus.completed,
        isActive: request.status == RequestStatus.driver_arriving,
      ),
    );

    // Step 5: Service In Progress
    steps.add(
      negotiation.TimelineStep(
        icon: Iconsax.truck_fast,
        iconColor: request.status == RequestStatus.in_progress
            ? colors.primary
            : colors.textSecondary,
        iconBackgroundColor: request.status == RequestStatus.in_progress
            ? colors.primary.withValues(alpha: 0.1)
            : colors.surface,
        title: 'Service In Progress',
        description: 'Driver is providing the service',
        timestamp: null,
        isCompleted: request.status == RequestStatus.completed,
        isActive: request.status == RequestStatus.in_progress,
      ),
    );

    // Step 6: Completed
    steps.add(
      negotiation.TimelineStep(
        icon: Iconsax.tick_square,
        iconColor: request.status == RequestStatus.completed
            ? colors.success
            : colors.textSecondary,
        iconBackgroundColor: request.status == RequestStatus.completed
            ? colors.success.withValues(alpha: 0.1)
            : colors.surface,
        title: 'Service Completed',
        description: 'Service has been completed',
        timestamp: null,
        isCompleted: request.status == RequestStatus.completed,
        isActive: false,
      ),
    );

    return negotiation.NegotiationTimelineWidget(steps: steps);
  }

  /// Build price breakdown card showing negotiation outcome
  Widget _buildPriceBreakdown(AppColorScheme colors) {
    final request = _currentRequest.value!;
    final controller = Get.find<RequestController>();
    final didNegotiate = controller.didNegotiate(request);

    if (request.agreedPrice == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),

          // Your Offer
          _PriceRow(
            colors: colors,
            label: 'timeline.your_offer'.tr,
            amount: request.clientOfferedPrice ?? 0,
            crossed: didNegotiate,
          ),

          // Driver's Offer (if negotiated)
          if (didNegotiate && request.driverCounterPrice != null) ...[
            SizedBox(height: 8.h),
            Icon(Iconsax.arrow_down, size: 16.sp, color: colors.warning),
            SizedBox(height: 8.h),
            _PriceRow(
              colors: colors,
              label: 'timeline.driver_offer'.tr,
              amount: request.driverCounterPrice!,
              crossed: false,
            ),
          ],

          SizedBox(height: 12.h),
          Divider(color: colors.border),
          SizedBox(height: 12.h),

          // Agreed Price
          _PriceRow(
            colors: colors,
            label: 'timeline.agreed_price'.tr,
            amount: request.agreedPrice!,
            highlight: true,
          ),

          SizedBox(height: 16.h),

          // Commission breakdown
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
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
                      CurrencyHelper.formatWithSymbol(request.agreedPrice! * 0.05, request.currencySymbol),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Divider(color: colors.border, height: 1),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'timeline.driver_receives'.tr,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      CurrencyHelper.formatWithSymbol(controller.getFinalEarnings(request), request.currencySymbol),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method for building info rows in order summary
  Widget _buildInfoRow(
    AppColorScheme colors,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: colors.textSecondary,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
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

  /// Get service type icon
  IconData _getServiceTypeIcon(ServiceType type) {
    switch (type) {
      case ServiceType.delivery:
        return Iconsax.truck_fast;
      case ServiceType.purchase:
        return Iconsax.shopping_bag;
      case ServiceType.task:
        return Iconsax.task_square;
      default:
        return Iconsax.box;
    }
  }

  /// Get service type name
  String _getServiceTypeName(ServiceType type) {
    switch (type) {
      case ServiceType.delivery:
        return 'Delivery';
      case ServiceType.purchase:
        return 'Purchase & Delivery';
      case ServiceType.task:
        return 'Task Service';
      default:
        return 'Service';
    }
  }

  /// Get status color
  Color _getStatusColor(RequestStatus status) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;

    switch (status) {
      case RequestStatus.completed:
        return colors.success;
      case RequestStatus.cancelled:
        return colors.error;
      case RequestStatus.in_progress:
      case RequestStatus.driver_arriving:
        return colors.primary;
      case RequestStatus.accepted:
        return colors.success;
      case RequestStatus.driver_proposed:
        return colors.warning;
      default:
        return colors.warning;
    }
  }
}

/// Helper widget for price row
class _PriceRow extends StatelessWidget {
  final AppColorScheme colors;
  final String label;
  final double amount;
  final bool crossed;
  final bool highlight;

  const _PriceRow({
    required this.colors,
    required this.label,
    required this.amount,
    this.crossed = false,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: highlight ? colors.primary : colors.textSecondary,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
            decoration: crossed ? TextDecoration.lineThrough : null,
          ),
        ),
        Text(
          CurrencyHelper.format(amount),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: highlight ? colors.primary : colors.textPrimary,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
            decoration: crossed ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}
