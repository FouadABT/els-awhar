import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../app/controllers/locale_controller.dart';
import '../../app/controllers/theme_controller.dart';
import '../../core/localization/app_locales.dart';

/// Floating settings button that expands to show theme and language options
class FloatingSettingsButton extends StatefulWidget {
  const FloatingSettingsButton({super.key});

  @override
  State<FloatingSettingsButton> createState() => _FloatingSettingsButtonState();
}

class _FloatingSettingsButtonState extends State<FloatingSettingsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _close() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Get.locale to check RTL since Directionality might not update immediately
    final currentLocale = Get.locale;
    final isRtl = currentLocale?.languageCode == 'ar';
    final topPadding = MediaQuery.of(context).padding.top + 16.h;

    // Use SizedBox.expand to fill the parent Stack, then position children absolutely
    return SizedBox.expand(
      child: Stack(
        children: [
          // Expanded panel
          if (_isExpanded || _animationController.isAnimating)
            Positioned(
              top: topPadding + 56.h,
              right: isRtl ? null : 16.w,
              left: isRtl ? 16.w : null,
              child: FadeTransition(
                opacity: _expandAnimation,
                child: ScaleTransition(
                  scale: _expandAnimation,
                  alignment: isRtl ? Alignment.topLeft : Alignment.topRight,
                  child: _buildExpandedPanel(context),
                ),
              ),
            ),

          // Main toggle button - always pinned to edge
          Positioned(
            top: topPadding,
            right: isRtl ? null : 16.w,
            left: isRtl ? 16.w : null,
            child: _buildMainButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: _isExpanded ? 12.w : 10.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isExpanded ? Iconsax.close_circle : Iconsax.setting_2,
                color: Theme.of(context).colorScheme.primary,
                size: 20.sp,
              ),
            ),
            if (_isExpanded) ...[
              SizedBox(width: 6.w),
              Text(
                'settings.title'.tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedPanel(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Theme section
          _buildSectionTitle(context, 'settings.theme'.tr, Iconsax.sun_1),
          SizedBox(height: 8.h),
          _buildThemeOptions(context),

          SizedBox(height: 16.h),

          // Language section
          _buildSectionTitle(context, 'settings.language'.tr, Iconsax.global),
          SizedBox(height: 8.h),
          _buildLanguageOptions(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOptions(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              icon: Iconsax.sun_1,
              isSelected: controller.themeMode == AppThemeMode.light,
              onTap: () => controller.setThemeMode(AppThemeMode.light),
            ),
            SizedBox(width: 8.w),
            _buildThemeOption(
              context,
              icon: Iconsax.moon,
              isSelected: controller.themeMode == AppThemeMode.dark,
              onTap: () => controller.setThemeMode(AppThemeMode.dark),
            ),
            SizedBox(width: 8.w),
            _buildThemeOption(
              context,
              icon: Iconsax.autobrightness,
              isSelected: controller.themeMode == AppThemeMode.system,
              onTap: () => controller.setThemeMode(AppThemeMode.system),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _buildLanguageOptions(BuildContext context) {
    return GetBuilder<LocaleController>(
      builder: (controller) {
        return Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: AppLocales.supportedLocales.map((locale) {
            final isSelected = controller.currentLocale.languageCode == locale.languageCode;
            final langCode = locale.languageCode.toUpperCase();

            return GestureDetector(
              onTap: () {
                controller.changeLocale(locale.languageCode);
                // Close panel after selection
                Future.delayed(const Duration(milliseconds: 200), _close);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  langCode,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
