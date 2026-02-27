import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_helper.dart';

enum PricingType {
  fixed,
  perKm,
  perHour,
  custom,
}

/// Reusable pricing configuration widget
/// Allows setting different pricing types with validation
class PricingConfigWidget extends StatefulWidget {
  final double? initialBasePrice;
  final double? initialPricePerKm;
  final double? initialPricePerHour;
  final double? initialMinPrice;
  final Function(double? basePrice, double? pricePerKm, double? pricePerHour, double? minPrice) onPricingChanged;

  const PricingConfigWidget({
    super.key,
    this.initialBasePrice,
    this.initialPricePerKm,
    this.initialPricePerHour,
    this.initialMinPrice,
    required this.onPricingChanged,
  });

  @override
  State<PricingConfigWidget> createState() => _PricingConfigWidgetState();
}

class _PricingConfigWidgetState extends State<PricingConfigWidget> {
  late PricingType selectedType;
  late TextEditingController basePriceController;
  late TextEditingController pricePerKmController;
  late TextEditingController pricePerHourController;
  late TextEditingController minPriceController;

  @override
  void initState() {
    super.initState();

    // Determine initial pricing type
    if (widget.initialBasePrice != null && widget.initialPricePerKm == null && widget.initialPricePerHour == null) {
      selectedType = PricingType.fixed;
    } else if (widget.initialPricePerKm != null) {
      selectedType = PricingType.perKm;
    } else if (widget.initialPricePerHour != null) {
      selectedType = PricingType.perHour;
    } else {
      selectedType = PricingType.fixed;
    }

    basePriceController = TextEditingController(
      text: widget.initialBasePrice?.toStringAsFixed(0) ?? '',
    );
    pricePerKmController = TextEditingController(
      text: widget.initialPricePerKm?.toStringAsFixed(0) ?? '',
    );
    pricePerHourController = TextEditingController(
      text: widget.initialPricePerHour?.toStringAsFixed(0) ?? '',
    );
    minPriceController = TextEditingController(
      text: widget.initialMinPrice?.toStringAsFixed(0) ?? '',
    );

    // Add listeners
    basePriceController.addListener(_notifyPriceChange);
    pricePerKmController.addListener(_notifyPriceChange);
    pricePerHourController.addListener(_notifyPriceChange);
    minPriceController.addListener(_notifyPriceChange);
  }

  @override
  void dispose() {
    basePriceController.dispose();
    pricePerKmController.dispose();
    pricePerHourController.dispose();
    minPriceController.dispose();
    super.dispose();
  }

  void _notifyPriceChange() {
    final basePrice = double.tryParse(basePriceController.text);
    final pricePerKm = double.tryParse(pricePerKmController.text);
    final pricePerHour = double.tryParse(pricePerHourController.text);
    final minPrice = double.tryParse(minPriceController.text);

    widget.onPricingChanged(basePrice, pricePerKm, pricePerHour, minPrice);
  }

  void _onPricingTypeChanged(PricingType? type) {
    if (type == null) return;

    setState(() {
      selectedType = type;

      // Clear irrelevant fields based on type
      switch (type) {
        case PricingType.fixed:
          pricePerKmController.clear();
          pricePerHourController.clear();
          break;
        case PricingType.perKm:
          pricePerHourController.clear();
          break;
        case PricingType.perHour:
          pricePerKmController.clear();
          break;
        case PricingType.custom:
          // Keep all fields
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driver.services.pricing_config'.tr,
            style: AppTypography.bodyLarge(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Pricing type selection
          _PricingTypeOption(
            type: PricingType.fixed,
            selectedType: selectedType,
            title: 'driver.services.pricing_fixed'.tr,
            subtitle: 'driver.services.pricing_fixed_desc'.tr,
            colors: colors,
            onChanged: _onPricingTypeChanged,
          ),
          if (selectedType == PricingType.fixed) ...[
            SizedBox(height: 12.h),
            _PriceInput(
              controller: basePriceController,
              label: 'driver.services.base_price'.tr,
              hint: '100',
              colors: colors,
            ),
          ],

          SizedBox(height: 12.h),
          _PricingTypeOption(
            type: PricingType.perKm,
            selectedType: selectedType,
            title: 'driver.services.pricing_per_km'.tr,
            subtitle: 'driver.services.pricing_per_km_desc'.tr,
            colors: colors,
            onChanged: _onPricingTypeChanged,
          ),
          if (selectedType == PricingType.perKm) ...[
            SizedBox(height: 12.h),
            _PriceInput(
              controller: basePriceController,
              label: 'driver.services.base_price'.tr,
              hint: '50',
              colors: colors,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: pricePerKmController,
              label: 'driver.services.price_per_km'.tr,
              hint: '5',
              colors: colors,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: minPriceController,
              label: 'driver.services.min_price'.tr,
              hint: '50',
              colors: colors,
            ),
          ],

          SizedBox(height: 12.h),
          _PricingTypeOption(
            type: PricingType.perHour,
            selectedType: selectedType,
            title: 'driver.services.pricing_per_hour'.tr,
            subtitle: 'driver.services.pricing_per_hour_desc'.tr,
            colors: colors,
            onChanged: _onPricingTypeChanged,
          ),
          if (selectedType == PricingType.perHour) ...[
            SizedBox(height: 12.h),
            _PriceInput(
              controller: basePriceController,
              label: 'driver.services.base_price'.tr,
              hint: '50',
              colors: colors,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: pricePerHourController,
              label: 'driver.services.price_per_hour'.tr,
              hint: '80',
              colors: colors,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: minPriceController,
              label: 'driver.services.min_price'.tr,
              hint: '80',
              colors: colors,
            ),
          ],

          SizedBox(height: 12.h),
          _PricingTypeOption(
            type: PricingType.custom,
            selectedType: selectedType,
            title: 'driver.services.pricing_custom'.tr,
            subtitle: 'driver.services.pricing_custom_desc'.tr,
            colors: colors,
            onChanged: _onPricingTypeChanged,
          ),
          if (selectedType == PricingType.custom) ...[
            SizedBox(height: 12.h),
            _PriceInput(
              controller: basePriceController,
              label: 'driver.services.base_price'.tr,
              hint: '50',
              colors: colors,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: pricePerKmController,
              label: 'driver.services.price_per_km'.tr,
              hint: '5',
              colors: colors,
              isOptional: true,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: pricePerHourController,
              label: 'driver.services.price_per_hour'.tr,
              hint: '80',
              colors: colors,
              isOptional: true,
            ),
            SizedBox(height: 12.h),
            _PriceInput(
              controller: minPriceController,
              label: 'driver.services.min_price'.tr,
              hint: '50',
              colors: colors,
            ),
          ],

          // Price preview
          if (selectedType != PricingType.fixed && basePriceController.text.isNotEmpty)
            _PricePreview(
              selectedType: selectedType,
              basePrice: double.tryParse(basePriceController.text) ?? 0,
              pricePerKm: double.tryParse(pricePerKmController.text) ?? 0,
              pricePerHour: double.tryParse(pricePerHourController.text) ?? 0,
              colors: colors,
            ),
        ],
      ),
    );
  }
}

// ============================================================
// PRICING TYPE OPTION
// ============================================================

class _PricingTypeOption extends StatelessWidget {
  final PricingType type;
  final PricingType selectedType;
  final String title;
  final String subtitle;
  final AppColorScheme colors;
  final Function(PricingType?) onChanged;

  const _PricingTypeOption({
    required this.type,
    required this.selectedType,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PricingType>(
      value: type,
      groupValue: selectedType,
      onChanged: onChanged,
      activeColor: colors.primary,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTypography.bodyMedium(context).copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall(context).copyWith(
          color: colors.textSecondary,
        ),
      ),
    );
  }
}

// ============================================================
// PRICE INPUT
// ============================================================

class _PriceInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final AppColorScheme colors;
  final bool isOptional;

  const _PriceInput({
    required this.controller,
    required this.label,
    required this.hint,
    required this.colors,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
            if (isOptional) ...[
              SizedBox(width: 4.w),
              Text(
                '(${' common.optional'.tr})',
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: CurrencyHelper.code,
            filled: true,
            fillColor: colors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PRICE PREVIEW
// ============================================================

class _PricePreview extends StatelessWidget {
  final PricingType selectedType;
  final double basePrice;
  final double pricePerKm;
  final double pricePerHour;
  final AppColorScheme colors;

  const _PricePreview({
    required this.selectedType,
    required this.basePrice,
    required this.pricePerKm,
    required this.pricePerHour,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    String example = '';

    switch (selectedType) {
      case PricingType.perKm:
        final exampleDistance = 10.0;
        final total = basePrice + (pricePerKm * exampleDistance);
        example = 'driver.services.pricing_example_km'
            .trParams({'distance': '10', 'price': total.toStringAsFixed(0)});
        break;
      case PricingType.perHour:
        final exampleHours = 2.0;
        final total = basePrice + (pricePerHour * exampleHours);
        example = 'driver.services.pricing_example_hour'
            .trParams({'hours': '2', 'price': total.toStringAsFixed(0)});
        break;
      case PricingType.custom:
        example = 'driver.services.pricing_example_custom'.tr;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 20.sp, color: colors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              example,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
