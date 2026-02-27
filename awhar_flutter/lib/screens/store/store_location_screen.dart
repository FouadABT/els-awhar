import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/controllers/store_controller.dart';
import '../../core/controllers/map_controller.dart';
import '../../core/services/location_service.dart';
import '../../shared/widgets/awhar_map_widget.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class StoreLocationScreen extends StatefulWidget {
  const StoreLocationScreen({super.key});

  @override
  State<StoreLocationScreen> createState() => _StoreLocationScreenState();
}

class _StoreLocationScreenState extends State<StoreLocationScreen> {
  final StoreController storeController = Get.find<StoreController>();
  late final MapController mapController;
  final LocationService locationService = Get.find<LocationService>();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  LatLng? _selectedLatLng;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    // Ensure MapController exists for this screen
    mapController = Get.put(MapController());

    // Pre-fill from current store
    final store = storeController.myStore.value;
    if (store != null) {
      addressController.text = store.address;
      cityController.text = store.city ?? '';
      _selectedLatLng = LatLng(store.latitude, store.longitude);

      // Delay to allow map to be created before moving camera/markers
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _ensureMapReady();
        await _showStoreMarker(_selectedLatLng!);
      });
    }
  }

  Future<void> _ensureMapReady() async {
    if (_initialised) return;
    // Wait until onMapCreated sets the controller
    int attempts = 0;
    while (!mapController.isMapReady.value && attempts < 30) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }
    _initialised = true;
  }

  Future<void> _showStoreMarker(LatLng position) async {
    // Clear previous marker and add the store marker
    mapController.removeMarker('store');
    mapController.addMarker(
      id: 'store',
      position: position,
      title: 'Store Location',
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      draggable: true,
    );
    await mapController.moveCamera(position, zoom: 16);

    // Update address fields from geocoding
    final address = await locationService.getAddressFromCoordinates(position);
    if (address != null) {
      addressController.text = address;
    }
    _selectedLatLng = position;
  }

  Future<void> _useCurrentLocation() async {
    final pos = await locationService.getCurrentPosition();
    if (pos == null) return;
    final latLng = LatLng(pos.latitude, pos.longitude);
    await _showStoreMarker(latLng);
  }

  Future<void> _searchAddress() async {
    final query = searchController.text.trim();
    if (query.isEmpty) return;
    final coords = await locationService.getCoordinatesFromAddress(query);
    if (coords != null) {
      await _showStoreMarker(coords);
    } else {
      Get.snackbar('common.error'.tr, 'validation.email_invalid'.tr);
    }
  }

  Future<void> _saveLocation(AppColorScheme colors) async {
    final store = storeController.myStore.value;
    if (store == null || _selectedLatLng == null) return;

    final success = await storeController.updateStore(
      address: addressController.text.trim(),
      city: cityController.text.trim().isEmpty ? null : cityController.text.trim(),
      latitude: _selectedLatLng!.latitude,
      longitude: _selectedLatLng!.longitude,
    );

    if (success) {
      Get.back();
      Get.snackbar(
        'common.success'.tr,
        'store_management.update_store_success'.tr,
        backgroundColor: colors.success,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    final store = storeController.myStore.value;
    final initialCamera = (store != null)
        ? CameraPosition(target: LatLng(store.latitude, store.longitude), zoom: 14)
        : const CameraPosition(target: LatLng(33.5731, -7.5898), zoom: 12); // Casablanca

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('store_detail.location'.tr),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.gps),
            onPressed: _useCurrentLocation,
            tooltip: 'navigation.to_pickup'.tr,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'navigation.to_delivery'.tr,
                      prefixIcon: Icon(Iconsax.search_normal_1, color: colors.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      filled: true,
                      fillColor: colors.surface,
                    ),
                    onSubmitted: (_) => _searchAddress(),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: _searchAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('common.search'.tr),
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            child: AwharMapWidget(
              controller: mapController,
              initialPosition: initialCamera,
              borderRadius: 0,
              onTap: (latLng) async {
                await _showStoreMarker(latLng);
              },
              onLongPress: (latLng) async {
                await _showStoreMarker(latLng);
              },
            ),
          ),

          // Address + Save
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.border, width: 1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('store_management.store_address'.tr, style: AppTypography.labelMedium(context)),
                SizedBox(height: 8.h),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.location, color: colors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    filled: true,
                    fillColor: colors.background,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'store_detail.location'.tr,
                    prefixIcon: Icon(Iconsax.building, color: colors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    filled: true,
                    fillColor: colors.background,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('common.cancel'.tr),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _saveLocation(colors),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('common.save'.tr),
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

  @override
  void dispose() {
    searchController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
