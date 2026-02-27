import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/service_catalog_controller.dart';

/// Filter bottom sheet for catalog browsing
class CatalogFilterSheet extends StatefulWidget {
  const CatalogFilterSheet({super.key});

  @override
  State<CatalogFilterSheet> createState() => _CatalogFilterSheetState();
}

class _CatalogFilterSheetState extends State<CatalogFilterSheet> {
  final ServiceCatalogController _controller = Get.find();

  // Local state for filter values
  late RxDouble _minPrice;
  late RxDouble _maxPrice;
  late RxDouble _maxDistance;
  late RxDouble _minRating;
  late RxBool _onlineOnly;
  late RxList<int> _selectedCategories;

  @override
  void initState() {
    super.initState();
    // Initialize with current controller values
    _minPrice = _controller.minPrice.value.obs;
    _maxPrice = _controller.maxPrice.value.obs;
    _maxDistance = _controller.maxDistance.value.obs;
    _minRating = _controller.minRating.value.obs;
    _onlineOnly = _controller.onlineOnly.value.obs;
    _selectedCategories = <int>[].obs;
    if (_controller.selectedCategory.value != null) {
      _selectedCategories.add(_controller.selectedCategory.value!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          _buildHeader(context, colors),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceRangeSection(context, colors),
                  SizedBox(height: 24.h),
                  _buildDistanceSection(context, colors),
                  SizedBox(height: 24.h),
                  _buildRatingSection(context, colors),
                  SizedBox(height: 24.h),
                  _buildAvailabilitySection(context, colors),
                  SizedBox(height: 24.h),
                  _buildCategoriesSection(context, colors),
                ],
              ),
            ),
          ),
          _buildActionButtons(context, colors),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context, AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'client.catalog.filter_services'.tr,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: _resetFilters,
            child: Text('common.reset'.tr),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRICE RANGE SECTION
  // ============================================================

  Widget _buildPriceRangeSection(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'client.catalog.price_range'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Obx(() => Text(
                  CurrencyHelper.formatRange(_minPrice.value, _maxPrice.value),
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() => RangeSlider(
              values: RangeValues(_minPrice.value, _maxPrice.value),
              min: 0,
              max: 1000,
              divisions: 20,
              activeColor: colors.primary,
              onChanged: (values) {
                _minPrice.value = values.start;
                _maxPrice.value = values.end;
              },
            )),
      ],
    );
  }

  // ============================================================
  // DISTANCE SECTION
  // ============================================================

  Widget _buildDistanceSection(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'client.catalog.max_distance'.tr,
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Obx(() => Text(
                  '${_maxDistance.value.toInt()} km',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() => Slider(
              value: _maxDistance.value,
              min: 1,
              max: 50,
              divisions: 49,
              activeColor: colors.primary,
              onChanged: (value) => _maxDistance.value = value,
            )),
      ],
    );
  }

  // ============================================================
  // RATING SECTION
  // ============================================================

  Widget _buildRatingSection(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'client.catalog.minimum_rating'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() => Wrap(
              spacing: 8.w,
              children: [
                _buildRatingChip(context, colors, 0, 'common.all'.tr),
                _buildRatingChip(context, colors, 3.0, '3+'),
                _buildRatingChip(context, colors, 4.0, '4+'),
                _buildRatingChip(context, colors, 4.5, '4.5+'),
                _buildRatingChip(context, colors, 5.0, '5'),
              ],
            )),
      ],
    );
  }

  Widget _buildRatingChip(
    BuildContext context,
    AppColorScheme colors,
    double rating,
    String label,
  ) {
    final isSelected = _minRating.value == rating;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.star,
            size: 16.sp,
            color: isSelected ? Colors.white : colors.warning,
          ),
          SizedBox(width: 4.w),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) => _minRating.value = rating,
      backgroundColor: colors.surface,
      selectedColor: colors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : colors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? colors.primary : colors.border,
      ),
    );
  }

  // ============================================================
  // AVAILABILITY SECTION
  // ============================================================

  Widget _buildAvailabilitySection(BuildContext context, AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'client.catalog.availability'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Obx(() => SwitchListTile(
              title: Text(
                'client.catalog.online_only'.tr,
                style: AppTypography.bodyLarge(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              subtitle: Text(
                'client.catalog.online_only_desc'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              value: _onlineOnly.value,
              onChanged: (value) => _onlineOnly.value = value,
              activeColor: colors.primary,
              contentPadding: EdgeInsets.zero,
            )),
      ],
    );
  }

  // ============================================================
  // CATEGORIES SECTION
  // ============================================================

  Widget _buildCategoriesSection(BuildContext context, AppColorScheme colors) {
    return Obx(() {
      if (_controller.categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'client.catalog.categories'.tr,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _controller.categories.map((category) {
              final isSelected =
                  _selectedCategories.contains(category.id);
              return FilterChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    _selectedCategories.clear();
                    _selectedCategories.add(category.id!);
                  } else {
                    _selectedCategories.remove(category.id);
                  }
                },
                backgroundColor: colors.surface,
                selectedColor: colors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : colors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? colors.primary : colors.border,
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================

  Widget _buildActionButtons(BuildContext context, AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.textPrimary,
                  side: BorderSide(color: colors.border),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('common.cancel'.tr),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('client.catalog.apply_filters'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  void _applyFilters() {
    // Update controller with new filter values
    _controller.applyFilters(
      minPrice: _minPrice.value,
      maxPrice: _maxPrice.value,
      maxDistance: _maxDistance.value,
      minRating: _minRating.value,
      onlineOnly: _onlineOnly.value,
    );

    // Update selected category
    if (_selectedCategories.isNotEmpty) {
      final categoryId = _selectedCategories.first;
      final category = _controller.categories
          .firstWhereOrNull((c) => c.id == categoryId);
      _controller.selectCategory(category);
    } else {
      _controller.selectCategory(null);
    }

    Get.back();
  }

  void _resetFilters() {
    _minPrice.value = 0;
    _maxPrice.value = 1000;
    _maxDistance.value = 50;
    _minRating.value = 0;
    _onlineOnly.value = false;
    _selectedCategories.clear();
  }
}
