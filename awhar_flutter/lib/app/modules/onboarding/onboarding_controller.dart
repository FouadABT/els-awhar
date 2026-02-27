import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../core/services/storage_service.dart';
import 'onboarding_model.dart';

/// Controller for onboarding flow
class OnboardingController extends GetxController {
  final StorageService _storageService;

  OnboardingController(this._storageService);

  // Page controller for the PageView
  late PageController pageController;

  // Current page index
  final RxInt currentPage = 0.obs;

  // Onboarding pages data
  final List<OnboardingPageData> pages = const [
    OnboardingPageData(
      titleKey: 'onboarding.screen1_title',
      subtitleKey: 'onboarding.screen1_subtitle',
      imagePath: 'assets/images/onboarding/1.png',
      backgroundStyle: OnboardingBackgroundStyle.discover,
    ),
    OnboardingPageData(
      titleKey: 'onboarding.screen2_title',
      subtitleKey: 'onboarding.screen2_subtitle',
      imagePath: 'assets/images/onboarding/2.png',
      backgroundStyle: OnboardingBackgroundStyle.action,
    ),
    OnboardingPageData(
      titleKey: 'onboarding.screen3_title',
      subtitleKey: 'onboarding.screen3_subtitle',
      imagePath: 'assets/images/onboarding/3.png',
      backgroundStyle: OnboardingBackgroundStyle.trust,
    ),
  ];

  /// Check if this is the last page
  bool get isLastPage => currentPage.value == pages.length - 1;

  /// Check if this is the first page
  bool get isFirstPage => currentPage.value == 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Go to next page
  void nextPage() {
    if (isLastPage) {
      completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Go to previous page
  void previousPage() {
    if (!isFirstPage) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Skip onboarding
  void skipOnboarding() {
    // Skip directly to home as guest
    continueAsGuest();
  }

  /// Continue as guest - go directly to home without login
  void continueAsGuest() {
    _storageService.write('onboarding_completed', true);
    // Go to home - guest mode is now supported
    Get.offAllNamed('/home');
  }

  /// Complete onboarding and navigate to login/register
  void completeOnboarding() {
    _storageService.write('onboarding_completed', true);
    
    // Check if user is authenticated
    final authController = Get.find<AuthController>();
    if (authController.isAuthenticated) {
      // User is logged in, go to home
      Get.offAllNamed('/home');
    } else {
      // User is not logged in, go to login
      Get.offAllNamed('/auth/login');
    }
  }

  /// Update current page index
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  /// Check if onboarding was completed
  static bool isOnboardingCompleted(StorageService storageService) {
    return storageService.read<bool>('onboarding_completed') ?? false;
  }
}
