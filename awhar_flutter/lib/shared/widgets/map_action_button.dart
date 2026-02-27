import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

/// Floating action button for map controls
class MapActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;

  const MapActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Icon(
              icon,
              color: iconColor ?? colors.textPrimary,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}
