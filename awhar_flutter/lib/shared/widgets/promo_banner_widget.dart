import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/promo_controller.dart';

/// Promo Banner Carousel Widget
///
/// Displays promotional banners in a horizontal carousel
/// Auto-advances and supports user interaction
class PromoBannerWidget extends StatefulWidget {
  final String userRole; // 'client', 'driver', 'store'
  final double? height;
  final EdgeInsets? padding;
  final bool autoPlay;
  final Duration autoPlayDuration;

  const PromoBannerWidget({
    super.key,
    required this.userRole,
    this.height,
    this.padding,
    this.autoPlay = true,
    this.autoPlayDuration = const Duration(seconds: 5),
  });

  @override
  State<PromoBannerWidget> createState() => _PromoBannerWidgetState();
}

class _PromoBannerWidgetState extends State<PromoBannerWidget> {
  late PageController _pageController;
  late PromoController _promoController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);

    // Initialize or get existing controller with role-specific tag
    final tag = 'promo_${widget.userRole}';
    if (Get.isRegistered<PromoController>(tag: tag)) {
      _promoController = Get.find<PromoController>(tag: tag);
    } else {
      _promoController = Get.put(PromoController(), tag: tag);
      // Load promos for user role only once when creating
      _promoController.setUserRole(widget.userRole);
    }

    // Start auto-play if enabled
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    Future.delayed(widget.autoPlayDuration, () {
      if (mounted && _promoController.promos.isNotEmpty) {
        final nextIndex =
            (_promoController.currentIndex.value + 1) %
            _promoController.promos.length;

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final height = widget.height ?? 160.h;

    return Obx(() {
      // Show error if any
      if (_promoController.error.value.isNotEmpty) {
        return Container(
          height: 60.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: colors.errorSoft,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.error, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: colors.error, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Failed to load promos: ${_promoController.error.value}',
                  style: TextStyle(color: colors.error, fontSize: 12.sp),
                ),
              ),
            ],
          ),
        );
      }

      // Show loading
      if (_promoController.isLoading.value && _promoController.promos.isEmpty) {
        return _buildLoadingState(colors, height);
      }

      // Don't show if no promos
      if (_promoController.promos.isEmpty) {
        // Debug: Show a message if no promos
        debugPrint('[PromoBanner] No promos for role: ${widget.userRole}');
        return const SizedBox.shrink();
      }

      return Container(
        padding: widget.padding ?? EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Banner carousel
            SizedBox(
              height: height,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _promoController.promos.length,
                onPageChanged: (index) {
                  _promoController.updateIndex(index);
                  // Record view
                  final promo = _promoController.promos[index];
                  if (promo.id != null) {
                    _promoController.recordView(promo.id!);
                  }
                },
                itemBuilder: (context, index) {
                  final promo = _promoController.promos[index];
                  return _buildPromoCard(context, promo, colors);
                },
              ),
            ),

            // Page indicators
            if (_promoController.promos.length > 1) ...[
              SizedBox(height: 8.h),
              _buildPageIndicators(colors),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildLoadingState(AppColorScheme colors, double height) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: colors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildPromoCard(
    BuildContext context,
    Promo promo,
    AppColorScheme colors,
  ) {
    return GestureDetector(
      onTap: () => _promoController.handlePromoTap(promo),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              CachedNetworkImage(
                imageUrl: promo.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colors.surface,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: colors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.image_not_supported,
                    color: colors.primary,
                    size: 40.sp,
                  ),
                ),
              ),

              // Gradient overlay for text visibility
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        _promoController.getLocalizedTitle(promo),
                        style: AppTypography.titleMedium(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Description (if exists)
                      if (_promoController.getLocalizedDescription(promo) !=
                          null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          _promoController.getLocalizedDescription(promo)!,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Action indicator
              if (promo.actionType != 'none')
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getActionIcon(promo.actionType),
                          size: 12.sp,
                          color: colors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'promo.tap_to_view'.tr,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicators(AppColorScheme colors) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _promoController.promos.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: _promoController.currentIndex.value == index ? 20.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: _promoController.currentIndex.value == index
                  ? colors.primary
                  : colors.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getActionIcon(String actionType) {
    switch (actionType) {
      case 'link':
        return Icons.open_in_new;
      case 'store':
        return Icons.store;
      case 'driver':
        return Icons.person;
      case 'service':
        return Icons.build;
      case 'screen':
        return Icons.arrow_forward;
      default:
        return Icons.touch_app;
    }
  }
}

/// Compact version of promo banner for smaller spaces
class PromoBannerCompact extends StatelessWidget {
  final String userRole;

  const PromoBannerCompact({
    super.key,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return PromoBannerWidget(
      userRole: userRole,
      height: 120.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      autoPlay: true,
    );
  }
}
