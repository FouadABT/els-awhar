import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Driver schedule screen for managing availability
class DriverScheduleScreen extends StatelessWidget {
  const DriverScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'driver.schedule.title'.tr,
                  style: AppTypography.headlineLarge(context).copyWith(color: colors.textPrimary),
                ),
              ),
            ),

            // Current availability status
            SliverToBoxAdapter(
              child: _AvailabilityCard(colors: colors),
            ),

            // Working hours today
            SliverToBoxAdapter(
              child: _TodayHoursCard(colors: colors),
            ),

            // Weekly schedule header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Text(
                  'driver.schedule.weekly'.tr,
                  style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
                ),
              ),
            ),

            // Weekly schedule list
            _WeeklySchedule(colors: colors),

            SliverPadding(padding: EdgeInsets.only(bottom: 100.h)),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityCard extends StatefulWidget {
  final AppColorScheme colors;

  const _AvailabilityCard({required this.colors});

  @override
  State<_AvailabilityCard> createState() => _AvailabilityCardState();
}

class _AvailabilityCardState extends State<_AvailabilityCard> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isAvailable
              ? [widget.colors.success, widget.colors.success.withOpacity(0.7)]
              : [widget.colors.textSecondary, widget.colors.textSecondary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: (isAvailable ? widget.colors.success : widget.colors.textSecondary).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAvailable ? 'driver.status.available'.tr : 'driver.status.unavailable'.tr,
                    style: AppTypography.headlineMedium(context).copyWith(color: Colors.white).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    isAvailable
                        ? 'driver.schedule.accepting_rides'.tr
                        : 'driver.schedule.not_accepting'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
              Switch(
                value: isAvailable,
                onChanged: (value) => setState(() => isAvailable = value),
                activeColor: Colors.white,
                activeTrackColor: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TodayHoursCard extends StatelessWidget {
  final AppColorScheme colors;

  const _TodayHoursCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'driver.schedule.today_hours'.tr,
                style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Edit today's schedule
                },
                icon: Icon(Iconsax.edit, color: colors.primary),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _TimeSlot(
                colors: colors,
                label: 'common.start'.tr,
                time: '09:00 AM',
              ),
              SizedBox(width: 20.w),
              Icon(Iconsax.arrow_right_3, color: colors.textSecondary, size: 20.sp),
              SizedBox(width: 20.w),
              _TimeSlot(
                colors: colors,
                label: 'common.end'.tr,
                time: '06:00 PM',
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Iconsax.clock, size: 18.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                '${9} ${'common.hours'.tr} ${'driver.schedule.scheduled'.tr}',
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final AppColorScheme colors;
  final String label;
  final String time;

  const _TimeSlot({
    required this.colors,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
            ),
            SizedBox(height: 6.h),
            Text(
              time,
              style: AppTypography.bodyLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklySchedule extends StatelessWidget {
  final AppColorScheme colors;

  const _WeeklySchedule({required this.colors});

  @override
  Widget build(BuildContext context) {
    final weekDays = [
      {'day': 'common.monday'.tr, 'start': '09:00 AM', 'end': '06:00 PM', 'enabled': true},
      {'day': 'common.tuesday'.tr, 'start': '09:00 AM', 'end': '06:00 PM', 'enabled': true},
      {'day': 'common.wednesday'.tr, 'start': '09:00 AM', 'end': '06:00 PM', 'enabled': true},
      {'day': 'common.thursday'.tr, 'start': '09:00 AM', 'end': '06:00 PM', 'enabled': true},
      {'day': 'common.friday'.tr, 'start': '09:00 AM', 'end': '06:00 PM', 'enabled': true},
      {'day': 'common.saturday'.tr, 'start': '10:00 AM', 'end': '04:00 PM', 'enabled': true},
      {'day': 'common.sunday'.tr, 'start': '', 'end': '', 'enabled': false},
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final day = weekDays[index];
          return _WeekDayCard(
            colors: colors,
            day: day['day'] as String,
            startTime: day['start'] as String,
            endTime: day['end'] as String,
            enabled: day['enabled'] as bool,
          );
        },
        childCount: weekDays.length,
      ),
    );
  }
}

class _WeekDayCard extends StatelessWidget {
  final AppColorScheme colors;
  final String day;
  final String startTime;
  final String endTime;
  final bool enabled;

  const _WeekDayCard({
    required this.colors,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: AppTypography.bodyLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (enabled) ...[
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    startTime,
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '-',
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    endTime,
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Edit schedule for this day
              },
              icon: Icon(Iconsax.edit, color: colors.primary, size: 20.sp),
            ),
          ] else ...[
            Expanded(
              flex: 3,
              child: Text(
                'driver.schedule.off_day'.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              ),
            ),
            IconButton(
              onPressed: () {
                // Enable this day
              },
              icon: Icon(Iconsax.add_circle, color: colors.primary, size: 20.sp),
            ),
          ],
        ],
      ),
    );
  }
}


