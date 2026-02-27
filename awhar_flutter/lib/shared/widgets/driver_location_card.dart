import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/services/location_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'package:geocoding/geocoding.dart';
import 'package:awhar_client/awhar_client.dart';

/// Widget for managing driver's saved location with mismatch detection
class DriverLocationCard extends StatefulWidget {
  const DriverLocationCard({super.key});

  @override
  State<DriverLocationCard> createState() => _DriverLocationCardState();
}

class _DriverLocationCardState extends State<DriverLocationCard> {
  final LocationService _locationService = Get.find<LocationService>();
  final AuthController _authController = Get.find<AuthController>();
  
  Timer? _mismatchCheckTimer;
  final Rx<double?> locationMismatch = Rx<double?>(null);
  final RxBool isLoadingAddress = false.obs;
  final RxString savedAddress = ''.obs;
  final RxBool isSaving = false.obs;
  
  // Manual location selection
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
    _startMismatchCheck();
    
    // Listen to user changes and reload address
    ever(_authController.currentUser, (user) {
      if (user?.currentLatitude != null && user?.currentLongitude != null) {
        _loadSavedAddress();
        _checkMismatch();
      }
    });
  }

  @override
  void dispose() {
    _mismatchCheckTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  /// Load saved address from user's location
  Future<void> _loadSavedAddress() async {
    final user = _authController.currentUser.value;
    if (user?.currentLatitude == null || user?.currentLongitude == null) {
      savedAddress.value = 'Not set';
      return;
    }

    isLoadingAddress.value = true;
    try {
      final placemarks = await placemarkFromCoordinates(
        user!.currentLatitude!,
        user.currentLongitude!,
      );
      
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        savedAddress.value = '${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}'
            .replaceAll(RegExp(r',\s*,'), ',')
            .replaceAll(RegExp(r'^,\s*|,\s*$'), '');
      }
    } catch (e) {
      print('[DriverLocationCard] Error loading address: $e');
      savedAddress.value = 'Unable to load address';
    } finally {
      isLoadingAddress.value = false;
    }
  }

  /// Start periodic mismatch checking
  void _startMismatchCheck() {
    _checkMismatch();
    _mismatchCheckTimer = Timer.periodic(const Duration(minutes: 2), (timer) {
      _checkMismatch();
    });
  }

  /// Check if current location differs from saved
  Future<void> _checkMismatch() async {
    final distance = await _locationService.checkLocationMismatch();
    if (mounted) {
      locationMismatch.value = distance;
    }
  }

  /// Save location to database (manual or GPS)
  Future<void> _saveLocation(double latitude, double longitude) async {
    try {
      isSaving.value = true;
      
      // Get address from coordinates
      String? address;
      try {
        final placemarks = await placemarkFromCoordinates(latitude, longitude);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          address = '${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}'
              .replaceAll(RegExp(r',\s*,'), ',')
              .replaceAll(RegExp(r'^,\s*|,\s*$'), '');
        }
      } catch (e) {
        print('[DriverLocationCard] Error getting address: $e');
      }

      // Save to backend
      final userId = _authController.currentUser.value?.id;
      if (userId == null) {
        Get.snackbar('Error', 'User not logged in', snackPosition: SnackPosition.TOP);
        return;
      }

      final client = Get.find<Client>();
      await client.location.updateDriverLocation(userId, latitude, longitude);

      // Refresh user data to get updated location
      await _authController.refreshUserData();
      
      // Reload address and check mismatch
      await _loadSavedAddress();
      await _checkMismatch();

      Get.snackbar(
        'Success',
        address != null ? 'Location set to: $address' : 'Location saved successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      print('[DriverLocationCard] Error saving location: $e');
      Get.snackbar('Error', 'Failed to save location: $e', snackPosition: SnackPosition.TOP);
    } finally {
      isSaving.value = false;
    }
  }

  /// Show map picker for manual location selection
  Future<void> _showMapPicker(BuildContext context, AppColorScheme colors) async {
    final user = _authController.currentUser.value;
    
    // Start with saved location or current GPS
    LatLng initialLocation;
    if (user?.currentLatitude != null && user?.currentLongitude != null) {
      initialLocation = LatLng(user!.currentLatitude!, user.currentLongitude!);
    } else {
      final position = await _locationService.getCurrentPosition();
      if (position == null) {
        Get.snackbar('Error', 'Could not get current location', snackPosition: SnackPosition.TOP);
        return;
      }
      initialLocation = LatLng(position.latitude, position.longitude);
    }

    _selectedLocation = initialLocation;

    final result = await Get.dialog<LatLng>(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(16.w),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            return Container(
              height: 600.h,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.location, color: colors.primary, size: 24.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choose Your Service Location',
                                style: AppTypography.titleMedium(context).copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Tap on the map to select your location',
                                style: AppTypography.bodySmall(context).copyWith(
                                  color: colors.textSecondary,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  ),

                  // Map
                  Expanded(
                    child: ClipRRect(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: initialLocation,
                          zoom: 15,
                        ),
                        onMapCreated: (controller) => _mapController = controller,
                        onTap: (position) {
                          setDialogState(() {
                            _selectedLocation = position;
                          });
                        },
                        markers: _selectedLocation != null
                            ? {
                                Marker(
                                  markerId: const MarkerId('selected'),
                                  position: _selectedLocation!,
                                  draggable: true,
                                  onDragEnd: (newPosition) {
                                    setDialogState(() {
                                      _selectedLocation = newPosition;
                                    });
                                  },
                                ),
                              }
                            : {},
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),

                  // Coordinates display & actions
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Coordinates
                        if (_selectedLocation != null)
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: colors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.location_tick, color: colors.primary, size: 16.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  '${_selectedLocation!.latitude.toStringAsFixed(6)}, ${_selectedLocation!.longitude.toStringAsFixed(6)}',
                                  style: AppTypography.labelMedium(context).copyWith(
                                    color: colors.textPrimary,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 16.h),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.back(),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: colors.border),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: AppTypography.labelLarge(context).copyWith(
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton.icon(
                                onPressed: () => Get.back(result: _selectedLocation),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                                icon: const Icon(Iconsax.tick_circle, color: Colors.white),
                                label: Text(
                                  'Confirm Location',
                                  style: AppTypography.labelLarge(context).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
          },
        ),
      ),
    );

    if (result != null) {
      await _saveLocation(result.latitude, result.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Obx(() {
      final user = _authController.currentUser.value;
      final hasLocation = user?.currentLatitude != null && user?.currentLongitude != null;
      final lastUpdate = user?.lastLocationUpdate;
      final mismatch = locationMismatch.value;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: mismatch != null && mismatch > 2 
                ? colors.warning 
                : colors.border,
            width: mismatch != null && mismatch > 2 ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Iconsax.location,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Service Location',
                          style: AppTypography.titleMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (lastUpdate != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            'Updated ${_formatTimeAgo(lastUpdate)}',
                            style: AppTypography.labelSmall(context).copyWith(
                              color: colors.textSecondary,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mismatch Warning (if exists)
                  if (mismatch != null && mismatch > 2) ...[
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: colors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: colors.warning.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.warning_2,
                            color: colors.warning,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location Mismatch Detected',
                                  style: AppTypography.labelMedium(context).copyWith(
                                    color: colors.warning,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'You are ${mismatch.toStringAsFixed(1)} km away from your saved location. Update to improve request accuracy.',
                                  style: AppTypography.bodySmall(context).copyWith(
                                    color: colors.textSecondary,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Saved Address
                  Row(
                    children: [
                      Icon(
                        Iconsax.map_1,
                        color: colors.primary,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Saved Address:',
                        style: AppTypography.labelMedium(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  
                  Obx(() => isLoadingAddress.value
                      ? SizedBox(
                          height: 40.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: colors.primary,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: colors.background,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: colors.border),
                          ),
                          child: Text(
                            hasLocation 
                                ? savedAddress.value
                                : 'No location saved yet',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: hasLocation 
                                  ? colors.textPrimary 
                                  : colors.textSecondary,
                            ),
                          ),
                        ),
                  ),
                  SizedBox(height: 16.h),

                  // Coordinates (if available)
                  if (hasLocation) ...[
                    Row(
                      children: [
                        Expanded(
                          child: _buildCoordinateChip(
                            context,
                            colors,
                            'Lat',
                            user!.currentLatitude!.toStringAsFixed(4),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _buildCoordinateChip(
                            context,
                            colors,
                            'Lng',
                            user.currentLongitude!.toStringAsFixed(4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Update Button
                  Obx(() => Row(
                        children: [
                          // Use Current GPS
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: isSaving.value
                                  ? null
                                  : () async {
                                      final position = await _locationService.getCurrentPosition();
                                      if (position != null) {
                                        await _saveLocation(position.latitude, position.longitude);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primary,
                                disabledBackgroundColor: colors.primary.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                              ),
                              icon: isSaving.value
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Iconsax.gps, color: Colors.white, size: 20),
                              label: Text(
                                'Use GPS',
                                style: AppTypography.labelMedium(context).copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Pick on Map
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: isSaving.value
                                  ? null
                                  : () => _showMapPicker(context, colors),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: colors.primary, width: 2),
                                disabledForegroundColor: colors.primary.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                              ),
                              icon: Icon(Iconsax.map_1, color: colors.primary, size: 20),
                              label: Text(
                                'Pick on Map',
                                style: AppTypography.labelMedium(context).copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),

                  // Info Text
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.info_circle,
                        color: colors.info,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Your location helps us show you relevant requests nearby. Update regularly for best results.',
                          style: AppTypography.bodySmall(context).copyWith(
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
          ],
        ),
      );
    });
  }

  Widget _buildCoordinateChip(
    BuildContext context,
    AppColorScheme colors,
    String label,
    String value,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textSecondary,
              fontSize: 10.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTypography.labelMedium(context).copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return 'on ${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
