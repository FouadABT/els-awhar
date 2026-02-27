import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A card displaying a service suggestion from the AI Concierge.
///
/// Shows the matched service name, confidence level, and a select button.
/// Data comes from ELSER semantic search on awhar-services index.
class ServiceSuggestionCard extends StatelessWidget {
  final String serviceName;
  final int index;
  final AiConfidenceLevel confidence;
  final bool isSelected;
  final VoidCallback onSelect;

  const ServiceSuggestionCard({
    super.key,
    required this.serviceName,
    required this.index,
    required this.confidence,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primarySoft
              : colors.surfaceElevated,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Service icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.primary.withValues(alpha: 0.15)
                    : colors.primarySoft,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _serviceIcon,
                color: colors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Service info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: AppTypography.titleSmall(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      // Confidence badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: _confidenceColor(colors)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          _confidenceLabel,
                          style:
                              AppTypography.labelSmall(context).copyWith(
                            color: _confidenceColor(colors),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // ELSER badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.infoSoft,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'ELSER',
                          style:
                              AppTypography.labelSmall(context).copyWith(
                            color: colors.info,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Select indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
                size: 24.sp,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                color: colors.textMuted,
                size: 14.sp,
              ),
          ],
        ),
      ),
    );
  }

  IconData get _serviceIcon {
    final lower = serviceName.toLowerCase();
    if (lower.contains('move') || lower.contains('déménagement') || lower.contains('نقل')) {
      return Icons.local_shipping;
    }
    if (lower.contains('deliver') || lower.contains('livraison') || lower.contains('توصيل')) {
      return Icons.delivery_dining;
    }
    if (lower.contains('clean') || lower.contains('nettoyage') || lower.contains('تنظيف')) {
      return Icons.cleaning_services;
    }
    if (lower.contains('repair') || lower.contains('réparation') || lower.contains('إصلاح')) {
      return Icons.build;
    }
    if (lower.contains('plumb') || lower.contains('plomberie') || lower.contains('سباكة')) {
      return Icons.plumbing;
    }
    if (lower.contains('electric') || lower.contains('كهرباء')) {
      return Icons.electrical_services;
    }
    if (lower.contains('paint') || lower.contains('peinture') || lower.contains('دهان')) {
      return Icons.format_paint;
    }
    return Icons.miscellaneous_services;
  }

  String get _confidenceLabel {
    switch (confidence) {
      case AiConfidenceLevel.veryHigh:
        return 'concierge_chat.confidence_very_high'.tr;
      case AiConfidenceLevel.high:
        return 'concierge_chat.confidence_high'.tr;
      case AiConfidenceLevel.medium:
        return 'concierge_chat.confidence_medium'.tr;
      case AiConfidenceLevel.low:
        return 'concierge_chat.confidence_low'.tr;
      case AiConfidenceLevel.veryLow:
        return 'concierge_chat.confidence_low'.tr;
    }
  }

  Color _confidenceColor(AppColorScheme colors) {
    switch (confidence) {
      case AiConfidenceLevel.veryHigh:
      case AiConfidenceLevel.high:
        return colors.success;
      case AiConfidenceLevel.medium:
        return colors.warning;
      case AiConfidenceLevel.low:
      case AiConfidenceLevel.veryLow:
        return colors.error;
    }
  }
}
