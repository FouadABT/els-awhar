import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Terms and Conditions Screen
/// Displays the app's terms of service for app store compliance
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
          'legal.terms_title'.tr,
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
              title: 'legal.terms_intro_title'.tr,
              content: 'legal.terms_intro_content'.tr,
            ),

            // Acceptance of Terms
            _buildSection(
              context,
              colors,
              title: 'legal.terms_acceptance_title'.tr,
              content: 'legal.terms_acceptance_content'.tr,
            ),

            // User Accounts
            _buildSection(
              context,
              colors,
              title: 'legal.terms_accounts_title'.tr,
              content: 'legal.terms_accounts_content'.tr,
            ),

            // Services Description
            _buildSection(
              context,
              colors,
              title: 'legal.terms_services_title'.tr,
              content: 'legal.terms_services_content'.tr,
            ),

            // User Responsibilities
            _buildSection(
              context,
              colors,
              title: 'legal.terms_responsibilities_title'.tr,
              content: 'legal.terms_responsibilities_content'.tr,
            ),

            // Payment Terms
            _buildSection(
              context,
              colors,
              title: 'legal.terms_payment_title'.tr,
              content: 'legal.terms_payment_content'.tr,
            ),

            // Prohibited Activities
            _buildSection(
              context,
              colors,
              title: 'legal.terms_prohibited_title'.tr,
              content: 'legal.terms_prohibited_content'.tr,
            ),

            // Intellectual Property
            _buildSection(
              context,
              colors,
              title: 'legal.terms_ip_title'.tr,
              content: 'legal.terms_ip_content'.tr,
            ),

            // Limitation of Liability
            _buildSection(
              context,
              colors,
              title: 'legal.terms_liability_title'.tr,
              content: 'legal.terms_liability_content'.tr,
            ),

            // Termination
            _buildSection(
              context,
              colors,
              title: 'legal.terms_termination_title'.tr,
              content: 'legal.terms_termination_content'.tr,
            ),

            // Governing Law
            _buildSection(
              context,
              colors,
              title: 'legal.terms_governing_title'.tr,
              content: 'legal.terms_governing_content'.tr,
            ),

            // Contact Information
            _buildSection(
              context,
              colors,
              title: 'legal.terms_contact_title'.tr,
              content: 'legal.terms_contact_content'.tr,
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
