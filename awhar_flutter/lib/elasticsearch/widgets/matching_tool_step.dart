import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

/// A single tool execution step card shown during AI matching.
/// Animates in from the right with scale + fade.
class MatchingToolStep extends StatelessWidget {
  final String toolName;
  final String? statusText;
  final bool isActive;
  final bool isComplete;
  final int index;

  const MatchingToolStep({
    super.key,
    required this.toolName,
    this.statusText,
    this.isActive = false,
    this.isComplete = false,
    this.index = 0,
  });

  /// Human-readable tool names and icons
  static const Map<String, _ToolInfo> _toolDisplayMap = {
    'nearby_drivers': _ToolInfo('Scanning Nearby Drivers', '📍', 'Finding drivers in your area'),
    'service_qualified_drivers': _ToolInfo('Checking Qualifications', '🎯', 'Matching service expertise'),
    'vehicle_type_filter': _ToolInfo('Filtering Vehicles', '🚗', 'Finding the right vehicle type'),
    'driver_performance': _ToolInfo('Analyzing Performance', '⭐', 'Checking ratings & reliability'),
    'driver_workload': _ToolInfo('Checking Availability', '📊', 'Ensuring driver capacity'),
    'check_availability_window': _ToolInfo('Schedule Check', '⏰', 'Verifying time windows'),
    'category_experts': _ToolInfo('Finding Experts', '🏆', 'Matching category specialists'),
    'store_specialists': _ToolInfo('Store Specialists', '🏪', 'Finding delivery experts'),
    'get_request_details': _ToolInfo('Reading Request', '📋', 'Understanding your needs'),
  };

  _ToolInfo get _info {
    // Try exact match first
    for (final entry in _toolDisplayMap.entries) {
      if (toolName.toLowerCase().contains(entry.key)) {
        return entry.value;
      }
    }
    return _ToolInfo('Processing', '⚙️', toolName);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final info = _info;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive
            ? colors.primary.withValues(alpha: 0.08)
            : isComplete
                ? colors.success.withValues(alpha: 0.06)
                : colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isActive
              ? colors.primary.withValues(alpha: 0.3)
              : isComplete
                  ? colors.success.withValues(alpha: 0.2)
                  : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Emoji icon
          Text(
            info.emoji,
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(width: 10.w),

          // Tool info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  info.displayName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive ? colors.primary : colors.textPrimary,
                  ),
                ),
                if (statusText != null || info.subtitle.isNotEmpty) ...[
                  SizedBox(height: 1.h),
                  Text(
                    statusText ?? info.subtitle,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: colors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Status indicator
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isComplete
                ? Icon(
                    Icons.check_circle_rounded,
                    key: const ValueKey('done'),
                    color: colors.success,
                    size: 18.sp,
                  )
                : isActive
                    ? SizedBox(
                        key: const ValueKey('loading'),
                        width: 16.sp,
                        height: 16.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(colors.primary),
                        ),
                      )
                    : SizedBox(
                        key: const ValueKey('waiting'),
                        width: 16.sp,
                        height: 16.sp,
                      ),
          ),
        ],
      ),
    );
  }
}

class _ToolInfo {
  final String displayName;
  final String emoji;
  final String subtitle;

  const _ToolInfo(this.displayName, this.emoji, this.subtitle);
}
