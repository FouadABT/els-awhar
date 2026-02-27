import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Status timeline widget showing request progress
class StatusTimelineWidget extends StatelessWidget {
  final ServiceRequest request;
  final bool isPurchaseRequest;

  const StatusTimelineWidget({
    super.key,
    required this.request,
    this.isPurchaseRequest = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    final steps = _getTimelineSteps();
    final currentStepIndex = _getCurrentStepIndex();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'client.active_request.status_timeline'.tr,
            style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 20.h),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index < currentStepIndex;
            final isCurrent = index == currentStepIndex;
            final isLast = index == steps.length - 1;

            return _buildTimelineStep(
              context: context,
              colors: colors,
              step: step,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required BuildContext context,
    required AppColorScheme colors,
    required TimelineStep step,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
  }) {
    Color circleColor;
    Color lineColor;
    IconData icon;

    if (isCompleted) {
      circleColor = colors.success;
      lineColor = colors.success;
      icon = Iconsax.tick_circle;
    } else if (isCurrent) {
      circleColor = colors.primary;
      lineColor = colors.border;
      icon = step.icon;
    } else {
      circleColor = colors.border;
      lineColor = colors.border;
      icon = step.icon;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              // Circle
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: isCompleted || isCurrent
                      ? circleColor.withValues(alpha: 0.1)
                      : colors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: circleColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color: circleColor,
                ),
              ),
              // Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: lineColor,
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTypography.bodyLarge(context).copyWith(
                      color: isCurrent || isCompleted
                          ? colors.textPrimary
                          : colors.textSecondary,
                    ),
                  ),
                  if (step.timestamp != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _formatTimestamp(step.timestamp!),
                      style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                    ),
                  ],
                  if (isCurrent && step.subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      step.subtitle!,
                      style: AppTypography.bodySmall(context).copyWith(color: colors.primary),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TimelineStep> _getTimelineSteps() {
    if (isPurchaseRequest) {
      return [
        TimelineStep(
          title: 'Order Placed',
          subtitle: 'Waiting for driver',
          icon: Iconsax.document,
          timestamp: request.createdAt,
        ),
        TimelineStep(
          title: 'Driver Accepted',
          subtitle: 'Driver is on the way to store',
          icon: Iconsax.user_tick,
          timestamp: request.acceptedAt,
        ),
        TimelineStep(
          title: 'At Store',
          subtitle: 'Purchasing your items',
          icon: Iconsax.shop,
          timestamp: request.driverArrivingAt,
        ),
        TimelineStep(
          title: 'Out for Delivery',
          subtitle: 'Heading to your location',
          icon: Iconsax.routing_2,
          timestamp: request.startedAt,
        ),
        TimelineStep(
          title: 'Delivered',
          subtitle: 'Order completed',
          icon: Iconsax.tick_square,
          timestamp: request.completedAt,
        ),
      ];
    }

    return [
      TimelineStep(
        title: 'client.active_request.request_accepted'.tr,
        icon: Iconsax.tick_circle,
        timestamp: request.acceptedAt,
      ),
      TimelineStep(
        title: 'client.active_request.driver_on_the_way'.tr,
        subtitle: 'Driver is heading to pickup location',
        icon: Iconsax.routing,
        timestamp: request.driverArrivingAt,
      ),
      TimelineStep(
        title: 'client.active_request.driver_arrived'.tr,
        subtitle: 'Driver has arrived at pickup',
        icon: Iconsax.location_tick,
        timestamp: request.startedAt != null ? request.driverArrivingAt : null,
      ),
      TimelineStep(
        title: 'client.active_request.service_in_progress'.tr,
        subtitle: 'Service is now in progress',
        icon: Iconsax.play_circle,
        timestamp: request.startedAt,
      ),
      TimelineStep(
        title: 'client.active_request.service_completed'.tr,
        icon: Iconsax.tick_square,
        timestamp: request.completedAt,
      ),
    ];
  }

  int _getCurrentStepIndex() {
    switch (request.status) {
      case RequestStatus.accepted:
        return 0;
      case RequestStatus.driver_arriving:
        return 1;
      case RequestStatus.in_progress:
        return 3;
      case RequestStatus.completed:
        return 4;
      default:
        return 0;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}

/// Timeline step model
class TimelineStep {
  final String title;
  final String? subtitle;
  final IconData icon;
  final DateTime? timestamp;

  TimelineStep({
    required this.title,
    this.subtitle,
    required this.icon,
    this.timestamp,
  });
}
