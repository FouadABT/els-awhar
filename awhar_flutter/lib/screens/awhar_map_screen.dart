import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/controllers/map_controller.dart';
import '../../core/services/location_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/awhar_map_widget.dart';
import '../../shared/widgets/location_card.dart';
import '../../shared/widgets/map_action_button.dart';

/// Modern map screen with pickup and destination selection
class AwharMapScreen extends StatefulWidget {
  const AwharMapScreen({super.key});

  @override
  State<AwharMapScreen> createState() => _AwharMapScreenState();
}

class _AwharMapScreenState extends State<AwharMapScreen> {
  late final MapController mapController;
  late final LocationService locationService;

  @override
  void initState() {
    super.initState();
    mapController = Get.put(MapController());
    locationService = Get.find<LocationService>();

    // Move to current location on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.moveToCurrentLocation();
    });
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
            onLongPress: _handleMapLongPress,
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
          _buildTopBar(colors),

          // Location selection cards
          _buildLocationCards(colors),

          // Map controls
          _buildMapControls(colors),

          // Bottom action button
          _buildBottomButton(colors),

          // Loading indicator
          Obx(() {
            if (!mapController.isLoading.value) return const SizedBox.shrink();
            return Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: colors.primary),
                      SizedBox(height: 16.h),
                      Text(
                        'Getting your location...',
                        style: AppTypography.bodyMedium(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTopBar(AppColorScheme colors) {
    return SafeArea(
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

            // Title - compact single line
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.location, size: 18.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text(
                      'Select Pickup & Destination',
                      style: AppTypography.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCards(AppColorScheme colors) {
    return Positioned(
      bottom: 140.h,
      left: 16.w,
      right: 16.w,
      child: Obx(
        () => Column(
          children: [
            // Pickup card
            LocationCard(
              title: 'Pickup Location',
              address: mapController.pickupAddress.value,
              icon: Icons.my_location,
              iconColor: Colors.green,
              isActive: mapController.pickupLocation.value != null,
              onTap: () => _selectPickupLocation(),
              onClear: () => mapController.clearPickup(),
            ),
            SizedBox(height: 12.h),

            // Destination card
            LocationCard(
              title: 'Destination',
              address: mapController.destinationAddress.value,
              icon: Icons.location_on,
              iconColor: Colors.red,
              isActive: mapController.destinationLocation.value != null,
              onTap: () => _selectDestinationLocation(),
              onClear: () => mapController.clearDestination(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls(AppColorScheme colors) {
    return Positioned(
      right: 16.w,
      top: 140.h,
      child: Column(
        children: [
          // My location button
          MapActionButton(
            icon: Icons.my_location,
            onPressed: () => mapController.moveToCurrentLocation(),
            tooltip: 'My Location',
          ),
          SizedBox(height: 12.h),

          // Map type button
          MapActionButton(
            icon: Icons.layers,
            onPressed: _showMapTypeDialog,
            tooltip: 'Map Type',
          ),
          SizedBox(height: 12.h),

          // Clear all button
          Obx(() {
            if (mapController.markers.isEmpty) return const SizedBox.shrink();
            return MapActionButton(
              icon: Icons.clear_all,
              onPressed: () => mapController.clearTrip(),
              tooltip: 'Clear All',
              iconColor: colors.error,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomButton(AppColorScheme colors) {
    return Positioned(
      bottom: 24.h,
      left: 16.w,
      right: 16.w,
      child: Obx(
        () {
          final hasPickup = mapController.pickupLocation.value != null;
          final hasDestination = mapController.destinationLocation.value != null;
          final isEnabled = hasPickup && hasDestination;

          return AnimatedOpacity(
            opacity: isEnabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: isEnabled ? _confirmLocations : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Confirm Locations',
                      style: AppTypography.labelLarge(context).copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleMapTap(LatLng position) {
    // If no pickup, set pickup
    if (mapController.pickupLocation.value == null) {
      mapController.setPickupLocation(position);
    }
    // If pickup exists but no destination, set destination
    else if (mapController.destinationLocation.value == null) {
      mapController.setDestinationLocation(position);
    }
  }

  void _handleMapLongPress(LatLng position) {
    _showLocationOptionsDialog(position);
  }

  void _selectPickupLocation() async {
    Get.snackbar(
      'Tap on Map',
      'Tap on the map to select pickup location',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
      colorText: Colors.white,
    );
  }

  void _selectDestinationLocation() async {
    Get.snackbar(
      'Tap on Map',
      'Tap on the map to select destination',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
      colorText: Colors.white,
    );
  }

  void _showLocationOptionsDialog(LatLng position) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.my_location, color: Colors.green),
              title: const Text('Set as Pickup'),
              onTap: () {
                Get.back();
                mapController.setPickupLocation(position);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text('Set as Destination'),
              onTap: () {
                Get.back();
                mapController.setDestinationLocation(position);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Add Marker'),
              onTap: () {
                Get.back();
                mapController.addMarker(
                  id: DateTime.now().toString(),
                  position: position,
                  title: 'Custom Location',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMapTypeDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Map Type',
              style: AppTypography.headlineMedium(context),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Normal'),
              onTap: () {
                Get.back();
                // Change map type logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.satellite),
              title: const Text('Satellite'),
              onTap: () {
                Get.back();
                // Change map type logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.terrain),
              title: const Text('Terrain'),
              onTap: () {
                Get.back();
                // Change map type logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLocations() {
    final pickup = mapController.pickupLocation.value!;
    final destination = mapController.destinationLocation.value!;
    final distance = locationService.calculateDistance(pickup, destination);

    Get.dialog(
      AlertDialog(
        title: const Text('Locations Confirmed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pickup: ${mapController.pickupAddress.value}'),
            SizedBox(height: 8.h),
            Text('Destination: ${mapController.destinationAddress.value}'),
            SizedBox(height: 8.h),
            Text('Distance: ${distance.toStringAsFixed(2)} km'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(result: {
                'pickup': pickup,
                'destination': destination,
                'pickupAddress': mapController.pickupAddress.value,
                'destinationAddress': mapController.destinationAddress.value,
                'distance': distance,
              });
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MapController>();
    super.dispose();
  }
}
