import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../routes/app_routes.dart';
import '../../modules/onboarding/onboarding_controller.dart';
import '../../../core/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _navigateNext();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      setState(() {
        _version = 'v${info.version}+${info.buildNumber}';
      });
    } catch (_) {
      // ignore errors, keep version empty
    }
  }

  Future<void> _navigateNext() async {
    // Small delay for splash visual
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    // Decide next route based on onboarding state
    final storage = Get.find<StorageService>();
    final showOnboarding = !OnboardingController.isOnboardingCompleted(storage);

    if (!mounted) return;
    // First time users go to onboarding
    // Returning users go to home
    Get.offAllNamed(showOnboarding ? AppRoutes.onboarding : AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Fullscreen splash image (9:16), covers entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
            ),
          ),

          // Optional subtle loading indicator centered
          Center(
            child: SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
              ),
            ),
          ),

          // Version number at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 24.h,
            child: Opacity(
              opacity: 0.9,
              child: Text(
                _version.isEmpty ? '' : _version,
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall(context).copyWith(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
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
}
