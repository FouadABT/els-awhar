import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/controllers/rating_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Rating dialog widget for rating users after service completion
class RatingDialog extends StatelessWidget {
  final int userId;
  final int requestId;
  final int ratedUserId;
  final String ratedUserName;
  final String? ratedUserPhoto;
  final RatingType ratingType;
  final VoidCallback? onRatingSubmitted;

  const RatingDialog({
    super.key,
    required this.userId,
    required this.requestId,
    required this.ratedUserId,
    required this.ratedUserName,
    this.ratedUserPhoto,
    required this.ratingType,
    this.onRatingSubmitted,
  });

  /// Show the rating dialog
  static Future<bool?> show({
    required BuildContext context,
    required int userId,
    required int requestId,
    required int ratedUserId,
    required String ratedUserName,
    String? ratedUserPhoto,
    required RatingType ratingType,
    VoidCallback? onRatingSubmitted,
  }) {
    // Register controller if not already
    if (!Get.isRegistered<RatingController>()) {
      Get.put(RatingController());
    }
    Get.find<RatingController>().resetRatingState();

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => RatingDialog(
        userId: userId,
        requestId: requestId,
        ratedUserId: ratedUserId,
        ratedUserName: ratedUserName,
        ratedUserPhoto: ratedUserPhoto,
        ratingType: ratingType,
        onRatingSubmitted: onRatingSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final controller = Get.find<RatingController>();
    final isRatingDriver = ratingType == RatingType.client_to_driver;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        constraints: BoxConstraints(
          maxWidth: 400.w,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, colors, controller),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h),

                    // User Avatar and Name
                    _buildUserInfo(context, colors),
                    SizedBox(height: 16.h),

                    // Star Rating
                    _buildStarRating(context, colors, controller),
                    SizedBox(height: 12.h),

                    // Rating Label
                    Obx(() => _buildRatingLabel(context, colors, controller)),
                    SizedBox(height: 14.h),

                    // Quick Tags
                    _buildQuickTags(
                      context,
                      colors,
                      controller,
                      isRatingDriver,
                    ),
                    SizedBox(height: 12.h),

                    // Review Text Field
                    _buildReviewField(context, colors, controller),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Submit Button (always visible at bottom)
            _buildSubmitButton(context, colors, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'rating.title'.tr,
            style:
                AppTypography.titleLarge(
                  context,
                ).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: () => Navigator.of(context).pop(false),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Iconsax.close_circle,
            color: colors.textMuted,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        // User Avatar
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.primary, width: 2.5),
          ),
          child: ClipOval(
            child: ratedUserPhoto != null && ratedUserPhoto!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: ratedUserPhoto!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: colors.surfaceElevated,
                      child: Icon(
                        Iconsax.user,
                        size: 28.sp,
                        color: colors.textMuted,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: colors.surfaceElevated,
                      child: Icon(
                        Iconsax.user,
                        size: 28.sp,
                        color: colors.textMuted,
                      ),
                    ),
                  )
                : Container(
                    color: colors.surfaceElevated,
                    child: Icon(
                      Iconsax.user,
                      size: 28.sp,
                      color: colors.textMuted,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          ratedUserName,
          style:
              AppTypography.titleMedium(
                context,
              ).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Text(
          ratingType == RatingType.client_to_driver
              ? 'rating.rate_your_driver'.tr
              : 'rating.rate_your_client'.tr,
          style: AppTypography.bodySmall(
            context,
          ).copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStarRating(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
  ) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final starValue = index + 1;
          final isSelected = controller.currentRating.value >= starValue;
          return GestureDetector(
            onTap: () => controller.setRating(starValue),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Icon(
                isSelected ? Iconsax.star_1 : Iconsax.star,
                size: 32.sp,
                color: isSelected ? colors.warning : colors.border,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRatingLabel(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
  ) {
    String label;
    switch (controller.currentRating.value) {
      case 1:
        label = 'rating.label.terrible'.tr;
        break;
      case 2:
        label = 'rating.label.bad'.tr;
        break;
      case 3:
        label = 'rating.label.okay'.tr;
        break;
      case 4:
        label = 'rating.label.good'.tr;
        break;
      case 5:
        label = 'rating.label.excellent'.tr;
        break;
      default:
        label = 'rating.tap_to_rate'.tr;
    }
    return Text(
      label,
      style: AppTypography.bodyLarge(context).copyWith(
        color: controller.currentRating.value > 0
            ? colors.primary
            : colors.textMuted,
      ),
    );
  }

  Widget _buildQuickTags(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
    bool isRatingDriver,
  ) {
    final tags = controller.getQuickTags(isRatingDriver: isRatingDriver);

    return Obx(
      () => Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        alignment: WrapAlignment.center,
        children: tags.map((tag) {
          final isSelected = controller.selectedQuickTags.contains(tag);
          return GestureDetector(
            onTap: () => controller.toggleQuickTag(tag),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : colors.surfaceElevated,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? colors.primary : colors.border,
                ),
              ),
              child: Text(
                tag,
                style: AppTypography.labelSmall(context).copyWith(
                  color: isSelected ? Colors.white : colors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReviewField(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
  ) {
    return TextField(
      maxLines: 3,
      maxLength: 500,
      onChanged: controller.setReviewText,
      decoration: InputDecoration(
        hintText: 'rating.write_review_hint'.tr,
        hintStyle: AppTypography.bodyMedium(
          context,
        ).copyWith(color: colors.textMuted),
        filled: true,
        fillColor: colors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.all(16.w),
      ),
      style: AppTypography.bodyMedium(
        context,
      ).copyWith(color: colors.textPrimary),
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    AppColorScheme colors,
    RatingController controller,
  ) {
    return Obx(
      () => Column(
        children: [
          // Error message
          if (controller.errorMessage.value.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                controller.errorMessage.value,
                style: AppTypography.labelSmall(
                  context,
                ).copyWith(color: colors.error),
              ),
            ),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value ||
                      controller.currentRating.value == 0
                  ? null
                  : () async {
                      final success = await controller.submitRating(
                        userId: userId,
                        requestId: requestId,
                        ratedUserId: ratedUserId,
                        ratingType: ratingType,
                      );
                      if (success) {
                        onRatingSubmitted?.call();
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                disabledBackgroundColor: colors.border,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: controller.isLoading.value
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'rating.submit'.tr,
                      style: AppTypography.titleMedium(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
            ),
          ),

          // Skip button
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'rating.skip'.tr,
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
