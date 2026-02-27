import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Role selector widget for registration
/// Allows user to choose between Client, Driver, and Store roles
class RoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final Function(UserRole) onRoleChanged;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'choose_role'.tr,
          style: AppTypography.labelMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 12.h),
        // First row: Client and Driver
        Row(
          children: [
            Expanded(
              child: _RoleCard(
                role: UserRole.client,
                title: 'client'.tr,
                description: 'client_description'.tr,
                icon: Iconsax.user,
                isSelected: selectedRole == UserRole.client,
                onTap: () => onRoleChanged(UserRole.client),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _RoleCard(
                role: UserRole.driver,
                title: 'driver'.tr,
                description: 'driver_description'.tr,
                icon: Iconsax.car,
                isSelected: selectedRole == UserRole.driver,
                onTap: () => onRoleChanged(UserRole.driver),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Second row: Store (full width)
        _RoleCard(
          role: UserRole.store,
          title: 'store'.tr,
          description: 'store_description'.tr,
          icon: Iconsax.shop,
          isSelected: selectedRole == UserRole.store,
          onTap: () => onRoleChanged(UserRole.store),
          isFullWidth: true,
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final UserRole role;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFullWidth;

  const _RoleCard({
    required this.role,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isFullWidth ? 20.w : 16.w),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: isFullWidth ? _buildHorizontalLayout(context, colors) : _buildVerticalLayout(context, colors),
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context, dynamic colors) {
    return Column(
          children: [
            // Icon with animated background
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.primary
                    : colors.textSecondary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 28.sp,
                color: isSelected ? Colors.white : colors.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            // Title
            Text(
              title,
              style: AppTypography.labelLarge(context).copyWith(
                color: isSelected ? colors.primary : colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            // Description
            Text(
              description,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // Selection indicator
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 1.0 : 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.tick_circle, size: 14.sp, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text(
                      'selected'.tr,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, dynamic colors) {
    return Row(
      children: [
        // Icon with animated background
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primary
                : colors.textSecondary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 28.sp,
            color: isSelected ? Colors.white : colors.textSecondary,
          ),
        ),
        SizedBox(width: 16.w),
        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelLarge(context).copyWith(
                  color: isSelected ? colors.primary : colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Selection indicator
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isSelected ? 1.0 : 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Iconsax.tick_circle, size: 20.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

/// Compact role selector for inline use
class RoleSelectorCompact extends StatelessWidget {
  final UserRole selectedRole;
  final Function(UserRole) onRoleChanged;

  const RoleSelectorCompact({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _CompactRoleOption(
              role: UserRole.client,
              title: 'client'.tr,
              icon: Iconsax.user,
              isSelected: selectedRole == UserRole.client,
              onTap: () => onRoleChanged(UserRole.client),
              isFirst: true,
            ),
          ),
          Container(width: 1, height: 48.h, color: colors.border),
          Expanded(
            child: _CompactRoleOption(
              role: UserRole.driver,
              title: 'driver'.tr,
              icon: Iconsax.car,
              isSelected: selectedRole == UserRole.driver,
              onTap: () => onRoleChanged(UserRole.driver),
              isFirst: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactRoleOption extends StatelessWidget {
  final UserRole role;
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;

  const _CompactRoleOption({
    required this.role,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? Radius.circular(11.r) : Radius.zero,
            right: isFirst ? Radius.zero : Radius.circular(11.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? colors.primary : colors.textSecondary,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTypography.labelMedium(context).copyWith(
                color: isSelected ? colors.primary : colors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
