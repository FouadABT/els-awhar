import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/controllers/request_controller.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/currency_helper.dart';

class DriverOfferReviewScreen extends StatelessWidget {
  final dynamic request;

  const DriverOfferReviewScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final controller = Get.find<RequestController>();

    final clientPrice = request.clientOfferedPrice ?? 0.0;
    final driverPrice = request.driverCounterPrice ?? 0.0;
    final difference = driverPrice - clientPrice;

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
          'negotiation.driver_offer'.tr,
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver Info Card
            _buildDriverInfoCard(context, colors),
            SizedBox(height: 24.h),

            // Price Comparison Card
            _buildPriceComparisonCard(
              context,
              clientPrice,
              driverPrice,
              difference,
              colors,
            ),
            SizedBox(height: 24.h),

            // Service Details Card
            _buildServiceDetailsCard(context, colors),
            SizedBox(height: 24.h),

            // Action Buttons
            _buildActionButtons(context, controller, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfoCard(BuildContext context, AppColorScheme colors) {
    // Placeholder driver data - in real app, fetch from backend
    final driverName = 'Mohamed Alami';
    final driverRating = 4.8;
    final totalTrips = 342;

    return Card(
      color: colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            // Driver Avatar
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary.withOpacity(0.1),
                border: Border.all(color: colors.primary, width: 2),
              ),
              child: Icon(
                Iconsax.user_copy,
                size: 32.sp,
                color: colors.primary,
              ),
            ),
            SizedBox(width: 16.w),

            // Driver Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName,
                    style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star_1_copy,
                        size: 16.sp,
                        color: colors.warning,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        driverRating.toStringAsFixed(1),
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '•',
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textMuted),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '$totalTrips trips',
                        style: AppTypography.bodyMedium(
                          context,
                        ).copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.verify_copy,
                        size: 14.sp,
                        color: colors.success,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'profile.verified'.tr,
                        style: AppTypography.labelSmall(context).copyWith(color: colors.success),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceComparisonCard(
    BuildContext context,
    double clientPrice,
    double driverPrice,
    double difference,
    AppColorScheme colors,
  ) {
    final isHigher = difference > 0;
    final diffColor = isHigher ? colors.error : colors.success;

    return Card(
      color: colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'negotiation.driver_counter_offer'.tr,
              style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
            ),
            SizedBox(height: 16.h),

            // Your Posted Price
            _buildPriceRow(
              context,
              'negotiation.your_posted_price'.tr,
              clientPrice,
              colors.textSecondary,
              colors,
            ),
            SizedBox(height: 12.h),

            // Driver's Counter Offer
            _buildPriceRow(
              context,
              'negotiation.driver_counter_offer'.tr,
              driverPrice,
              colors.primary,
              colors,
              isHighlighted: true,
            ),
            SizedBox(height: 12.h),

            // Divider
            Divider(color: colors.border),
            SizedBox(height: 12.h),

            // Price Difference
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'negotiation.price_difference'.tr.replaceAll(
                    '{amount}',
                    difference.abs().toStringAsFixed(0),
                  ),
                  style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: diffColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: diffColor),
                  ),
                  child: Text(
                    '${isHigher ? '+' : ''}${CurrencyHelper.formatWithSymbol(difference.abs(), request.currencySymbol ?? CurrencyHelper.symbol)}',
                    style: AppTypography.labelLarge(context).copyWith(color: diffColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    double price,
    Color labelColor,
    AppColorScheme colors, {
    bool isHighlighted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium(context).copyWith(color: labelColor),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: isHighlighted
              ? BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: colors.primary, width: 2),
                )
              : null,
          child: Text(
            CurrencyHelper.formatWithSymbol(price, request.currencySymbol ?? CurrencyHelper.symbol),
            style: AppTypography.titleMedium(
              context,
            ).copyWith(color: isHighlighted ? colors.primary : colors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDetailsCard(BuildContext context, AppColorScheme colors) {
    final serviceTypeKey =
        'service_type.${request.serviceType.toString().split('.').last}';

    return Card(
      color: colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Details',
              style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
            ),
            SizedBox(height: 16.h),

            // Service Type
            _buildDetailRow(
              context,
              Iconsax.category_copy,
              'request.select_service_type'.tr,
              serviceTypeKey.tr,
              colors,
            ),
            SizedBox(height: 12.h),

            // Pickup Location
            _buildDetailRow(
              context,
              Iconsax.location_copy,
              'request.pickup_location'.tr,
              request.pickupAddress ?? 'N/A',
              colors,
            ),
            SizedBox(height: 12.h),

            // Destination
            _buildDetailRow(
              context,
              Iconsax.location_tick_copy,
              'request.destination'.tr,
              request.destinationAddress ?? 'N/A',
              colors,
            ),

            // Additional Notes (if any)
            if (request.notes != null && request.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildDetailRow(
                context,
                Iconsax.note_copy,
                'request.additional_notes'.tr,
                request.notes!,
                colors,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    AppColorScheme colors,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: colors.textSecondary),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall(context).copyWith(color: colors.textMuted),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    RequestController controller,
    AppColorScheme colors,
  ) {
    return Column(
      children: [
        // Accept Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => _showAcceptConfirmation(context, controller, colors),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.tick_circle_copy, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'negotiation.accept_offer'.tr,
                  style: AppTypography.labelLarge(context).copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Reject Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: OutlinedButton(
            onPressed: () => _showRejectConfirmation(context, controller, colors),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.error, width: 2),
              foregroundColor: colors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.close_circle_copy, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'negotiation.reject_offer'.tr,
                  style: AppTypography.labelLarge(context).copyWith(color: colors.error),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Negotiate via Chat Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: TextButton(
            onPressed: () {
              // TODO: Navigate to chat
              Get.snackbar(
                'common.info'.tr,
                'Chat feature coming soon',
                backgroundColor: colors.info,
                colorText: Colors.white,
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.message_copy, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'negotiation.negotiate_chat'.tr,
                  style: AppTypography.labelLarge(context).copyWith(color: colors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAcceptConfirmation(
    BuildContext context,
    RequestController controller,
    AppColorScheme colors,
  ) {
    final driverPrice = request.driverCounterPrice ?? 0.0;

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Iconsax.info_circle_copy, color: colors.success, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'negotiation.confirm_accept_title'.tr,
              style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
            ),
          ],
        ),
        content: Text(
          'negotiation.confirm_accept_message'.tr.replaceAll(
            '{price}',
            driverPrice.toStringAsFixed(0),
          ),
          style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr,
              style: AppTypography.labelLarge(context).copyWith(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              await _acceptOffer(controller, colors);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
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

  void _showRejectConfirmation(
    BuildContext context,
    RequestController controller,
    AppColorScheme colors,
  ) {
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Iconsax.warning_2_copy, color: colors.error, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'negotiation.confirm_reject_title'.tr,
              style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
            ),
          ],
        ),
        content: Text(
          'negotiation.confirm_reject_message'.tr,
          style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr,
              style: AppTypography.labelLarge(context).copyWith(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              await _rejectOffer(controller, colors);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
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

  Future<void> _acceptOffer(
    RequestController controller,
    AppColorScheme colors,
  ) async {
    // TODO: Get proposal ID from request
    // For now, placeholder
    final proposalId = 0; // Need to get actual proposal ID

    Get.dialog(
      Center(child: CircularProgressIndicator(color: colors.primary)),
      barrierDismissible: false,
    );

    try {
      // Call controller method to accept proposal
      await controller.acceptProposal(proposalId);

      Get.back(); // Close loading
      Get.back(); // Close offer review screen
      Get.back(); // Close pending requests screen

      Get.snackbar(
        'common.success'.tr,
        'negotiation.offer_accepted'.tr,
        backgroundColor: colors.success,
        colorText: Colors.white,
        icon: Icon(Iconsax.tick_circle_copy, color: Colors.white),
        duration: const Duration(seconds: 3),
      );

      // Navigate to active request screen
      // TODO: Navigate to active request tracking
    } catch (e) {
      Get.back(); // Close loading
      Get.snackbar(
        'common.error'.tr,
        'negotiation.failed_accept_proposal'.tr,
        backgroundColor: colors.error,
        colorText: Colors.white,
        icon: Icon(Iconsax.close_circle_copy, color: Colors.white),
      );
    }
  }

  Future<void> _rejectOffer(
    RequestController controller,
    AppColorScheme colors,
  ) async {
    final proposalId = 0; // Need to get actual proposal ID

    Get.dialog(
      Center(child: CircularProgressIndicator(color: colors.primary)),
      barrierDismissible: false,
    );

    try {
      await controller.rejectProposal(proposalId);

      Get.back(); // Close loading
      Get.back(); // Close offer review screen

      Get.snackbar(
        'common.info'.tr,
        'negotiation.offer_rejected'.tr,
        backgroundColor: colors.warning,
        colorText: Colors.white,
        icon: Icon(Iconsax.info_circle_copy, color: Colors.white),
      );
    } catch (e) {
      Get.back(); // Close loading
      Get.snackbar(
        'common.error'.tr,
        'negotiation.failed_reject_proposal'.tr,
        backgroundColor: colors.error,
        colorText: Colors.white,
        icon: Icon(Iconsax.close_circle_copy, color: Colors.white),
      );
    }
  }
}
