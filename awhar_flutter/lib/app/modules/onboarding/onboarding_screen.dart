import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/language_switcher.dart';
import '../../../shared/widgets/theme_mode_switcher.dart';
import 'onboarding_controller.dart';
import 'onboarding_model.dart';

/// Main onboarding screen
class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with language and theme switchers
            _buildTopBar(context),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPage(
                    data: controller.pages[index],
                  );
                },
              ),
            ),

            // Bottom navigation
            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Language switcher
          const LanguageSwitcher(),

          // Theme switcher
          const ThemeModeSwitcher(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Obx(() {
      final isLastPage = controller.isLastPage;

      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Page indicators
            _buildPageIndicators(context),

            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                // Skip button (only show if not on last page)
                if (!isLastPage)
                  Expanded(
                    child: TextButton(
                      onPressed: controller.skipOnboarding,
                      child: Text(
                        'onboarding.skip'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                if (!isLastPage) SizedBox(width: 16.w),

                // Next / Get Started button
                Expanded(
                  flex: isLastPage ? 1 : 2,
                  child: ElevatedButton(
                    onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Text(
                      isLastPage
                          ? 'onboarding.get_started'.tr
                          : 'onboarding.next'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Continue as guest (only on last page)
            if (isLastPage) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'auth.or'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: controller.continueAsGuest,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Text(
                    'onboarding.continue_as_guest'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildPageIndicators(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.pages.length,
          (index) {
            final isActive = index == controller.currentPage.value;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: isActive ? 24.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          },
        ),
      );
    });
  }
}

/// Individual onboarding page
class _OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context, data.backgroundStyle),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration (bigger)
            Expanded(
              flex: 5,
              child: _buildIllustration(context),
            ),

            // Content card
            Expanded(
              flex: 2,
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Image.asset(
        data.imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback placeholder if image not found
          return _buildPlaceholderIllustration(context);
        },
      ),
    );
  }

  Widget _buildPlaceholderIllustration(BuildContext context) {
    IconData icon;
    switch (data.backgroundStyle) {
      case OnboardingBackgroundStyle.discover:
        icon = Icons.explore_rounded;
        break;
      case OnboardingBackgroundStyle.action:
        icon = Icons.rocket_launch_rounded;
        break;
      case OnboardingBackgroundStyle.trust:
        icon = Icons.verified_user_rounded;
        break;
    }

    return Container(
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 100.sp,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Title
        Text(
          data.titleKey.tr,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16.h),

        // Subtitle
        Text(
          data.subtitleKey.tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getBackgroundColor(BuildContext context, OnboardingBackgroundStyle style) {
    // Use theme background for all slides to maintain consistency
    return Theme.of(context).scaffoldBackgroundColor;
  }
}
