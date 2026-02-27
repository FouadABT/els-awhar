import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';

class StoreWorkingHoursScreen extends StatefulWidget {
  const StoreWorkingHoursScreen({super.key});

  @override
  State<StoreWorkingHoursScreen> createState() => _StoreWorkingHoursScreenState();
}

class _StoreWorkingHoursScreenState extends State<StoreWorkingHoursScreen> {
  final StoreController storeController = Get.find<StoreController>();

  final List<String> _dayKeys = const [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  late Map<String, dynamic> workingHours; // day -> {closed: bool, open: HH:mm, close: HH:mm}

  @override
  void initState() {
    super.initState();
    final store = storeController.myStore.value;
    if (store?.workingHours != null && store!.workingHours!.isNotEmpty) {
      try {
        workingHours = Map<String, dynamic>.from(jsonDecode(store.workingHours!));
      } catch (_) {
        workingHours = _defaultHours();
      }
    } else {
      workingHours = _defaultHours();
    }
  }

  Map<String, dynamic> _defaultHours() {
    final map = <String, dynamic>{};
    for (final day in _dayKeys) {
      map[day] = {
        'closed': false,
        'open': '09:00',
        'close': '18:00',
      };
    }
    return map;
  }

  Future<void> _pickTime(String day, bool isOpen) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final initial = _getTimeOfDay(workingHours[day][isOpen ? 'open' : 'close']);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: colors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final formatted = _formatTime(picked);
      setState(() {
        workingHours[day][isOpen ? 'open' : 'close'] = formatted;
        workingHours[day]['closed'] = false; // ensure open if time set
      });
    }
  }

  TimeOfDay _getTimeOfDay(String? hhmm) {
    try {
      final parts = (hhmm ?? '09:00').split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _save() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    // Normalize: ensure each day has open/close if not closed
    for (final day in _dayKeys) {
      final entry = workingHours[day];
      if (entry['closed'] == true) {
        entry['open'] = null;
        entry['close'] = null;
      } else {
        entry['open'] ??= '09:00';
        entry['close'] ??= '18:00';
      }
    }

    final jsonStr = jsonEncode(workingHours);
    final success = await storeController.setWorkingHours(jsonStr);
    if (success) {
      Get.back();
      Get.snackbar(
        'common.success'.tr,
        'store_management.update_store_success'.tr,
        backgroundColor: colors.success,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'common.error'.tr,
        storeController.errorMessage.value.isNotEmpty
            ? storeController.errorMessage.value
            : 'Failed to save working hours',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    final labels = {
      'monday': 'store_detail.monday'.tr,
      'tuesday': 'store_detail.tuesday'.tr,
      'wednesday': 'store_detail.wednesday'.tr,
      'thursday': 'store_detail.thursday'.tr,
      'friday': 'store_detail.friday'.tr,
      'saturday': 'store_detail.saturday'.tr,
      'sunday': 'store_detail.sunday'.tr,
    };

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('store_management.working_hours'.tr),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.refresh),
            tooltip: 'Refresh',
            onPressed: () => setState(() => workingHours = _defaultHours()),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: _dayKeys.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final day = _dayKeys[index];
          final entry = workingHours[day] as Map<String, dynamic>;
          final closed = (entry['closed'] == true);
          final openTime = (entry['open'] as String?) ?? '09:00';
          final closeTime = (entry['close'] as String?) ?? '18:00';

          return Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.clock, size: 18.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        labels[day] ?? day,
                        style: AppTypography.titleSmall(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Switch(
                      value: !closed,
                      onChanged: (val) {
                        setState(() {
                          workingHours[day]['closed'] = !val;
                        });
                      },
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      closed ? 'store_detail.closed'.tr : 'common.active'.tr,
                      style: AppTypography.labelSmall(context).copyWith(
                        color: closed ? colors.error : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                if (!closed)
                  Row(
                    children: [
                      Expanded(
                        child: _TimeButton(
                          label: 'Open',
                          value: openTime,
                          onTap: () => _pickTime(day, true),
                          colors: colors,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _TimeButton(
                          label: 'Close',
                          value: closeTime,
                          onTap: () => _pickTime(day, false),
                          colors: colors,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('common.cancel'.tr),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text('common.save'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final AppColorScheme colors;
  const _TimeButton({
    required this.label,
    required this.value,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Icon(Iconsax.clock, size: 16.sp, color: colors.textSecondary),
            SizedBox(width: 8.w),
            Text(
              '$label: $value',
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
