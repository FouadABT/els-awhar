import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:fluid_background/fluid_background.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/role_selector.dart';

/// Registration screen with role selection
/// Handles both new registrations and completing registration for social/phone auth
class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    // Get arguments from navigation (for social auth completion)
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    final String? idToken = args?['idToken'];
    final String? email = args?['email'];
    final String? displayName = args?['displayName'];
    final String? phoneNumber = args?['phoneNumber'];
    final String? authMethod = args?['authMethod'];

    // If we have an idToken, this is registration completion flow
    final bool isCompletingRegistration = idToken != null;

    return Scaffold(
      body: Stack(
        children: [
          // Animated fluid background
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
          // Clean minimal content
          SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),
                    
                    // Compact header - all in one line
                    Row(
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Iconsax.arrow_left,
                            color: colors.textPrimary,
                            size: 20.sp,
                          ),
                        ),
                        
                        SizedBox(width: 12.w),
                        
                        // App icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            'assets/appiconnobackgound.png',
                            width: 32.w,
                            height: 32.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        SizedBox(width: 10.w),
                        
                        // Title
                        Expanded(
                          child: Text(
                            isCompletingRegistration
                                ? 'complete_registration'.tr
                                : 'create_account'.tr,
                            style: AppTypography.titleMedium(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Form card
                    Container(
                      padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 3))],
                    ),
                    child: isCompletingRegistration
                        ? _RegistrationCompletionForm(
                            idToken: idToken,
                            email: email,
                            displayName: displayName,
                            phoneNumber: phoneNumber,
                            photoUrl: args?['photoUrl'],
                            authMethod: authMethod ?? 'unknown',
                          )
                        : const _FullRegistrationForm(),
                  ),
                  
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
      )],
      ),
    );
  }
}

/// Full registration form for email signup
class _FullRegistrationForm extends StatefulWidget {
  const _FullRegistrationForm();

  @override
  State<_FullRegistrationForm> createState() => _FullRegistrationFormState();
}

class _FullRegistrationFormState extends State<_FullRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserRole _selectedRole = UserRole.client;
  int _currentStep = 0; // 0 = Role selection, 1 = Form fields

  @override
  void initState() {
    super.initState();
    final controller = Get.find<AuthController>();
    // Listen for error messages and show snackbar
    ever(controller.errorMessage, (String message) {
      if (message.isNotEmpty) {
        Get.snackbar(
          'error'.tr,
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Step indicator
        _buildStepIndicator(colors),
        
        SizedBox(height: 24.h),
        
        // Content based on current step
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _currentStep == 0
              ? _buildRoleSelectionStep(colors)
              : _buildFormFieldsStep(colors, controller),
        ),
      ],
    );
  }

  Widget _buildStepIndicator(AppColorScheme colors) {
    return Row(
      children: [
        Expanded(
          child: _buildStepDot(0, 'choose_role'.tr, colors),
        ),
        Container(
          height: 2,
          width: 40.w,
          color: _currentStep > 0 ? colors.primary : colors.border,
        ),
        Expanded(
          child: _buildStepDot(1, 'your_info'.tr, colors),
        ),
      ],
    );
  }

  Widget _buildStepDot(int step, String label, AppColorScheme colors) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;
    
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive || isCompleted ? colors.primary : colors.surfaceElevated,
            border: Border.all(
              color: isActive || isCompleted ? colors.primary : colors.border,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? Icon(Iconsax.tick_circle, size: 16.sp, color: Colors.white)
                : Text(
                    '${step + 1}',
                    style: AppTypography.labelMedium(context).copyWith(
                      color: isActive ? Colors.white : colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: AppTypography.bodySmall(context).copyWith(
            color: isActive ? colors.textPrimary : colors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontSize: 10.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRoleSelectionStep(AppColorScheme colors) {
    return Form(
      key: ValueKey('step_0'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'select_your_role'.tr,
            style: AppTypography.titleLarge(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'choose_how_you_want_to_use_awhar'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: 32.h),
          
          _buildRoleSelector(colors),
          
          SizedBox(height: 32.h),
          
          // Next button
          AuthPrimaryButton(
            text: 'continue'.tr,
            onPressed: () {
              setState(() => _currentStep = 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormFieldsStep(AppColorScheme colors, AuthController controller) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Form fields section
          AuthTextField(
            controller: _nameController,
            label: 'full_name'.tr,
            hint: 'enter_your_name'.tr,
            prefixIcon: Iconsax.user,
            validator: (value) {
              if (value == null || value.isEmpty) return 'name_required'.tr;
              if (value.length < 2) return 'name_too_short'.tr;
              return null;
            },
          ),
          
          SizedBox(height: 12.h),
          
          AuthTextField(
            controller: _emailController,
            label: 'email'.tr,
            hint: 'enter_your_email'.tr,
            prefixIcon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'email_required'.tr;
              if (!GetUtils.isEmail(value)) return 'invalid_email'.tr;
              return null;
            },
          ),
          
          SizedBox(height: 12.h),
          
          AuthTextField(
            controller: _phoneController,
            label: 'phone_number'.tr,
            hint: 'enter_your_phone'.tr,
            prefixIcon: Iconsax.call,
            isPhone: true,
            textDirection: TextDirection.ltr,
            validator: (value) {
              if (_selectedRole == UserRole.driver) {
                if (value == null || value.trim().isEmpty) return 'phone_required_for_driver'.tr;
                if (value.trim().length < 10) return 'invalid_phone_number'.tr;
              }
              return null;
            },
          ),
          
          SizedBox(height: 12.h),
          
          AuthTextField(
            controller: _passwordController,
            label: 'password'.tr,
            hint: 'create_password'.tr,
            prefixIcon: Iconsax.lock,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'password_required'.tr;
              if (value.length < 6) return 'password_too_short'.tr;
              return null;
            },
          ),
          
          SizedBox(height: 12.h),
          
          AuthTextField(
            controller: _confirmPasswordController,
            label: 'confirm_password'.tr,
            hint: 'confirm_your_password'.tr,
            prefixIcon: Iconsax.lock,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'confirm_password_required'.tr;
              if (value != _passwordController.text) return 'passwords_dont_match'.tr;
              return null;
            },
          ),
          
          SizedBox(height: 20.h),
          
          // Action buttons row
          Row(
            children: [
              // Back button
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() => _currentStep = 0);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: colors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'back'.tr,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Submit button
              Expanded(
                flex: 2,
                child: Obx(() => AuthPrimaryButton(
                      text: 'create_account'.tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await controller.createAccountWithEmail(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            fullName: _nameController.text.trim(),
                            phoneNumber: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
                            role: _selectedRole,
                          );
                          if (success) {
                            Get.offAllNamed('/home');
                          }
                        }
                      },
                    )),
              ),
            ],
          ),
          
          SizedBox(height: 14.h),
          
          // Login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'already_have_account'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  'sign_in'.tr,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelector(AppColorScheme colors) {
    return Row(
      children: [
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.client,
            icon: Iconsax.user,
            label: 'client'.tr,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.driver,
            icon: Iconsax.car,
            label: 'driver'.tr,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.store,
            icon: Iconsax.shop,
            label: 'store_owner'.tr,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleOption({
    required AppColorScheme colors,
    required UserRole role,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [colors.primary, colors.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : colors.surfaceElevated,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border.withOpacity(0.5),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : colors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isSelected ? Colors.white : colors.primary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: AppTypography.labelSmall(context).copyWith(
                color: isSelected ? Colors.white : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Registration completion form for social/phone auth
class _RegistrationCompletionForm extends StatefulWidget {
  final String idToken;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? photoUrl;
  final String authMethod;

  const _RegistrationCompletionForm({
    required this.idToken,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    required this.authMethod,
  });

  @override
  State<_RegistrationCompletionForm> createState() =>
      _RegistrationCompletionFormState();
}

class _RegistrationCompletionFormState
    extends State<_RegistrationCompletionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  UserRole _selectedRole = UserRole.client;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.displayName ?? '');
    _emailController = TextEditingController(text: widget.email ?? '');
    _phoneController = TextEditingController(text: widget.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Auth method badge
          _buildAuthMethodBadge(context, colors),
          
          SizedBox(height: 18.h),
          
          // Role selector section
          Text(
            'choose_role'.tr,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          _buildRoleSelector(colors),
          
          SizedBox(height: 18.h),
          
          // Name field
          AuthTextField(
            controller: _nameController,
            label: 'full_name'.tr,
            hint: 'enter_your_name'.tr,
            prefixIcon: Iconsax.user,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'name_required'.tr;
              }
              if (value.length < 2) {
                return 'name_too_short'.tr;
              }
              return null;
            },
          ),
          
          SizedBox(height: 12.h),
          
          // Email field (if not from email auth)
          if (widget.authMethod != 'email')
            Column(
              children: [
                AuthTextField(
                  controller: _emailController,
                  label: 'email'.tr,
                  hint: 'enter_your_email'.tr,
                  prefixIcon: Iconsax.sms,
                  keyboardType: TextInputType.emailAddress,
                  enabled: widget.email == null,
                  validator: widget.authMethod == 'phone'
                      ? null // Optional for phone auth
                      : (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!GetUtils.isEmail(value)) {
                              return 'invalid_email'.tr;
                            }
                          }
                          return null;
                        },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          
          // Phone field (if not from phone auth)
          if (widget.authMethod != 'phone')
            Column(
              children: [
                AuthTextField(
                  controller: _phoneController,
                  label: 'phone_number'.tr,
                  hint: 'enter_your_phone'.tr,
                  prefixIcon: Iconsax.call,
                  isPhone: true,
                  textDirection: TextDirection.ltr,
                  enabled: widget.phoneNumber == null,
                  validator: (value) {
                    // Phone is mandatory for drivers
                    if (_selectedRole == UserRole.driver) {
                      if (value == null || value.trim().isEmpty) {
                        return 'phone_required_for_driver'.tr;
                      }
                      if (value.trim().length < 10) {
                        return 'invalid_phone_number'.tr;
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          
          SizedBox(height: 8.h),
          // Submit button
          Obx(() => AuthPrimaryButton(
                text: 'complete_registration'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await controller.completeRegistration(
                      firebaseIdToken: widget.idToken,
                      fullName: _nameController.text.trim(),
                      role: _selectedRole,
                      email: _emailController.text.trim().isNotEmpty
                          ? _emailController.text.trim()
                          : null,
                      phoneNumber: _phoneController.text.trim().isNotEmpty
                          ? _phoneController.text.trim()
                          : null,
                      profilePhotoUrl: widget.photoUrl,
                    );
                    if (success) {
                      Get.offAllNamed('/home');
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildRoleSelector(AppColorScheme colors) {
    return Row(
      children: [
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.client,
            icon: Iconsax.user,
            label: 'client'.tr,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.driver,
            icon: Iconsax.car,
            label: 'driver'.tr,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildRoleOption(
            colors: colors,
            role: UserRole.store,
            icon: Iconsax.shop,
            label: 'store_owner'.tr,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleOption({
    required AppColorScheme colors,
    required UserRole role,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [colors.primary, colors.primary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : colors.surfaceElevated,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border.withOpacity(0.5),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : colors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: isSelected ? Colors.white : colors.primary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: AppTypography.labelSmall(context).copyWith(
                color: isSelected ? Colors.white : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 11.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthMethodBadge(BuildContext context, AppColorScheme colors) {
    IconData icon;
    String text;

    switch (widget.authMethod) {
      case 'google':
        icon = Iconsax.google_1;
        text = 'signed_in_with_google'.tr;
        break;
      case 'phone':
        icon = Iconsax.call;
        text = 'verified_phone'.tr;
        break;
      case 'email':
        icon = Iconsax.sms;
        text = 'verified_email'.tr;
        break;
      default:
        icon = Iconsax.tick_circle;
        text = 'verified'.tr;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: colors.success),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: AppTypography.labelMedium(context).copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.email != null || widget.phoneNumber != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      widget.email ?? widget.phoneNumber ?? '',
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Icon(Iconsax.tick_circle, size: 20.sp, color: colors.success),
        ],
      ),
    );
  }
}
