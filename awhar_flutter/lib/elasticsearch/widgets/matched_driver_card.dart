import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

/// A matched driver card that slides in from the bottom with a spring animation.
/// Shows driver name, rating, distance, match score, and why they matched.
class MatchedDriverCard extends StatefulWidget {
  final String driverName;
  final double? rating;
  final double? distanceKm;
  final int? matchScore;
  final String? matchReason;
  final String? vehicleType;
  final String? profilePhotoUrl;
  final bool isTopPick;
  final int animationIndex;

  const MatchedDriverCard({
    super.key,
    required this.driverName,
    this.rating,
    this.distanceKm,
    this.matchScore,
    this.matchReason,
    this.vehicleType,
    this.profilePhotoUrl,
    this.isTopPick = false,
    this.animationIndex = 0,
  });

  @override
  State<MatchedDriverCard> createState() => _MatchedDriverCardState();
}

class _MatchedDriverCardState extends State<MatchedDriverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Staggered start
    Future.delayed(
      Duration(milliseconds: widget.animationIndex * 200),
      () {
        if (mounted) _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: widget.isTopPick
                ? colors.primary.withValues(alpha: 0.4)
                : colors.border.withValues(alpha: 0.3),
            width: widget.isTopPick ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isTopPick
                  ? colors.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            _buildAvatar(colors),
            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name + badge
                  Row(
                    children: [
                      if (widget.isTopPick) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [colors.primary, colors.primaryHover],
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '🏆 BEST',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                      ],
                      Expanded(
                        child: Text(
                          widget.driverName,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Stats row
                  Row(
                    children: [
                      if (widget.rating != null) ...[
                        Icon(Icons.star_rounded,
                            size: 14.sp, color: const Color(0xFFF5A623)),
                        SizedBox(width: 2.w),
                        Text(
                          widget.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                      if (widget.distanceKm != null) ...[
                        Icon(Icons.location_on_rounded,
                            size: 13.sp, color: colors.info),
                        SizedBox(width: 2.w),
                        Text(
                          '${widget.distanceKm!.toStringAsFixed(1)} km',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                      if (widget.vehicleType != null) ...[
                        Text(
                          _vehicleEmoji(widget.vehicleType!),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          widget.vehicleType!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Match reason
                  if (widget.matchReason != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      widget.matchReason!,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: colors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Match score
            if (widget.matchScore != null)
              _buildMatchScoreBadge(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(AppColorScheme colors) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isTopPick
              ? [colors.primary, colors.primaryHover]
              : [colors.borderSoft, colors.border],
        ),
        border: Border.all(
          color: widget.isTopPick
              ? colors.primary.withValues(alpha: 0.5)
              : colors.border,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          widget.driverName.isNotEmpty
              ? widget.driverName[0].toUpperCase()
              : '?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: widget.isTopPick ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchScoreBadge(AppColorScheme colors) {
    final score = widget.matchScore!;
    final scoreColor = score >= 80
        ? colors.success
        : score >= 60
            ? colors.warning
            : colors.info;

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scoreColor.withValues(alpha: 0.1),
        border: Border.all(
          color: scoreColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$score',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: scoreColor,
              height: 1,
            ),
          ),
          Text(
            '%',
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              color: scoreColor.withValues(alpha: 0.7),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  String _vehicleEmoji(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return '🚗';
      case 'motorcycle':
      case 'moto':
        return '🏍️';
      case 'van':
      case 'truck':
        return '🚐';
      case 'bicycle':
      case 'bike':
        return '🚲';
      default:
        return '🚗';
    }
  }
}
