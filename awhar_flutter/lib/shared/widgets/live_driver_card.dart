import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/service_catalog_controller.dart';
import '../../core/controllers/auth_controller.dart';
import '../../app/routes/app_routes.dart';

/// Professional card for displaying live online drivers with quick actions
class LiveDriverCard extends StatelessWidget {
  final DriverProfile driver;
  final String lastSeenText;
  final VoidCallback onTap;

  const LiveDriverCard({
    super.key,
    required this.driver,
    required this.lastSeenText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<ServiceCatalogController>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.success.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.success.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Driver avatar with live indicator
                _buildAvatar(context, colors),
                SizedBox(width: 14.w),
                
                // Driver info
                Expanded(
                  child: _buildDriverInfo(context, colors),
                ),
                
                // Favorite button
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.toggleFavorite(driver.id!),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.background,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.border),
                      ),
                      child: Icon(
                        controller.isFavorite(driver.id!)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18.sp,
                        color: controller.isFavorite(driver.id!)
                            ? colors.error
                            : colors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 14.h),
            
            // Quick action buttons
            Row(
              children: [
                // Chat button
                Expanded(
                  child: _buildActionButton(
                    context,
                    colors,
                    icon: Iconsax.message,
                    label: 'client.catalog.chat'.tr,
                    onTap: () => _handleChat(context),
                    color: colors.primary,
                  ),
                ),
                SizedBox(width: 10.w),
                
                // View services button
                Expanded(
                  child: _buildActionButton(
                    context,
                    colors,
                    icon: Iconsax.bag_2,
                    label: 'client.catalog.view_services'.tr,
                    onTap: onTap,
                    color: colors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, AppColorScheme colors) {
    return Stack(
      children: [
        // Avatar
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: driver.profilePhotoUrl != null && driver.profilePhotoUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: driver.profilePhotoUrl!,
                  width: 72.w,
                  height: 72.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 72.w,
                    height: 72.h,
                    color: colors.surface,
                    child: Icon(Iconsax.user, color: colors.textSecondary, size: 28.sp),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 72.w,
                    height: 72.h,
                    color: colors.primary.withValues(alpha: 0.1),
                    child: Icon(Iconsax.user, color: colors.primary, size: 28.sp),
                  ),
                )
              : Container(
                  width: 72.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Iconsax.user, color: colors.primary, size: 28.sp),
                ),
        ),
        
        // Live pulse indicator
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              color: colors.success,
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: 2),
              boxShadow: [
                BoxShadow(
                  color: colors.success.withValues(alpha: 0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDriverInfo(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name and online badge
        Row(
          children: [
            Expanded(
              child: Text(
                driver.displayName,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: colors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: colors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'common.online'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        
        // Rating
        Row(
          children: [
            Icon(Iconsax.star_1, size: 14.sp, color: colors.warning),
            SizedBox(width: 4.w),
            Text(
              '${(driver.ratingAverage ?? 0.0).toStringAsFixed(1)} (${driver.ratingCount ?? 0})',
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Iconsax.clock, size: 14.sp, color: colors.textSecondary),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                lastSeenText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        
        // Location (if available)
        if (driver.lastLocationLat != null && driver.lastLocationLng != null) ...[
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Iconsax.location, size: 14.sp, color: colors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                'client.catalog.nearby'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    AppColorScheme colors, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18.sp, color: color),
              SizedBox(height: 4.h),
              Text(
                label,
                style: AppTypography.bodySmall(context).copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION HANDLERS
  // ============================================================

  Future<void> _handleChat(BuildContext context) async {
    final authController = Get.find<AuthController>();
    final currentUser = authController.currentUser.value;

    if (currentUser == null || currentUser.id == null) {
      Get.snackbar(
        'errors.not_logged_in'.tr,
        'errors.login_required'.tr,
        icon: const Icon(Iconsax.info_circle),
      );
      return;
    }

    // Navigate to direct chat (supports DriverProfile argument)
    Get.toNamed(
      AppRoutes.directChat,
      arguments: driver,
    );
  }
}
