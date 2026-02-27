import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Trust Score Badge Widget
///
/// Displays a client's trust level as a compact badge with:
/// - Color-coded background (green/blue/yellow/red)
/// - Shield icon with trust level emoji
/// - Trust score number and label
///
/// Three sizes: [TrustBadgeSize.small] for inline, [.medium] for cards,
/// [.large] for profile screens.
///
/// Usage:
/// ```dart
/// TrustBadge(
///   trustScore: 75.0,
///   trustLevel: 'GOOD',
///   size: TrustBadgeSize.medium,
/// )
/// ```
enum TrustBadgeSize { small, medium, large }

class TrustBadge extends StatelessWidget {
  final double trustScore;
  final String trustLevel;
  final TrustBadgeSize size;
  final bool showScore;
  final bool showLabel;
  final VoidCallback? onTap;

  const TrustBadge({
    super.key,
    required this.trustScore,
    required this.trustLevel,
    this.size = TrustBadgeSize.medium,
    this.showScore = true,
    this.showLabel = true,
    this.onTap,
  });

  /// Create from a User object's trust fields
  factory TrustBadge.fromUser({
    Key? key,
    required double? trustScore,
    required String? trustLevel,
    TrustBadgeSize size = TrustBadgeSize.medium,
    bool showScore = true,
    bool showLabel = true,
    VoidCallback? onTap,
  }) {
    return TrustBadge(
      key: key,
      trustScore: trustScore ?? 50.0,
      trustLevel: trustLevel ?? 'FAIR',
      size: size,
      showScore: showScore,
      showLabel: showLabel,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = _getTrustConfig();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: _getPadding(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              config.color.withValues(alpha: 0.15),
              config.color.withValues(alpha: 0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          border: Border.all(
            color: config.color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Shield icon with trust emoji
            _buildIcon(config),
            if (showScore || showLabel) SizedBox(width: _getSpacing()),
            if (showScore || showLabel)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showScore)
                    Text(
                      '${trustScore.round()}',
                      style: TextStyle(
                        fontSize: _getScoreFontSize(),
                        fontWeight: FontWeight.w700,
                        color: config.color,
                        height: 1.1,
                      ),
                    ),
                  if (showLabel)
                    Text(
                      _getLocalizedLabel(config),
                      style: TextStyle(
                        fontSize: _getLabelFontSize(),
                        fontWeight: FontWeight.w500,
                        color: config.color.withValues(alpha: 0.8),
                        height: 1.2,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(_TrustConfig config) {
    final iconSize = _getIconSize();
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Iconsax.shield_tick,
          size: iconSize,
          color: config.color,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Text(
            config.emoji,
            style: TextStyle(fontSize: iconSize * 0.45),
          ),
        ),
      ],
    );
  }

  String _getLocalizedLabel(_TrustConfig config) {
    switch (trustLevel.toUpperCase()) {
      case 'EXCELLENT':
        return 'trust.excellent'.tr;
      case 'GOOD':
        return 'trust.good'.tr;
      case 'FAIR':
        return 'trust.fair'.tr;
      case 'LOW':
        return 'trust.low'.tr;
      default:
        return 'trust.fair'.tr;
    }
  }

  _TrustConfig _getTrustConfig() {
    switch (trustLevel.toUpperCase()) {
      case 'EXCELLENT':
        return _TrustConfig(
          color: const Color(0xFF10B981), // Emerald green
          emoji: '🟢',
          icon: Iconsax.shield_tick,
        );
      case 'GOOD':
        return _TrustConfig(
          color: const Color(0xFF3B82F6), // Blue
          emoji: '🔵',
          icon: Iconsax.shield_tick,
        );
      case 'FAIR':
        return _TrustConfig(
          color: const Color(0xFFF59E0B), // Amber
          emoji: '🟡',
          icon: Iconsax.shield_tick,
        );
      case 'LOW':
        return _TrustConfig(
          color: const Color(0xFFEF4444), // Red
          emoji: '🔴',
          icon: Iconsax.shield_cross,
        );
      default:
        return _TrustConfig(
          color: const Color(0xFF6B7280), // Gray
          emoji: '⚪',
          icon: Iconsax.shield_tick,
        );
    }
  }

  // Size helpers
  EdgeInsets _getPadding() {
    switch (size) {
      case TrustBadgeSize.small:
        return EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h);
      case TrustBadgeSize.medium:
        return EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h);
      case TrustBadgeSize.large:
        return EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case TrustBadgeSize.small:
        return 6.r;
      case TrustBadgeSize.medium:
        return 10.r;
      case TrustBadgeSize.large:
        return 14.r;
    }
  }

  double _getIconSize() {
    switch (size) {
      case TrustBadgeSize.small:
        return 14.sp;
      case TrustBadgeSize.medium:
        return 20.sp;
      case TrustBadgeSize.large:
        return 28.sp;
    }
  }

  double _getScoreFontSize() {
    switch (size) {
      case TrustBadgeSize.small:
        return 11.sp;
      case TrustBadgeSize.medium:
        return 14.sp;
      case TrustBadgeSize.large:
        return 20.sp;
    }
  }

  double _getLabelFontSize() {
    switch (size) {
      case TrustBadgeSize.small:
        return 8.sp;
      case TrustBadgeSize.medium:
        return 10.sp;
      case TrustBadgeSize.large:
        return 13.sp;
    }
  }

  double _getSpacing() {
    switch (size) {
      case TrustBadgeSize.small:
        return 3.w;
      case TrustBadgeSize.medium:
        return 6.w;
      case TrustBadgeSize.large:
        return 8.w;
    }
  }
}

class _TrustConfig {
  final Color color;
  final String emoji;
  final IconData icon;

  const _TrustConfig({
    required this.color,
    required this.emoji,
    required this.icon,
  });
}

/// Expanded trust score card showing full details
/// Used on client profile screens and admin dashboard
class TrustScoreCard extends StatelessWidget {
  final double trustScore;
  final String trustLevel;
  final int totalOrders;
  final int completedOrders;
  final int cancelledOrders;
  final double completionRate;
  final VoidCallback? onRefresh;

  const TrustScoreCard({
    super.key,
    required this.trustScore,
    required this.trustLevel,
    this.totalOrders = 0,
    this.completedOrders = 0,
    this.cancelledOrders = 0,
    this.completionRate = 0.0,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade900.withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Iconsax.shield_tick, size: 20.sp,
                      color: isDark ? Colors.white70 : Colors.grey.shade700),
                  SizedBox(width: 8.w),
                  Text(
                    'trust.title'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              if (onRefresh != null)
                GestureDetector(
                  onTap: onRefresh,
                  child: Icon(Iconsax.refresh, size: 18.sp,
                      color: Colors.grey.shade500),
                ),
            ],
          ),

          SizedBox(height: 16.h),

          // Score + Badge centered
          Row(
            children: [
              // Score circle
              _buildScoreCircle(),
              SizedBox(width: 16.w),
              // Trust badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TrustBadge(
                      trustScore: trustScore,
                      trustLevel: trustLevel,
                      size: TrustBadgeSize.large,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'trust.powered_by_ai'.tr,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Metrics row
          if (totalOrders > 0) ...[
            Divider(color: Colors.grey.shade300.withValues(alpha: 0.3)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric('trust.orders'.tr, '$totalOrders', Colors.blue),
                _buildMetric('trust.completed'.tr, '$completedOrders',
                    const Color(0xFF10B981)),
                _buildMetric('trust.cancelled'.tr, '$cancelledOrders',
                    const Color(0xFFEF4444)),
                _buildMetric('trust.rate'.tr,
                    '${completionRate.toStringAsFixed(0)}%',
                    const Color(0xFF8B5CF6)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreCircle() {
    final config = _getColorForLevel();
    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: trustScore / 100.0,
            strokeWidth: 4.w,
            backgroundColor: config.withValues(alpha: 0.15),
            color: config,
          ),
          Text(
            '${trustScore.round()}',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: config,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Color _getColorForLevel() {
    switch (trustLevel.toUpperCase()) {
      case 'EXCELLENT':
        return const Color(0xFF10B981);
      case 'GOOD':
        return const Color(0xFF3B82F6);
      case 'FAIR':
        return const Color(0xFFF59E0B);
      case 'LOW':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
