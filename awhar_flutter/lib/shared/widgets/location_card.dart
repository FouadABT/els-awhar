import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Location Card showing pickup or destination with modern UI
class LocationCard extends StatelessWidget {
  final String title;
  final String address;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final bool isActive;
  final Color? iconColor;

  const LocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.icon,
    this.onTap,
    this.onClear,
    this.isActive = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isActive
              ? colors.primary.withValues(alpha: 0.1)
              : colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isActive
                ? colors.primary
                : colors.border,
            width: isActive ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: (iconColor ?? colors.primary).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: iconColor ?? colors.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSmall(context),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    address.isEmpty ? 'Tap to select location' : address,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: address.isEmpty ? colors.textSecondary : colors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Clear button
            if (address.isNotEmpty && onClear != null)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: colors.textSecondary,
                  size: 20.sp,
                ),
                onPressed: onClear,
              ),
          ],
        ),
      ),
    );
  }
}
