import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/controllers/request_controller.dart';
import '../core/utils/currency_helper.dart';

class DriverMyOffersScreen extends StatefulWidget {
  const DriverMyOffersScreen({super.key});

  @override
  State<DriverMyOffersScreen> createState() => _DriverMyOffersScreenState();
}

class _DriverMyOffersScreenState extends State<DriverMyOffersScreen> {
  final controller = Get.find<RequestController>();

  @override
  void initState() {
    super.initState();
    // TODO: Load driver's offers
    // controller.loadMyOffers();
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
          icon: Icon(Iconsax.arrow_left_copy, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'negotiation.my_offers'.tr,
          style: AppTypography.titleLarge(context)
              .copyWith(color: colors.textPrimary),
        ),
      ),
      body: Obx(() {
        // TODO: Get actual offers from controller
        // For now, showing placeholder
        final hasOffers = false;

        if (hasOffers) {
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: 0, // TODO: Replace with actual offers count
            itemBuilder: (context, index) {
              // TODO: Replace with actual offer data
              return _buildOfferCard(colors, null);
            },
          );
        } else {
          return _buildEmptyState(colors);
        }
      }),
    );
  }

  Widget _buildOfferCard(AppColorScheme colors, dynamic offer) {
    // TODO: Implement with actual offer data
    // Placeholder data for UI demonstration
    // final request = ServiceRequest(
    //   id: 1,
    //   clientId: 123,
    //   serviceType: ServiceType.delivery,
    //   pickupLocation: Location(
    //     latitude: 33.5731,
    //     longitude: -7.5898,
    //     address: 'Pickup Location',
    //   ),
    //   destinationLocation: Location(
    //     latitude: 33.5731,
    //     longitude: -7.5898,
    //     address: 'Destination',
    //   ),
    //   basePrice: 15.0,
    //   distancePrice: 135.0,
    //   totalPrice: 150.0,
    //   distance: 5.5,
    //   estimatedDuration: 20,
    //   clientName: 'Client Name',
    //   status: RequestStatus.pending,
    //   createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    // );

    final clientPrice = 150.0;
    final counterPrice = 180.0;
    final status = 'waiting'; // waiting, accepted, rejected

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _getStatusColor(status, colors).withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(status),
                  color: _getStatusColor(status, colors),
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _getStatusLabel(status),
                    style: AppTypography.labelLarge(context).copyWith(
                      color: _getStatusColor(status, colors),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '2h ago', // TODO: Calculate time difference
                  style: AppTypography.labelSmall(context)
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service type
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(Iconsax.box_copy, color: colors.primary, size: 18.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'DELIVERY', // TODO: Get from request
                        style: AppTypography.titleMedium(context)
                            .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Price comparison
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow(
                        colors,
                        'negotiation.client_offers'.tr,
                        clientPrice,
                        colors.textSecondary,
                      ),
                      SizedBox(height: 8.h),
                      _buildPriceRow(
                        colors,
                        'negotiation.your_counter_offer'.tr,
                        counterPrice,
                        colors.primary,
                        isBold: true,
                      ),
                      SizedBox(height: 8.h),
                      Divider(color: colors.border),
                      SizedBox(height: 8.h),
                      _buildPriceRow(
                        colors,
                        'negotiation.price_difference'.tr,
                        counterPrice - clientPrice,
                        counterPrice > clientPrice ? colors.error : colors.success,
                        showSign: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Estimated earnings
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.success.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.success.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.wallet_money_copy, color: colors.success, size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'negotiation.your_earnings'.tr,
                              style: AppTypography.labelSmall(context)
                                  .copyWith(color: colors.textSecondary),
                            ),
                            Text(
                              CurrencyHelper.format(counterPrice * 0.95),
                              style: AppTypography.titleMedium(context).copyWith(
                                color: colors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'negotiation.after_commission'.tr,
                        style: AppTypography.labelSmall(context)
                            .copyWith(color: colors.textSecondary, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),

                // Action buttons based on status
                if (status == 'waiting') ...[
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showCancelOfferDialog(colors);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.error,
                        side: BorderSide(color: colors.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: Icon(Iconsax.close_circle_copy, size: 18.sp),
                      label: Text(
                        'negotiation.cancel_offer'.tr,
                        style: AppTypography.labelLarge(context)
                            .copyWith(color: colors.error),
                      ),
                    ),
                  ),
                ] else if (status == 'accepted') ...[
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to active request
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.success,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: Icon(Iconsax.play_circle_copy, size: 18.sp),
                      label: Text(
                        'home.start_service'.tr,
                        style: AppTypography.labelLarge(context)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    AppColorScheme colors,
    String label,
    double amount,
    Color valueColor, {
    bool isBold = false,
    bool showSign = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          '${showSign && amount > 0 ? '+' : ''}${CurrencyHelper.format(amount)}',
          style: AppTypography.bodyMedium(context).copyWith(
            color: valueColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.document_text_copy,
                color: colors.primary,
                size: 64.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Offers Yet',
              style: AppTypography.titleLarge(context)
                  .copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'You haven\'t sent any counter-offers yet.\nBrowse available requests to get started!',
              style: AppTypography.bodyMedium(context)
                  .copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Iconsax.search_normal_copy, size: 20.sp),
              label: Text(
                'Browse Requests',
                style: AppTypography.labelLarge(context)
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status, AppColorScheme colors) {
    switch (status) {
      case 'waiting':
        return colors.warning;
      case 'accepted':
        return colors.success;
      case 'rejected':
        return colors.error;
      default:
        return colors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'waiting':
        return Iconsax.clock_copy;
      case 'accepted':
        return Iconsax.tick_circle_copy;
      case 'rejected':
        return Iconsax.close_circle_copy;
      default:
        return Iconsax.info_circle_copy;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'waiting':
        return 'negotiation.waiting_client_response'.tr;
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'negotiation.offer_rejected_info'.tr;
      default:
        return 'Unknown';
    }
  }

  void _showCancelOfferDialog(AppColorScheme colors) {
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'negotiation.cancel_offer'.tr,
          style: AppTypography.titleLarge(context)
              .copyWith(color: colors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to cancel this offer? This action cannot be undone.',
          style: AppTypography.bodyMedium(context)
              .copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.no'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // TODO: Call backend to cancel offer
              Get.snackbar(
                'common.success'.tr,
                'Offer cancelled successfully',
                backgroundColor: colors.success,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'common.yes'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
