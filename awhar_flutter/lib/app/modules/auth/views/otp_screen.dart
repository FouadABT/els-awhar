import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:fluid_background/fluid_background.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../widgets/auth_widgets.dart';

/// OTP verification screen for phone authentication
class OtpScreen extends GetView<AuthController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    // Get phone from arguments
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    final String phoneNumber = args?['phone'] ?? '';

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
          // Content overlay - constrained height
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 56.h,
                ),
                child: _OtpForm(phoneNumber: phoneNumber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpForm extends StatefulWidget {
  final String phoneNumber;

  const _OtpForm({required this.phoneNumber});

  @override
  State<_OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<_OtpForm> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  Timer? _resendTimer;
  int _resendSeconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendSeconds = 60;
      _canResend = false;
    });
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    
    // Auto-submit when all digits entered
    if (_otp.length == 6) {
      _verifyOtp();
    }
  }

  void _onKeyPressed(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    if (_otp.length != 6) return;

    final controller = Get.find<AuthController>();
    final success = await controller.verifyOtpCode(_otp);
    
    if (success) {
      Get.offAllNamed('/home');
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;
    
    final controller = Get.find<AuthController>();
    await controller.verifyPhoneNumber(widget.phoneNumber);
    _startResendTimer();
    
    // Clear existing code
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16.h),
        // Header
        _buildCompactHeader(context, colors),
        SizedBox(height: 24.h),
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
        // OTP input fields
        _buildCompactOtpFields(context, colors),
        SizedBox(height: 24.h),
        // Verify button
        Obx(() => AuthPrimaryButton(
              text: 'verify'.tr,
              isLoading: controller.isLoading.value,
              onPressed: _otp.length == 6 ? _verifyOtp : null,
            )),
        SizedBox(height: 16.h),
        // Resend code
        _buildCompactResendSection(context, colors),
        SizedBox(height: 12.h),
      ],
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
            Iconsax.sms_tracking,
            size: 30.sp,
            color: colors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'verify_phone'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'enter_code_sent_to'.tr,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
            fontSize: 12.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Text(
          widget.phoneNumber,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactOtpFields(BuildContext context, AppColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 42.w,
          height: 48.h,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) => _onKeyPressed(index, event),
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: colors.border, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: colors.border, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: colors.primary, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _onOtpChanged(index, value),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCompactResendSection(BuildContext context, AppColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'didnt_receive_code'.tr,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(width: 4.w),
        if (_canResend)
          GestureDetector(
            onTap: _resendCode,
            child: Text(
              'resend'.tr,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          )
        else
          Text(
            'resend_in'.tr + ' $_resendSeconds${'s'.tr}',
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
              fontSize: 11.sp,
            ),
          ),
      ],
    );
  }
}
