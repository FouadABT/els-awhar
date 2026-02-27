import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';

class TimelineStep {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String description;
  final DateTime? timestamp;
  final bool isCompleted;
  final bool isActive;

  const TimelineStep({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
    this.timestamp,
    this.isCompleted = false,
    this.isActive = false,
  });
}

class NegotiationTimelineWidget extends StatelessWidget {
  final List<TimelineStep> steps;

  const NegotiationTimelineWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final step = steps[index];
        final isLastStep = index == steps.length - 1;
        return _buildTimelineStep(context, step, colors, isLastStep);
      },
    );
  }

  Widget _buildTimelineStep(
    BuildContext context,
    TimelineStep step,
    AppColorScheme colors,
    bool isLastStep,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Icon + line
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon container
              _buildIconContainer(context, step, colors),
              
              // Connecting line
              if (!isLastStep)
                Container(
                  width: 2.w,
                  height: 40.h,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: step.isCompleted
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              step.iconColor,
                              colors.border,
                            ],
                          )
                        : null,
                    color: step.isCompleted ? null : colors.border,
                  ),
                ),
            ],
          ),
          
          SizedBox(width: 16.w),
          
          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: step.isActive || step.isCompleted 
                        ? colors.textPrimary 
                        : colors.textSecondary,
                    fontWeight: step.isActive || step.isCompleted 
                        ? FontWeight.w600 
                        : FontWeight.w400,
                  ),
                ),
                
                SizedBox(height: 4.h),
                
                // Description
                Text(
                  step.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: step.isActive || step.isCompleted 
                        ? colors.textSecondary 
                        : colors.textMuted,
                  ),
                ),
                
                // Timestamp
                if (step.timestamp != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    _formatTimestamp(step.timestamp!),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
                
                // In progress indicator for active step
                if (step.isActive) ...[
                  SizedBox(height: 8.h),
                  Text(
                    'timeline.in_progress'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colors.primary,
                      fontStyle: FontStyle.italic,
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

  Widget _buildIconContainer(
      BuildContext context, TimelineStep step, AppColorScheme colors) {
    if (step.isActive) {
      // Pulsing animation for active step
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1500),
        tween: Tween(begin: 0.8, end: 1.0),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step.iconBackgroundColor,
                border: Border.all(
                  color: step.iconColor,
                  width: 2.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: step.iconColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                step.icon,
                color: step.iconColor,
                size: 24.sp,
              ),
            ),
          );
        },
        onEnd: () {
          // Loop animation by rebuilding widget
        },
      );
    } else if (step.isCompleted) {
      // Solid icon for completed step
      return Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: step.iconBackgroundColor,
        ),
        child: Icon(
          step.icon,
          color: step.iconColor,
          size: 24.sp,
        ),
      );
    } else {
      // Outlined icon for future step
      return Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.surface,
          border: Border.all(
            color: colors.border,
            width: 2.w,
          ),
        ),
        child: Icon(
          step.icon,
          color: colors.textMuted,
          size: 24.sp,
        ),
      );
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'common.just_now'.tr;
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ${'common.ago'.tr}';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ${'common.ago'.tr}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ${'common.ago'.tr}';
    } else {
      // Format as date for older timestamps
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
