import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Privacy Policy Screen
/// Displays the app's privacy policy for app store compliance (GDPR, CCPA compliant)
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'legal.privacy_title'.tr,
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
            // Last updated
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colors.primarySoft,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.calendar, size: 16.sp, color: colors.primary),
                  SizedBox(width: 8.w),
                  Text(
                    '${'legal.last_updated'.tr}: ${_getFormattedDate()}',
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Introduction
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_intro_title'.tr,
              content: 'legal.privacy_intro_content'.tr,
            ),

            // Information We Collect
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_collect_title'.tr,
              content: 'legal.privacy_collect_content'.tr,
            ),

            // How We Use Your Information
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_use_title'.tr,
              content: 'legal.privacy_use_content'.tr,
            ),

            // Information Sharing
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_sharing_title'.tr,
              content: 'legal.privacy_sharing_content'.tr,
            ),

            // Data Security
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_security_title'.tr,
              content: 'legal.privacy_security_content'.tr,
            ),

            // Your Rights (GDPR/CCPA)
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_rights_title'.tr,
              content: 'legal.privacy_rights_content'.tr,
            ),

            // Data Retention
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_retention_title'.tr,
              content: 'legal.privacy_retention_content'.tr,
            ),

            // Cookies and Tracking
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_cookies_title'.tr,
              content: 'legal.privacy_cookies_content'.tr,
            ),

            // Third-Party Services
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_third_party_title'.tr,
              content: 'legal.privacy_third_party_content'.tr,
            ),

            // Children's Privacy
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_children_title'.tr,
              content: 'legal.privacy_children_content'.tr,
            ),

            // Policy Updates
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_updates_title'.tr,
              content: 'legal.privacy_updates_content'.tr,
            ),

            // Contact Us
            _buildSection(
              context,
              colors,
              title: 'legal.privacy_contact_title'.tr,
              content: 'legal.privacy_contact_content'.tr,
              isLast: true,
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

  Widget _buildSection(
    BuildContext context,
    AppColorScheme colors, {
    required String title,
    required String content,
    bool isLast = false,
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
        if (!isLast) ...[
          SizedBox(height: 24.h),
          Divider(color: colors.borderSoft),
          SizedBox(height: 24.h),
        ],
      ],
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
