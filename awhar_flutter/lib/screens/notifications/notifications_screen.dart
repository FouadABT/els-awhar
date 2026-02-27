import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/controllers/notification_controller.dart';
import '../../core/controllers/request_controller.dart';
import '../../core/models/app_notification.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Screen displaying all notifications
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'notifications.title'.tr,
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
        actions: [
          // Mark all as read
          Obx(() {
            if (controller.unreadCount.value > 0) {
              return IconButton(
                icon: Icon(Iconsax.tick_circle, color: colors.primary),
                onPressed: () {
                  controller.markAllAsRead();
                  Get.snackbar(
                    'notifications.title'.tr,
                    'notifications.all_marked_read'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                tooltip: 'notifications.mark_all_read'.tr,
              );
            }
            return const SizedBox.shrink();
          }),
          // Clear all
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: colors.textPrimary),
            onSelected: (value) {
              if (value == 'clear') {
                _showClearConfirmation(context, controller, colors);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Iconsax.trash, size: 20.sp, color: colors.error),
                    SizedBox(width: 8.w),
                    Text('notifications.clear_all'.tr),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return _buildEmptyState(context, colors);
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return _NotificationItem(
              notification: notification,
              colors: colors,
              onTap: () => _handleNotificationTap(notification, controller),
              onDismiss: () => controller.deleteNotification(notification.id),
            );
          },
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.notification,
              size: 64.sp,
              color: colors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'notifications.empty_title'.tr,
            style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'notifications.empty_subtitle'.tr,
              style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showClearConfirmation(
    BuildContext context,
    NotificationController controller,
    AppColorScheme colors,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text('notifications.clear_all'.tr),
        content: Text('notifications.clear_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearAll();
              Get.back();
              Get.snackbar(
                'notifications.title'.tr,
                'notifications.cleared'.tr,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: colors.error),
            child: Text('common.delete'.tr, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleNotificationTap(
    AppNotification notification,
    NotificationController controller,
  ) async {
    // Mark as read
    controller.markAsRead(notification.id);

    // Navigate based on type
    final type = notification.type;
    final requestId = notification.requestId;

    switch (type) {
      case 'request_accepted':
      case 'driver_arriving':
      case 'service_started':
      case 'service_completed':
        // Navigate to active request screen
        if (requestId != null) {
          final requestController = Get.find<RequestController>();
          await requestController.loadActiveRequest();
          if (requestController.activeRequest.value != null) {
            Get.toNamed('/client/active-request',
                arguments: requestController.activeRequest.value);
          }
        }
        break;

      case 'new_request':
        Get.toNamed('/driver/available-requests');
        break;

      case 'chat_message':
        if (requestId != null) {
          final requestController = Get.find<RequestController>();
          await requestController.loadActiveRequest();
          final request = requestController.activeRequests.firstWhereOrNull(
            (r) => r.id.toString() == requestId,
          );
          if (request != null) {
            Get.toNamed('/chat/$requestId', arguments: request);
          }
        }
        break;

      default:
        // Just mark as read, no navigation
        break;
    }
  }
}

/// Individual notification item widget
class _NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final AppColorScheme colors;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationItem({
    required this.notification,
    required this.colors,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        color: colors.error,
        child: Icon(Iconsax.trash, color: Colors.white, size: 24.sp),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: notification.isRead
                ? colors.surface
                : colors.primary.withValues(alpha: 0.05),
            border: Border(
              bottom: BorderSide(
                color: colors.textSecondary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: _getIconColor().withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(),
                  size: 20.sp,
                  color: _getIconColor(),
                ),
              ),
              SizedBox(width: 12.w),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTypography.titleSmall(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      notification.body,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      timeago.format(notification.timestamp),
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (notification.type) {
      case 'request_accepted':
        return Iconsax.tick_circle;
      case 'driver_arriving':
        return Iconsax.car;
      case 'service_started':
        return Iconsax.routing;
      case 'service_completed':
        return Iconsax.flag;
      case 'new_request':
        return Iconsax.notification_bing;
      case 'request_cancelled':
        return Iconsax.close_circle;
      case 'chat_message':
        return Iconsax.message;
      default:
        return Iconsax.notification;
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case 'request_accepted':
        return Colors.green;
      case 'driver_arriving':
        return Colors.orange;
      case 'service_started':
        return Colors.blue;
      case 'service_completed':
        return Colors.green;
      case 'new_request':
        return colors.primary;
      case 'request_cancelled':
        return colors.error;
      case 'chat_message':
        return colors.primary;
      default:
        return colors.textSecondary;
    }
  }
}
