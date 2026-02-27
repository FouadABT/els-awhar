import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/controllers/auth_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Delete Account Screen
/// Allows users to permanently delete their account (App Store/Google Play requirement)
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _confirmController = TextEditingController();
  final RxBool _isLoading = false.obs;
  final RxBool _isConfirmValid = false.obs;
  final RxString _errorMessage = ''.obs;

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(_validateConfirmation);
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  void _validateConfirmation() {
    _isConfirmValid.value = _confirmController.text.toLowerCase() == 'delete';
  }

  Future<void> _deleteAccount() async {
    if (!_isConfirmValid.value) return;

    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final authController = Get.find<AuthController>();
      
      // Call the server endpoint to delete account
      await authController.deleteAccount();
      
      // Show success message and sign out
      Get.snackbar(
        'account.deleted_title'.tr,
        'account.deleted_message'.tr,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
    } catch (e) {
      _errorMessage.value = e.toString();
      Get.snackbar(
        'common.error'.tr,
        _errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

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
          'account.delete_title'.tr,
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
            // Warning Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colors.errorSoft,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colors.error.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.warning_2,
                      size: 48.sp,
                      color: colors.error,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'account.delete_warning_title'.tr,
                    style: AppTypography.titleLarge(context).copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'account.delete_warning_subtitle'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // What will be deleted
            Text(
              'account.delete_what_happens'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),

            _buildDeleteItem(
              context,
              colors,
              icon: Iconsax.user,
              text: 'account.delete_item_profile'.tr,
            ),
            _buildDeleteItem(
              context,
              colors,
              icon: Iconsax.message,
              text: 'account.delete_item_messages'.tr,
            ),
            _buildDeleteItem(
              context,
              colors,
              icon: Iconsax.document,
              text: 'account.delete_item_requests'.tr,
            ),
            _buildDeleteItem(
              context,
              colors,
              icon: Iconsax.star,
              text: 'account.delete_item_reviews'.tr,
            ),
            _buildDeleteItem(
              context,
              colors,
              icon: Iconsax.wallet,
              text: 'account.delete_item_payments'.tr,
            ),

            SizedBox(height: 24.h),
            Divider(color: colors.borderSoft),
            SizedBox(height: 24.h),

            // Data Retention Notice
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.infoSoft,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Iconsax.info_circle, color: colors.info, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'account.delete_retention_title'.tr,
                          style: AppTypography.titleSmall(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'account.delete_retention_content'.tr,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Confirmation Section
            Text(
              'account.delete_confirm_label'.tr,
              style: AppTypography.titleSmall(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'account.delete_confirm_instruction'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),

            // Confirmation TextField
            TextField(
              controller: _confirmController,
              decoration: InputDecoration(
                hintText: 'DELETE',
                hintStyle: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textMuted,
                ),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: colors.borderSoft),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: colors.borderSoft),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: colors.error, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              style: AppTypography.bodyLarge(context).copyWith(
                color: colors.textPrimary,
              ),
              textCapitalization: TextCapitalization.characters,
            ),

            SizedBox(height: 24.h),

            // Error Message
            Obx(() => _errorMessage.value.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colors.errorSoft,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.warning_2, color: colors.error, size: 20.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            _errorMessage.value,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()),

            // Delete Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isConfirmValid.value && !_isLoading.value
                        ? () => _showFinalConfirmation(context, colors)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.error,
                      disabledBackgroundColor: colors.error.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading.value
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'account.delete_button'.tr,
                            style: AppTypography.titleSmall(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                )),

            SizedBox(height: 16.h),

            // Cancel Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.borderSoft),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'account.delete_cancel'.tr,
                  style: AppTypography.titleSmall(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteItem(
    BuildContext context,
    AppColorScheme colors, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.errorSoft,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: colors.error, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFinalConfirmation(BuildContext context, AppColorScheme colors) {
    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Iconsax.warning_2, color: colors.error, size: 28.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'account.delete_final_title'.tr,
                style: AppTypography.titleLarge(context).copyWith(
                  color: colors.error,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'account.delete_final_message'.tr,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr,
              style: AppTypography.labelLarge(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _deleteAccount();
            },
            child: Text(
              'account.delete_confirm'.tr,
              style: AppTypography.labelLarge(context).copyWith(
                color: colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
