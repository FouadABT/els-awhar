import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Custom text input field for auth forms
class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool isPhone;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool enabled;
  final int maxLines;
  final TextDirection? textDirection;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.isPhone = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.textDirection,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.labelMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.isPhone
              ? TextInputType.phone
              : widget.isPassword
                  ? TextInputType.visiblePassword
                  : widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          textDirection: widget.textDirection,
          style: AppTypography.bodyLarge(context),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTypography.bodyLarge(context).copyWith(
              color: colors.textSecondary.withValues(alpha: 0.5),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: colors.textSecondary, size: 20.sp)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                      color: colors.textSecondary,
                      size: 20.sp,
                    ),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  )
                : null,
            filled: true,
            fillColor: colors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.error),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}

/// Primary button for auth actions
class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.sp),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Social sign-in button (Google, etc.)
class SocialSignInButton extends StatelessWidget {
  final String text;
  final String? iconAsset;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.text,
    this.iconAsset,
    this.icon,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.surface,
          side: BorderSide(color: colors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  color: colors.textSecondary,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(icon, size: 24.sp, color: colors.textPrimary)
                  else if (iconAsset != null)
                    Image.asset(
                      iconAsset!,
                      width: 24.w,
                      height: 24.w,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Iconsax.global, size: 24.sp, color: colors.textSecondary);
                      },
                    )
                  else
                    Icon(Iconsax.global, size: 24.sp, color: colors.textPrimary),
                  SizedBox(width: 12.w),
                  Text(
                    text,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Text button for secondary actions
class AuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const AuthTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTypography.bodyMedium(context).copyWith(
          color: color ?? colors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Divider with "or" text
class AuthDivider extends StatelessWidget {
  final String text;

  const AuthDivider({
    super.key,
    this.text = 'or',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Row(
      children: [
        Expanded(child: Divider(color: colors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            text,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
        Expanded(child: Divider(color: colors.border)),
      ],
    );
  }
}

/// Error message display
class AuthErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const AuthErrorMessage({
    super.key,
    required this.message,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Iconsax.warning_2, color: colors.error, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.error,
              ),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: Icon(Iconsax.close_circle, color: colors.error, size: 20.sp),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
