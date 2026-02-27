import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';

/// Widget for "What do you need?" input in concierge/purchase requests
class ConciergeInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onAttachPhoto;
  final List<String> attachments;
  final VoidCallback? onRemoveAttachment;

  const ConciergeInputWidget({
    super.key,
    required this.controller,
    this.onAttachPhoto,
    this.attachments = const [],
    this.onRemoveAttachment,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main input field
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colors.border),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            style: AppTypography.bodyLarge(context).copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'concierge.what_do_you_need_hint'.tr,
              hintStyle: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Attach photo button
        GestureDetector(
          onTap: onAttachPhoto,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: colors.primary.withValues(alpha: 0.3),
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.camera,
                  color: colors.primary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'concierge.add_photo'.tr,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Display attached images
        if (attachments.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: attachments.map((path) {
              return Stack(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: colors.border),
                      color: colors.surface,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Icon(
                        Iconsax.gallery,
                        color: colors.textSecondary,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: onRemoveAttachment,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: colors.error,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
