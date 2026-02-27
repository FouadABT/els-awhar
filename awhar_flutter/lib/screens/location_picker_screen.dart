import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/controllers/map_controller.dart';
import '../core/services/location_service.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../shared/widgets/awhar_map_widget.dart';
import '../shared/widgets/map_action_button.dart';

/// Screen for selecting pickup or destination location on the map
class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late final MapController mapController;
  late final LocationService locationService;
  final RxBool isPickup = true.obs;
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxString selectedAddress = ''.obs;

  @override
  void initState() {
    super.initState();
    
    // Get arguments
    final args = Get.arguments as Map<String, dynamic>?;
    isPickup.value = args?['isPickup'] ?? true;
    final initialLat = args?['lat'] as double?;
    final initialLng = args?['lng'] as double?;
    
    // Initialize controllers
    mapController = Get.put(MapController(), tag: 'locationPicker');
    locationService = Get.find<LocationService>();

    // Set initial location if provided, otherwise use current
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (initialLat != null && initialLng != null) {
        final location = LatLng(initialLat, initialLng);
        selectedLocation.value = location;
        mapController.addMarker(
          id: 'selected',
          position: location,
          title: isPickup.value ? 'Pickup' : 'Destination',
          icon: BitmapDescriptor.defaultMarkerWithHue(
            isPickup.value ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
          ),
        );
        await mapController.moveCamera(location);
        _updateAddress(location);
      } else {
        await mapController.moveToCurrentLocation();
        final position = await locationService.getCurrentPosition();
        if (position != null) {
          final location = LatLng(position.latitude, position.longitude);
          selectedLocation.value = location;
          mapController.addMarker(
            id: 'selected',
            position: location,
            title: isPickup.value ? 'Pickup' : 'Destination',
            icon: BitmapDescriptor.defaultMarkerWithHue(
              isPickup.value ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
            ),
          );
          _updateAddress(location);
        }
      }
    });
  }

  @override
  void dispose() {
    Get.delete<MapController>(tag: 'locationPicker');
    super.dispose();
  }

  /// Update address from coordinates
  Future<void> _updateAddress(LatLng location) async {
    try {
      final address = await locationService.getAddressFromCoordinates(location);
      if (address != null) {
        selectedAddress.value = address;
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  /// Handle map tap to select location
  void _handleMapTap(LatLng position) {
    selectedLocation.value = position;
    mapController.clearMarkers();
    mapController.addMarker(
      id: 'selected',
      position: position,
      title: isPickup.value ? 'Pickup' : 'Destination',
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isPickup.value ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
      ),
    );
    _updateAddress(position);
  }

  /// Confirm location selection
  void _confirmLocation() {
    if (selectedLocation.value != null) {
      Get.back(result: {
        'lat': selectedLocation.value!.latitude,
        'lng': selectedLocation.value!.longitude,
        'address': selectedAddress.value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Map
          AwharMapWidget(
            controller: mapController,
            onTap: _handleMapTap,
          ),

          // Top gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.background.withValues(alpha: 0.9),
                    colors.background.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  // Back button
                  Container(
                    width: 40.w,
                    height: 40.w,
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
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back, color: colors.textPrimary, size: 20.sp),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Title
                  Expanded(
                    child: Obx(() => Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        isPickup.value ? 'Select Pickup Location' : 'Select Destination',
                        style: AppTypography.titleMedium(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),

          // Map controls (My Location button)
          Positioned(
            right: 16.w,
            bottom: 200.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MapActionButton(
                  icon: Iconsax.location,
                  onPressed: () async {
                    await mapController.moveToCurrentLocation();
                    final position = await locationService.getCurrentPosition();
                    if (position != null) {
                      _handleMapTap(LatLng(position.latitude, position.longitude));
                    }
                  },
                  tooltip: 'My Location',
                ),
              ],
            ),
          ),

          // Selected location info card
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 100.h,
            child: Obx(() {
              if (selectedLocation.value == null) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: (isPickup.value ? Colors.green : Colors.red).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPickup.value ? Iconsax.location : Iconsax.location_tick,
                        color: isPickup.value ? Colors.green : Colors.red,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isPickup.value ? 'Pickup Location' : 'Destination',
                            style: AppTypography.labelSmall(context).copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            selectedAddress.value.isEmpty
                                ? 'Loading address...'
                                : selectedAddress.value,
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
                ),
              );
            }),
          ),

          // Confirm button
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 24.h,
            child: SafeArea(
              child: Obx(() => ElevatedButton(
                onPressed: selectedLocation.value != null ? _confirmLocation : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.tick_circle, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      'Confirm Location',
                      style: AppTypography.bodyLarge(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
