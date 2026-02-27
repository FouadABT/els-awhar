import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:fluid_background/fluid_background.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../widgets/auth_widgets.dart';

/// Forgot password screen for email password reset
class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Animated fluid background
          FluidBackground(
            initialColors: InitialColors.random(4),
            initialPositions: InitialOffsets.random(4),
            velocity: 80,
            bubblesSize: 350,
            sizeChangingRange: const [250, 450],
            allowColorChanging: true,
            bubbleMutationDuration: const Duration(seconds: 5),
            child: Container(),
          ),
          // Content overlay
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 56.h,
                ),
                child: const _ForgotPasswordForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm();

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<AuthController>();

    if (_emailSent) {
      return _buildSuccessState(context, colors);
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          // Header
          _buildCompactHeader(context, colors),
          SizedBox(height: 28.h),
          // Error message
          Obx(() => AuthErrorMessage(
                message: controller.errorMessage.value,
                onDismiss: controller.clearError,
              )),
          Obx(() {
            if (controller.errorMessage.isNotEmpty) {
              return SizedBox(height: 12.h);
            }
            return const SizedBox.shrink();
          }),
          // Email field
          AuthTextField(
            controller: _emailController,
            label: 'email'.tr,
            hint: 'enter_your_email'.tr,
            prefixIcon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'email_required'.tr;
              }
              if (!GetUtils.isEmail(value)) {
                return 'invalid_email'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          // Submit button
          Obx(() => AuthPrimaryButton(
                text: 'send_reset_link'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await controller.sendPasswordResetEmail(
                      _emailController.text.trim(),
                    );
                    if (success) {
                      setState(() => _emailSent = true);
                    } else {
                      setState(() => _emailSent = true);
                    }
                  }
                },
              )),
          SizedBox(height: 14.h),
          // Back to login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'remember_password'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(width: 3.w),
              GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  'sign_in'.tr,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactHeader(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        // Icon
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Iconsax.lock,
            size: 30.sp,
            color: colors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'forgot_password'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'reset_password_instruction'.tr,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        // Success icon
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            color: colors.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Iconsax.tick_circle,
            size: 50.sp,
            color: colors.success,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          'email_sent'.tr,
          style: AppTypography.headlineMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'check_email_for_reset'.tr,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          _emailController.text,
          style: AppTypography.bodyLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 40.h),
        AuthPrimaryButton(
          text: 'back_to_login'.tr,
          onPressed: () => Get.back(),
        ),
        SizedBox(height: 16.h),
        AuthTextButton(
          text: 'resend_email'.tr,
          onPressed: () {
            setState(() => _emailSent = false);
          },
        ),
      ],
    );
  }
}
