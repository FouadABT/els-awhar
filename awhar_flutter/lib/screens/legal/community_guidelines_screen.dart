import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Community Guidelines Screen
/// Displays the app's community standards and behavior expectations
class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'legal.guidelines_title'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.primary, colors.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(Iconsax.people, size: 48.sp, color: Colors.white),
                  SizedBox(height: 12.h),
                  Text(
                    'legal.guidelines_banner_title'.tr,
                    style: AppTypography.titleLarge(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'legal.guidelines_banner_subtitle'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Core Values
            _buildGuidelineCard(
              context,
              colors,
              icon: Iconsax.heart,
              iconColor: colors.error,
              title: 'legal.guidelines_respect_title'.tr,
              content: 'legal.guidelines_respect_content'.tr,
            ),

            _buildGuidelineCard(
              context,
              colors,
              icon: Iconsax.shield_tick,
              iconColor: colors.success,
              title: 'legal.guidelines_safety_title'.tr,
              content: 'legal.guidelines_safety_content'.tr,
            ),

            _buildGuidelineCard(
              context,
              colors,
              icon: Iconsax.verify,
              iconColor: colors.primary,
              title: 'legal.guidelines_honesty_title'.tr,
              content: 'legal.guidelines_honesty_content'.tr,
            ),

            _buildGuidelineCard(
              context,
              colors,
              icon: Iconsax.star,
              iconColor: colors.warning,
              title: 'legal.guidelines_quality_title'.tr,
              content: 'legal.guidelines_quality_content'.tr,
            ),

            SizedBox(height: 16.h),
            Divider(color: colors.borderSoft),
            SizedBox(height: 16.h),

            // Prohibited Behavior Section
            Text(
              'legal.guidelines_prohibited_title'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),

            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_1'.tr),
            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_2'.tr),
            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_3'.tr),
            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_4'.tr),
            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_5'.tr),
            _buildProhibitedItem(context, colors, 'legal.guidelines_prohibited_6'.tr),

            SizedBox(height: 24.h),
            Divider(color: colors.borderSoft),
            SizedBox(height: 24.h),

            // Reporting Section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.infoSoft,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.info.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.info_circle, color: colors.info, size: 24.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'legal.guidelines_reporting_title'.tr,
                          style: AppTypography.titleSmall(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'legal.guidelines_reporting_content'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Consequences Section
            _buildSection(
              context,
              colors,
              title: 'legal.guidelines_consequences_title'.tr,
              content: 'legal.guidelines_consequences_content'.tr,
            ),

            SizedBox(height: 32.h),

            // Footer
            Center(
              child: Text(
                '© ${DateTime.now().year} Awhar. ${'legal.all_rights_reserved'.tr}',
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineCard(
    BuildContext context,
    AppColorScheme colors, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: iconColor, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.titleSmall(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProhibitedItem(
    BuildContext context,
    AppColorScheme colors,
    String text,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.close_circle, color: colors.error, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    AppColorScheme colors, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          content,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
