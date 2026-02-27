import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:fluid_background/fluid_background.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/services/storage_service.dart';
import '../widgets/auth_widgets.dart';

/// Login screen with multiple auth options
/// - Google Sign In
/// - Email/Password
/// - Phone Number
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<AuthController>();
    // Listen for error messages and show snackbar
    ever(controller.errorMessage, (String message) {
      if (message.isNotEmpty) {
        Get.snackbar(
          'common.error'.tr,
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
          duration: const Duration(seconds: 4),
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          icon: Icon(Iconsax.info_circle, color: Get.theme.colorScheme.onError),
        );
        controller.clearError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      body: Stack(
        children: [
          // Animated fluid background with theme colors
          FluidBackground(
            initialColors: InitialColors.random(4),
            initialPositions: InitialOffsets.random(4),
            velocity: 60,
            bubblesSize: 400,
            sizeChangingRange: const [300, 500],
            allowColorChanging: true,
            bubbleMutationDuration: const Duration(seconds: 6),
            child: Container(),
          ),
          // Clean minimal content overlay
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top section with logo and title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),
                        _buildCompactHeader(context, colors),
                        SizedBox(height: 32.h),
                        // Clean card for auth
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: _AuthMethodTabs(),
                        ),
                      ],
                    ),
                    // Bottom section with register link and guest option
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),
                        _buildRegisterLink(context, colors),
                        SizedBox(height: 16.h),
                        // Continue as Guest option
                        _buildGuestOption(context, colors),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactHeader(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        // App icon from assets
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            'assets/appiconnobackgound.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'welcome_back'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'sign_in_to_continue'.tr,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink(BuildContext context, AppColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'dont_have_account'.tr,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: () => Get.toNamed('/auth/register'),
          child: Text(
            'sign_up'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestOption(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        // Divider with "or" text
        Row(
          children: [
            Expanded(
              child: Divider(
                color: colors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'or'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: colors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Continue as Guest button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton.icon(
            onPressed: () {
              // Mark as completed and go to home
              final storage = Get.find<StorageService>();
              storage.write('onboarding_completed', true);
              Get.offAllNamed('/home');
            },
            icon: Icon(
              Iconsax.user,
              size: 20.sp,
              color: colors.textSecondary,
            ),
            label: Text(
              'guest.continue_without_login'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: colors.textSecondary.withValues(alpha: 0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Auth method tabs (Email, Phone, Google)
class _AuthMethodTabs extends StatefulWidget {
  @override
  State<_AuthMethodTabs> createState() => _AuthMethodTabsState();
}

class _AuthMethodTabsState extends State<_AuthMethodTabs> {
  int _selectedIndex = 0;

  static final List<_AuthMethodTab> _tabs = [
    _AuthMethodTab(icon: Iconsax.sms, label: 'email'),
    _AuthMethodTab(icon: Iconsax.call, label: 'phone'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Google Sign In button - compact style
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                try {
                  final authController = Get.find<AuthController>();
                  final success = await authController.signInWithGoogle();
                  if (success) {
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (authController.currentUser.value != null) {
                      Get.offAllNamed('/home');
                    }
                  }
                } catch (e) {
                  Get.snackbar('Error', 'Failed to sign in: $e', snackPosition: SnackPosition.BOTTOM);
                }
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: colors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.google_1, size: 18.sp, color: colors.textPrimary),
                    SizedBox(width: 10.w),
                    Text(
                      'continue_with_google'.tr,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Simple divider
        Row(
          children: [
            Expanded(child: Divider(color: colors.border, height: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'or'.tr,
                style: AppTypography.labelSmall(context).copyWith(
                  color: colors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(child: Divider(color: colors.border, height: 1)),
          ],
        ),
        SizedBox(height: 16.h),
        // Compact segmented control
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(3.w),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isSelected = _selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.surface : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 1))]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab.icon,
                          size: 16.sp,
                          color: isSelected ? colors.primary : colors.textSecondary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          tab.label.tr,
                          style: AppTypography.labelSmall(context).copyWith(
                            color: isSelected ? colors.textPrimary : colors.textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 16.h),
        // Content based on selected tab
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _selectedIndex == 0
              ? const _EmailLoginForm()
              : const _PhoneLoginForm(),
        ),
      ],
    );
  }
}

class _AuthMethodTab {
  final IconData icon;
  final String label;

  _AuthMethodTab({required this.icon, required this.label});
}

/// Email login form
class _EmailLoginForm extends StatefulWidget {
  const _EmailLoginForm();

  @override
  State<_EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<_EmailLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          SizedBox(height: 12.h),
          AuthTextField(
            controller: _passwordController,
            label: 'password'.tr,
            hint: 'enter_your_password'.tr,
            prefixIcon: Iconsax.lock,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'password_required'.tr;
              }
              if (value.length < 6) {
                return 'password_too_short'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AuthTextButton(
              text: 'forgot_password'.tr,
              onPressed: () => Get.toNamed('/auth/forgot-password'),
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => AuthPrimaryButton(
                text: 'sign_in'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final success = await controller.signInWithEmail(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );
                      if (success && controller.currentUser.value != null) {
                        Get.offAllNamed('/home');
                      }
                    } catch (e) {
                      Get.snackbar('Error', 'Failed to sign in: $e', snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                },
              )),
        ],
      ),
    );
  }
}

/// Phone login form
class _PhoneLoginForm extends StatefulWidget {
  const _PhoneLoginForm();

  @override
  State<_PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<_PhoneLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final String _countryCode = '+212';

  @override
  void initState() {
    super.initState();
    // Pre-fill with Morocco country code
    _phoneController.text = _countryCode + ' ';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _formatPhoneNumber(String phone) {
    // Remove all spaces and special characters
    String cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    // Ensure it starts with +212
    if (!cleaned.startsWith('+212')) {
      if (cleaned.startsWith('212')) {
        cleaned = '+$cleaned';
      } else if (cleaned.startsWith('0')) {
        cleaned = '+212${cleaned.substring(1)}';
      } else {
        cleaned = '+212$cleaned';
      }
    }
    
    return cleaned;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthTextField(
            controller: _phoneController,
            label: 'phone_number'.tr,
            hint: 'enter_your_phone'.tr,
            prefixIcon: Iconsax.call,
            isPhone: true,
            textDirection: TextDirection.ltr,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'phone_required'.tr;
              }
              final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
              final phoneWithoutCode = cleaned.replaceAll('+212', '');
              
              if (phoneWithoutCode.length < 9) {
                return 'invalid_phone'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          Obx(() => AuthPrimaryButton(
                text: 'send_code'.tr,
                icon: Iconsax.sms_tracking,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final phone = _formatPhoneNumber(_phoneController.text.trim());
                    final success = await controller.verifyPhoneNumber(phone);
                    if (success) {
                      Get.toNamed('/auth/otp', arguments: {'phone': phone});
                    }
                  }
                },
              )),
        ],
      ),
    );
  }
}

/// Empty widget for tab content animation
class _AuthMethodContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Content is handled by _AuthMethodTabs for proper animation
    return const SizedBox.shrink();
  }
}
