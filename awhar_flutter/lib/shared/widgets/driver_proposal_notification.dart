import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/geo_utils.dart';

/// Beautiful animated driver proposal notification that slides from top
/// Shows driver info, countdown timer, and accept/reject actions
class DriverProposalNotification extends StatefulWidget {
  final ServiceRequest request;
  final User? driverUser;
  final VoidCallback onDismiss;
  final Function(ServiceRequest request) onAccept;
  final Function(ServiceRequest request) onReject;
  final int durationSeconds;

  const DriverProposalNotification({
    super.key,
    required this.request,
    this.driverUser,
    required this.onDismiss,
    required this.onAccept,
    required this.onReject,
    this.durationSeconds = 15,
  });

  @override
  State<DriverProposalNotification> createState() => _DriverProposalNotificationState();
}

class _DriverProposalNotificationState extends State<DriverProposalNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _dismissTimer;
  Timer? _countdownTimer;
  final RxInt remainingSeconds = 0.obs;
  final RxBool isProcessing = false.obs;

  @override
  void initState() {
    super.initState();
    remainingSeconds.value = widget.durationSeconds;

    // Animation controller for slide in/out
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Start slide in animation
    _animController.forward();

    // Start countdown timer
    _startCountdown();

    // Auto dismiss after duration
    _dismissTimer = Timer(Duration(seconds: widget.durationSeconds), () {
      _dismiss();
    });
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _dismiss() async {
    _countdownTimer?.cancel();
    _dismissTimer?.cancel();
    await _animController.reverse();
    widget.onDismiss();
  }

  Future<void> _handleAccept() async {
    if (isProcessing.value) return;
    isProcessing.value = true;
    _countdownTimer?.cancel();
    _dismissTimer?.cancel();
    
    await widget.onAccept(widget.request);
    await _dismiss();
  }

  Future<void> _handleReject() async {
    if (isProcessing.value) return;
    isProcessing.value = true;
    _countdownTimer?.cancel();
    _dismissTimer?.cancel();
    
    await widget.onReject(widget.request);
    await _dismiss();
  }

  double? _calculateDistance() {
    // Calculate distance between driver current location and pickup
    if (widget.driverUser?.currentLatitude == null ||
        widget.driverUser?.currentLongitude == null ||
        widget.request.pickupLocation == null) {
      return null; // Return null if locations not available
    }

    return GeoUtils.calculateDistance(
      lat1: widget.driverUser!.currentLatitude!,
      lon1: widget.driverUser!.currentLongitude!,
      lat2: widget.request.pickupLocation!.latitude,
      lon2: widget.request.pickupLocation!.longitude,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _countdownTimer?.cancel();
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -100 * (1 - _slideAnimation.value)),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: SafeArea(child: child!),
          ),
        );
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(20.r),
            color: colors.surface,
            shadowColor: Colors.black.withValues(alpha: 0.3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.primary.withValues(alpha: 0.05),
                    colors.surface,
                  ],
                ),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with countdown
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.r),
                        topRight: Radius.circular(18.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Pulsing icon
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.8, end: 1.2),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: colors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.primary.withValues(alpha: 0.4),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Iconsax.car,
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                            );
                          },
                          onEnd: () {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver Available!',
                                style: AppTypography.titleMedium(context).copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Review and respond quickly',
                                style: AppTypography.bodySmall(context).copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Circular countdown timer
                        Obx(() => _buildCountdownTimer(colors)),
                      ],
                    ),
                  ),

                  // Driver info card
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        // Driver avatar with online indicator
                        Stack(
                          children: [
                            Container(
                              width: 60.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    colors.primary,
                                    colors.primary.withValues(alpha: 0.6),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Iconsax.user,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            ),
                            // Online indicator
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 16.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  color: colors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: colors.surface,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),

                        // Driver details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.request.proposedDriverName ?? 'Driver',
                                style: AppTypography.titleMedium(context).copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              // Rating
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.star_1,
                                    color: colors.warning,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    widget.driverUser?.averageRating != null
                                        ? widget.driverUser!.averageRating!.toStringAsFixed(1)
                                        : 'New',
                                    style: AppTypography.bodyMedium(context).copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      widget.driverUser?.totalTrips != null && widget.driverUser!.totalTrips! > 0
                                          ? '(${widget.driverUser!.totalTrips} trips)'
                                          : '(No trips yet)',
                                      style: AppTypography.bodySmall(context).copyWith(
                                        color: colors.textSecondary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              // Distance
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.location,
                                    color: colors.info,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      _calculateDistance() != null
                                          ? GeoUtils.formatDistance(_calculateDistance()!)
                                          : 'Calculating...',
                                      style: AppTypography.bodySmall(context).copyWith(
                                        color: colors.info,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Phone button
                        if (widget.request.proposedDriverPhone != null)
                          IconButton(
                            onPressed: () {
                              // TODO: Launch phone call
                            },
                            icon: Icon(
                              Iconsax.call,
                              color: colors.success,
                              size: 24.sp,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: colors.success.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Divider
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(color: colors.border, height: 1),
                  ),

                  // Action buttons
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Obx(
                      () => Row(
                        children: [
                          // Reject button
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: OutlinedButton(
                                onPressed: isProcessing.value ? null : _handleReject,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: colors.error,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Iconsax.close_circle,
                                        color: colors.error,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        'Reject',
                                        style: AppTypography.titleSmall(context).copyWith(
                                          color: colors.error,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Accept button
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: isProcessing.value ? null : _handleAccept,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colors.success,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: isProcessing.value
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Iconsax.tick_circle,
                                              color: Colors.white,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              'Accept Driver',
                                              style: AppTypography.titleSmall(context).copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ), // Material
      ), // Padding
    ); // AnimatedBuilder
  }

  Widget _buildCountdownTimer(AppColorScheme colors) {
    final progress = remainingSeconds.value / widget.durationSeconds;
    
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: 50.w,
            height: 50.h,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 3,
              color: colors.border,
              backgroundColor: Colors.transparent,
            ),
          ),
          // Progress circle
          SizedBox(
            width: 50.w,
            height: 50.h,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: progress, end: progress),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: -math.pi / 2,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 3,
                    color: _getCountdownColor(colors, remainingSeconds.value),
                    backgroundColor: Colors.transparent,
                    strokeCap: StrokeCap.round,
                  ),
                );
              },
            ),
          ),
          // Countdown number
          Text(
            '${remainingSeconds.value}',
            style: AppTypography.titleSmall(context).copyWith(
              color: _getCountdownColor(colors, remainingSeconds.value),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCountdownColor(AppColorScheme colors, int seconds) {
    if (seconds <= 5) return colors.error;
    if (seconds <= 10) return colors.warning;
    return colors.success;
  }
}
