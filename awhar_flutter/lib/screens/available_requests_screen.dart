import 'dart:async';
import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/request_controller.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:awhar_flutter/screens/driver_request_details_screen.dart';
import 'package:awhar_flutter/core/services/trust_score_service.dart';
import 'package:awhar_flutter/shared/widgets/trust_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Screen for drivers to view and accept nearby service requests
class AvailableRequestsScreen extends StatefulWidget {
  const AvailableRequestsScreen({super.key});

  @override
  State<AvailableRequestsScreen> createState() =>
      _AvailableRequestsScreenState();
}

class _AvailableRequestsScreenState extends State<AvailableRequestsScreen> {
  final RequestController controller = Get.find<RequestController>();
  final TrustScoreService _trustService = Get.find<TrustScoreService>();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    // Load requests after the first frame to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadNearbyRequests();
    });

    // Auto-refresh every 10 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        controller.loadNearbyRequests();
      }
    });

    // Listen for errors
    ever(controller.errorMessage, (String message) {
      if (message.isNotEmpty && mounted) {
        Get.snackbar(
          'common.error'.tr,
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Iconsax.info_circle, color: Colors.white),
          duration: const Duration(seconds: 4),
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
        );
        controller.clearError();
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Deliveries',
              style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
            ),
            Obx(() => Row(
              children: [
                Text(
                  '${controller.nearbyRequests.length} requests nearby',
                  style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary, fontSize: 11.sp),
                ),
                if (controller.driverCity.value.isNotEmpty) ...[
                  Text(' • ', style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      controller.driverCity.value,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.primary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            )),
          ],
        ),
        actions: [
          Obx(() => IconButton(
            icon: controller.isLoading.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      color: colors.primary,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Iconsax.refresh, color: colors.primary),
            onPressed: controller.isLoading.value ? null : () => controller.loadNearbyRequests(),
          )),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          if (controller.nearbyRequests.isEmpty) {
            return _buildEmptyState(colors);
          }

          return RefreshIndicator(
            onRefresh: () => controller.loadNearbyRequests(),
            color: colors.primary,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: controller.nearbyRequests.length,
              itemBuilder: (context, index) {
                final request = controller.nearbyRequests[index];
                return _buildRequestCard(colors, request);
              },
            ),
          );
        },
      ),
    );
  }

  /// Build empty state when no requests available
  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.search_status,
            size: 80.sp,
            color: colors.textSecondary,
          ),
          SizedBox(height: 24.h),
          Text(
            'No requests available',
            style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 12.h),
          Text(
            'Pull down to refresh',
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () => controller.loadNearbyRequests(),
            icon: const Icon(Iconsax.refresh, color: Colors.white),
            label: Text('Refresh', style: AppTypography.bodyMedium(context).copyWith(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build request card
  Widget _buildRequestCard(AppColorScheme colors, ServiceRequest request) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DriverRequestDetailsScreen(request: request));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
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
          // Header with service type and client's offered price
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
                _getServiceIcon(request.serviceType, colors),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getServiceLabel(request.serviceType),
                        style: AppTypography.titleMedium(context).copyWith(color: colors.primary),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              request.clientName,
                              style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          // Trust badge inline
                          FutureBuilder<TrustScoreResult?>(
                            future: _trustService.getTrustScore(request.clientId),
                            builder: (context, snap) {
                              if (!snap.hasData || snap.data == null) return const SizedBox.shrink();
                              return TrustBadge(
                                trustScore: snap.data!.trustScore,
                                trustLevel: snap.data!.trustLevel,
                                size: TrustBadgeSize.small,
                                showLabel: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Show client's offered price prominently
                    if (request.clientOfferedPrice != null) ...[
                      Text(
                        'negotiation.client_offers'.tr,
                        style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary, fontSize: 10.sp),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(request.clientOfferedPrice!, request.currencySymbol),
                        style: AppTypography.headlineMedium(context).copyWith(color: colors.primary, fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      Text(
                        CurrencyHelper.formatWithSymbol(request.totalPrice, request.currencySymbol),
                        style: AppTypography.titleLarge(context).copyWith(color: colors.primary),
                      ),
                    ],
                    Text(
                      '${request.distance?.toStringAsFixed(1) ?? "--"} km',
                      style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Purchase Indicator (for purchase/task types)
          if (request.serviceType == ServiceType.purchase || request.serviceType == ServiceType.task) ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.warning.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: colors.warning.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Iconsax.bag_2, color: colors.warning, size: 18.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.serviceType == ServiceType.purchase ? 'driver.purchase_required'.tr : 'driver.task_required'.tr,
                          style: AppTypography.titleSmall(context).copyWith(
                            color: colors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (request.estimatedPurchaseCost != null && request.estimatedPurchaseCost! > 0) ...[
                          Text(
                            '${'driver.estimated_cost'.tr}: ${CurrencyHelper.formatWithSymbol(request.estimatedPurchaseCost!, request.currencySymbol)}',
                            style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                          ),
                        ],
                        if (request.itemDescription != null && request.itemDescription!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            request.itemDescription!,
                            style: AppTypography.bodySmall(context).copyWith(color: colors.textPrimary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Pickup location (or flexible indicator)
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, request.serviceType == ServiceType.purchase || request.serviceType == ServiceType.task ? 0 : 16.h, 16.w, 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.location, color: colors.primary, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.pickupLocation != null ? 'Pickup' : 'driver.flexible_pickup'.tr,
                        style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                      ),
                      if (request.pickupLocation != null)
                        Text(
                          request.pickupLocation!.placeName ??
                              request.pickupLocation!.address ??
                              'Pickup location',
                          style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      else
                        Row(
                          children: [
                            Icon(Iconsax.location, size: 14.sp, color: colors.primary),
                            SizedBox(width: 4.w),
                            Text(
                              'driver.anywhere_nearby'.tr,
                              style: AppTypography.bodyMedium(context).copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Destination
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.location_tick,
                    color: colors.success, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destination',
                        style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                      ),
                      Text(
                        request.destinationLocation.placeName ??
                            request.destinationLocation.address ??
                            'Destination',
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Notes if available
          if (request.notes != null && request.notes!.isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Iconsax.note,
                        color: colors.textSecondary, size: 16.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        request.notes!,
                        style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Action buttons - Phase 3: Negotiation flow
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Column(
              children: [
                // Accept Client's Price button (green)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final confirmed = await _showAcceptClientPriceDialog(colors, request);
                      if (confirmed == true) {
                        final success = await controller.acceptRequest(request.id!);
                        if (success) {
                          // Show waiting for client approval dialog
                          Get.back(); // Close request details
                          _showWaitingForApprovalDialog(colors, request);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
                        SizedBox(width: 8.w),
                        Text(
                          'negotiation.accept_client_price'.tr,
                          style: AppTypography.labelLarge(context).copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Make Offer button (blue)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO Phase 3.3: Show counter-offer dialog
                      Get.snackbar(
                        'common.info'.tr,
                        'Counter-offer feature coming soon',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: colors.info,
                        colorText: Colors.white,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.money_send, color: colors.primary, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'negotiation.send_counter_offer'.tr,
                          style: AppTypography.labelLarge(context).copyWith(color: colors.primary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  /// Show accept client's price confirmation dialog
  Future<bool?> _showAcceptClientPriceDialog(AppColorScheme colors, ServiceRequest request) {
    final clientPrice = request.clientOfferedPrice ?? request.totalPrice;
    final commission = clientPrice * 0.05; // 5% commission
    final earnings = clientPrice - commission;

    return Get.dialog<bool>(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Iconsax.info_circle_copy, color: colors.success, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'negotiation.accept_client_price'.tr,
                style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accept client\'s offer of ${CurrencyHelper.formatWithSymbol(clientPrice, request.currencySymbol)}?',
              style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Client Offer:',
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(clientPrice, request.currencySymbol),
                        style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Commission (5%):',
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                      ),
                      Text(
                        '-${CurrencyHelper.formatWithSymbol(commission, request.currencySymbol)}',
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.error),
                      ),
                    ],
                  ),
                  Divider(color: colors.border, height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'negotiation.your_earnings'.tr,
                        style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        CurrencyHelper.formatWithSymbol(earnings, request.currencySymbol),
                        style: AppTypography.titleLarge(context).copyWith(color: colors.success, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'common.cancel'.tr,
              style: AppTypography.labelLarge(context).copyWith(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text(
              'common.confirm'.tr,
              style: AppTypography.labelLarge(context).copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Get service type icon
  Widget _getServiceIcon(ServiceType type, AppColorScheme colors) {
    IconData icon;
    switch (type) {
      case ServiceType.ride:
        icon = Iconsax.car;
        break;
      case ServiceType.delivery:
        icon = Iconsax.box;
        break;
      case ServiceType.purchase:
        icon = Iconsax.bag_2;
        break;
      case ServiceType.task:
        icon = Iconsax.task;
        break;
      case ServiceType.moving:
        icon = Iconsax.truck_fast;
        break;
      case ServiceType.other:
        icon = Iconsax.element_3;
        break;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: Colors.white, size: 24.sp),
    );
  }

  /// Get service type label
  String _getServiceLabel(ServiceType type) {
    switch (type) {
      case ServiceType.ride:
        return 'Ride';
      case ServiceType.delivery:
        return 'Delivery';
      case ServiceType.purchase:
        return 'Purchase';
      case ServiceType.task:
        return 'Task';
      case ServiceType.moving:
        return 'Moving';
      case ServiceType.other:
        return 'Other';
    }
  }

  /// Show accept confirmation dialog
  Future<bool?> _showAcceptDialog(AppColorScheme colors) {
    return Get.dialog<bool>(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Accept Request?',
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to accept this request? You will be responsible for completing this service.',
          style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel', style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text('Accept', style: AppTypography.bodyMedium(context).copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Show waiting for client approval dialog after driver accepts
  Future<void> _showWaitingForApprovalDialog(AppColorScheme colors, ServiceRequest request) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated waiting icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.8 + (value * 0.2),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Iconsax.clock,
                          size: 48.sp,
                          color: colors.primary,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                
                // Title
                Text(
                  'Proposal Sent!',
                  style: AppTypography.headlineMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                
                // Message
                Text(
                  'Your proposal has been sent to the client. They will review and respond shortly.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                
                // Estimated time
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: colors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Usually responds within 2 minutes',
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.info,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Request details
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.location, color: colors.primary, size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.pickupLocation?.placeName ?? 
                                  request.pickupLocation?.address ?? 
                                  'Pickup Location',
                              style: AppTypography.bodyMedium(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (request.clientName.isNotEmpty) ...[
                              SizedBox(height: 4.h),
                              Text(
                                'Client: ${request.clientName}',
                                style: AppTypography.bodySmall(context).copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          // Cancel proposal
                          final confirmed = await Get.dialog<bool>(
                            AlertDialog(
                              title: const Text('Cancel Proposal?'),
                              content: const Text('Are you sure you want to cancel this proposal?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                          
                          if (confirmed == true) {
                            Get.back(); // Close waiting dialog
                            controller.loadNearbyRequests(); // Refresh list
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          'Cancel Proposal',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back(); // Just close and return to requests list
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          'OK',
                          style: AppTypography.bodyMedium(context).copyWith(
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
        ),
      ),
    );
  }
}
