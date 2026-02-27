import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_order_controller.dart';

/// Find Driver Screen
/// Allows store to find and request nearby drivers for delivery
class FindDriverScreen extends StatefulWidget {
  final int orderId;

  const FindDriverScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<FindDriverScreen> createState() => _FindDriverScreenState();
}

class _FindDriverScreenState extends State<FindDriverScreen> {
  late final StoreOrderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<StoreOrderController>();
    _controller.loadNearbyDrivers(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'Find Driver',
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.primary),
            onPressed: () => _controller.loadNearbyDrivers(widget.orderId),
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick broadcast option
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary, colors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.flash, color: Colors.white, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Quick Broadcast',
                      style: AppTypography.titleMedium(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Send delivery request to all nearby drivers at once. First driver to accept gets the order.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: _controller.isProcessing.value
                        ? null
                        : () => _broadcastRequest(context),
                    icon: _controller.isProcessing.value
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Icon(Iconsax.send_2),
                    label: Text(
                      _controller.isProcessing.value
                          ? 'Sending...'
                          : 'Broadcast to All',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colors.primary,
                      minimumSize: Size(double.infinity, 44.h),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider with "OR"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Divider(color: colors.textSecondary.withOpacity(0.3)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: colors.textSecondary.withOpacity(0.3)),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(
                  Iconsax.user_search,
                  size: 20.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Select a specific driver',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Drivers list
          Expanded(
            child: Obx(() {
              if (_controller.isLoadingDrivers.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_controller.nearbyDrivers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.car,
                        size: 64.sp,
                        color: colors.textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No drivers available nearby',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextButton.icon(
                        onPressed: () =>
                            _controller.loadNearbyDrivers(widget.orderId),
                        icon: const Icon(Iconsax.refresh),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: _controller.nearbyDrivers.length,
                itemBuilder: (context, index) {
                  final nearbyDriver = _controller.nearbyDrivers[index];
                  return _DriverCard(
                    nearbyDriver: nearbyDriver,
                    colors: colors,
                    onRequest: () =>
                        _requestDriver(context, nearbyDriver.driver.id!),
                    isProcessing: _controller.isProcessing.value,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _broadcastRequest(BuildContext context) async {
    final success = await _controller.postDeliveryRequest(widget.orderId);
    if (success) {
      Get.back();
      Get.snackbar(
        'Request Sent',
        'Waiting for a driver to accept',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        _controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _requestDriver(BuildContext context, int driverId) async {
    final success = await _controller.requestDriver(widget.orderId, driverId);
    if (success) {
      Get.back();
      Get.snackbar(
        'Request Sent',
        'Waiting for driver response',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        _controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class _DriverCard extends StatelessWidget {
  final NearbyDriver nearbyDriver;
  final dynamic colors;
  final VoidCallback onRequest;
  final bool isProcessing;

  const _DriverCard({
    required this.nearbyDriver,
    required this.colors,
    required this.onRequest,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    final driver = nearbyDriver.driver;
    final hasReviews = (driver.ratingCount ?? 0) > 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Driver avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: colors.primary.withOpacity(0.1),
                backgroundImage: driver.profilePhotoUrl != null
                    ? CachedNetworkImageProvider(driver.profilePhotoUrl!)
                    : null,
                child: driver.profilePhotoUrl == null
                    ? Icon(Iconsax.user, color: colors.primary, size: 28.sp)
                    : null,
              ),
              // Live location indicator
              if (nearbyDriver.hasLiveLocation)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),

          // Driver info - Name, reviews, distance
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.displayName ?? 'Driver',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),

                // Reviews row
                Row(
                  children: [
                    Icon(
                      Iconsax.star_1,
                      size: 14.sp,
                      color: hasReviews ? Colors.amber : colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      hasReviews
                          ? '${driver.ratingAverage?.toStringAsFixed(1) ?? '0.0'} (${driver.ratingCount} reviews)'
                          : 'No reviews yet',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12.sp,
                        fontStyle: hasReviews
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Distance row
                Row(
                  children: [
                    Icon(
                      nearbyDriver.hasLiveLocation
                          ? Iconsax.location
                          : Iconsax.location_slash,
                      size: 14.sp,
                      color: nearbyDriver.hasLiveLocation
                          ? colors.primary
                          : colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      nearbyDriver.distanceKm != null
                          ? '${nearbyDriver.distanceKm!.toStringAsFixed(1)} km away'
                          : 'Location unavailable',
                      style: TextStyle(
                        color: nearbyDriver.hasLiveLocation
                            ? colors.primary
                            : colors.textSecondary,
                        fontSize: 12.sp,
                        fontWeight: nearbyDriver.hasLiveLocation
                            ? FontWeight.w500
                            : FontWeight.normal,
                        fontStyle: nearbyDriver.hasLiveLocation
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Request button
          ElevatedButton(
            onPressed: isProcessing ? null : onRequest,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            child: const Text('Request'),
          ),
        ],
      ),
    );
  }
}
