import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';

/// Toggle widget for selecting "Anywhere Nearby" vs "Specific Place"
class LocationModeToggle extends StatelessWidget {
  final bool isFlexible;
  final Function(bool) onChanged;
  final VoidCallback? onPickSpecific;

  const LocationModeToggle({
    super.key,
    required this.isFlexible,
    required this.onChanged,
    this.onPickSpecific,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'concierge.location_preference'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        
        // Option 1: Anywhere Nearby
        GestureDetector(
          onTap: () => onChanged(true),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isFlexible ? colors.primary.withValues(alpha: 0.1) : colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isFlexible ? colors.primary : colors.border,
                width: isFlexible ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: isFlexible ? colors.primary : colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.location,
                    color: isFlexible ? Colors.white : colors.textSecondary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'concierge.anywhere_nearby'.tr,
                        style: AppTypography.titleSmall(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'concierge.anywhere_nearby_desc'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isFlexible)
                  Icon(
                    Iconsax.tick_circle,
                    color: colors.primary,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Option 2: Specific Place
        GestureDetector(
          onTap: () {
            onChanged(false);
            if (onPickSpecific != null) {
              Future.delayed(const Duration(milliseconds: 300), onPickSpecific);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: !isFlexible ? colors.primary.withValues(alpha: 0.1) : colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: !isFlexible ? colors.primary : colors.border,
                width: !isFlexible ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: !isFlexible ? colors.primary : colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.map_1,
                    color: !isFlexible ? Colors.white : colors.textSecondary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'concierge.specific_place'.tr,
                        style: AppTypography.titleSmall(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'concierge.specific_place_desc'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isFlexible)
                  Icon(
                    Iconsax.tick_circle,
                    color: colors.primary,
                    size: 24.sp,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
