import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/controllers/notification_controller.dart';
import '../../core/theme/app_colors.dart';

/// Notification bell icon with badge showing unread count
class NotificationBell extends StatelessWidget {
  final Color? iconColor;
  final double? size;

  const NotificationBell({
    super.key,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<NotificationController>();

    return IconButton(
      onPressed: () => Get.toNamed('/notifications'),
      icon: Obx(() {
        final unreadCount = controller.unreadCount.value;
        
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Iconsax.notification,
              color: iconColor ?? colors.textPrimary,
              size: size ?? 24.sp,
            ),
            if (unreadCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16.w,
                    minHeight: 16.h,
                  ),
                  child: Center(
                    child: Text(
                      unreadCount > 99 ? '99+' : unreadCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
