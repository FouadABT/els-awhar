import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/driver_location_card.dart';

class DriverSettingsScreen extends StatelessWidget {
  const DriverSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          'settings.driver_settings'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Location Card - NEW
          const DriverLocationCard(),

          SizedBox(height: 16.h),

          // Vehicle Information Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.vehicle_info'.tr,
            icon: Iconsax.car,
            children: [
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.vehicle_type'.tr,
                value: 'Sedan',
                onEdit: () => _showVehicleTypeDialog(context, colors),
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.vehicle_make'.tr,
                value: 'Toyota Corolla',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.vehicle_make'.tr,
                  'Toyota Corolla',
                ),
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.license_plate'.tr,
                value: '42-A-12345',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.license_plate'.tr,
                  '42-A-12345',
                ),
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.year'.tr,
                value: '2020',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.year'.tr,
                  '2020',
                ),
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.color'.tr,
                value: 'White',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.color'.tr,
                  'White',
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Service Areas Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.service_areas'.tr,
            icon: Iconsax.location,
            children: [
              _buildChipRow(
                context: context,
                colors: colors,
                label: 'settings.primary_area'.tr,
                chips: ['Casablanca', 'Rabat'],
                onAdd: () => _showServiceAreaDialog(context, colors),
              ),
              SizedBox(height: 12.h),
              _buildChipRow(
                context: context,
                colors: colors,
                label: 'settings.secondary_areas'.tr,
                chips: ['Mohammedia', 'Temara'],
                onAdd: () => _showServiceAreaDialog(context, colors),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Pricing Preferences Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.pricing'.tr,
            icon: Iconsax.dollar_circle,
            children: [
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.dynamic_pricing'.tr,
                subtitle: 'settings.dynamic_pricing_desc'.tr,
                value: true,
                onChanged: (value) {},
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.base_rate'.tr,
                value: '8 ${CurrencyHelper.symbol}/km',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.base_rate'.tr,
                  '8',
                ),
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.minimum_fare'.tr,
                value: '${CurrencyHelper.format(20)}',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.minimum_fare'.tr,
                  '20',
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Availability Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.availability'.tr,
            icon: Iconsax.clock,
            children: [
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.auto_accept'.tr,
                subtitle: 'settings.auto_accept_desc'.tr,
                value: false,
                onChanged: (value) {},
              ),
              _buildInfoRow(
                context: context,

                colors: colors,
                label: 'settings.max_distance'.tr,
                value: '15 km',
                onEdit: () => _showEditDialog(
                  context,
                  colors,
                  'settings.max_distance'.tr,
                  '15',
                ),
              ),
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.accept_scheduled'.tr,
                subtitle: 'settings.accept_scheduled_desc'.tr,
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Verification Documents Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.documents'.tr,
            icon: Iconsax.document,
            children: [
              _buildDocumentRow(
                context: context,

                colors: colors,
                label: 'settings.drivers_license'.tr,
                status: 'Verified',
                isVerified: true,
                onView: () {},
              ),
              _buildDocumentRow(
                context: context,

                colors: colors,
                label: 'settings.vehicle_registration'.tr,
                status: 'Verified',
                isVerified: true,
                onView: () {},
              ),
              _buildDocumentRow(
                context: context,

                colors: colors,
                label: 'settings.insurance'.tr,
                status: 'Pending',
                isVerified: false,
                onView: () {},
              ),
              _buildDocumentRow(
                context: context,

                colors: colors,
                label: 'settings.background_check'.tr,
                status: 'Not Submitted',
                isVerified: false,
                onView: () {},
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Notifications Section
          _buildSectionCard(
            colors: colors,
            context: context,
            title: 'settings.notifications'.tr,
            icon: Iconsax.notification,
            children: [
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.ride_requests'.tr,
                subtitle: 'settings.ride_requests_desc'.tr,
                value: true,
                onChanged: (value) {},
              ),
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.earnings_updates'.tr,
                subtitle: 'settings.earnings_updates_desc'.tr,
                value: true,
                onChanged: (value) {},
              ),
              _buildSwitchRow(
                context: context,

                colors: colors,
                label: 'settings.promotions'.tr,
                subtitle: 'settings.promotions_desc'.tr,
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required AppColorScheme colors,
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colors.primarySoft,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(icon, color: colors.primary, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: colors.divider, height: 1),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required AppColorScheme colors,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Iconsax.edit, color: colors.primary, size: 20.sp),
            onPressed: onEdit,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildChipRow({
    required BuildContext context,
    required AppColorScheme colors,
    required String label,
    required List<String> chips,
    required VoidCallback onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            ...chips.map(
              (chip) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      chip,
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Iconsax.close_circle,
                      color: colors.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: onAdd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.add, color: colors.textSecondary, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'common.add'.tr,
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchRow({
    required BuildContext context,
    required AppColorScheme colors,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow({
    required BuildContext context,
    required AppColorScheme colors,
    required String label,
    required String status,
    required bool isVerified,
    required VoidCallback onView,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(
            isVerified ? Iconsax.tick_circle : Iconsax.info_circle,
            color: isVerified ? colors.success : colors.warning,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  status,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: isVerified ? colors.success : colors.warning,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onView,
            child: Text(
              'common.view'.tr,
              style: TextStyle(color: colors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    AppColorScheme colors,
    String title,
    String currentValue,
  ) {
    final controller = TextEditingController(text: currentValue);

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          title,
          style: TextStyle(color: colors.textPrimary),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: 'common.enter'.tr,
            hintStyle: TextStyle(color: colors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr,
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Save value
              Get.back();
              Get.snackbar(
                'common.success'.tr,
                'settings.updated'.tr,
                backgroundColor: colors.success,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
            child: Text('common.save'.tr),
          ),
        ],
      ),
    );
  }

  void _showVehicleTypeDialog(BuildContext context, AppColorScheme colors) {
    final types = ['Sedan', 'SUV', 'Van', 'Motorcycle'];

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'settings.vehicle_type'.tr,
          style: TextStyle(color: colors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: types
              .map(
                (type) => ListTile(
                  title: Text(
                    type,
                    style: TextStyle(color: colors.textPrimary),
                  ),
                  onTap: () {
                    Get.back();
                    Get.snackbar(
                      'common.success'.tr,
                      'settings.updated'.tr,
                      backgroundColor: colors.success,
                      colorText: Colors.white,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showServiceAreaDialog(BuildContext context, AppColorScheme colors) {
    final areas = [
      'Casablanca',
      'Rabat',
      'Marrakech',
      'Fes',
      'Tangier',
      'Agadir',
    ];

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'settings.service_areas'.tr,
          style: TextStyle(color: colors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: areas
              .map(
                (area) => ListTile(
                  title: Text(
                    area,
                    style: TextStyle(color: colors.textPrimary),
                  ),
                  onTap: () {
                    Get.back();
                    Get.snackbar(
                      'common.success'.tr,
                      'settings.area_added'.tr,
                      backgroundColor: colors.success,
                      colorText: Colors.white,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
