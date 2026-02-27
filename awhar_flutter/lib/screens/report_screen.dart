import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/controllers/auth_controller.dart';

/// Report Screen
/// Allows users to file a report against another user, store, or order
class ReportScreen extends StatefulWidget {
  final int? driverId;
  final int? clientId;
  final int? storeId;
  final int? orderId;

  const ReportScreen({
    super.key,
    this.driverId,
    this.clientId,
    this.storeId,
    this.orderId,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late final Client _client;
  late final AuthController _auth;

  final RxBool _isSubmitting = false.obs;
  final TextEditingController _descriptionController = TextEditingController();
  ReportReason _selectedReason = ReportReason.other;
  ReporterType _reporterType = ReporterType.client;

  @override
  void initState() {
    super.initState();
    _client = Get.find<Client>();
    _auth = Get.find<AuthController>();
    // Infer reporter type from current user role if available
    final user = _auth.currentUser.value;
    if (user != null) {
      if (user.roles.contains(UserRole.driver)) {
        _reporterType = ReporterType.driver;
      } else if (user.roles.contains(UserRole.client)) {
        _reporterType = ReporterType.client;
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    final userId = _auth.currentUser.value?.id;
    if (userId == null) {
      Get.snackbar('Error', 'You must be signed in to report');
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      Get.snackbar('Description required', 'Please describe the issue briefly');
      return;
    }

    try {
      _isSubmitting.value = true;
      // Use createReportByUserId which accepts user IDs and looks up profile IDs internally
      final report = await _client.report.createReportByUserId(
        reportedByUserId: userId,
        reporterType: _reporterType,
        reportedUserIdAsDriver: widget.driverId,  // Pass user ID, server will look up driver profile
        reportedUserIdAsClient: widget.clientId,  // Pass user ID, server will look up client profile
        reportedStoreId: widget.storeId,          // Pass store ID directly
        reportedOrderId: widget.orderId,
        reportedType: widget.driverId != null
            ? ReporterType.driver
            : widget.clientId != null
                ? ReporterType.client
                : null,
        reportReason: _selectedReason,
        description: _descriptionController.text.trim(),
        evidenceUrls: const [],
      );

      if (report != null) {
        Get.back();
        Get.snackbar('Report submitted', 'Our team will review it shortly',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Failed', 'Could not submit report');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isSubmitting.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('Report',
            style: AppTypography.titleMedium(context)
                .copyWith(color: colors.textPrimary)),
        backgroundColor: colors.surface,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reason',
                style: AppTypography.labelLarge(context)
                    .copyWith(color: colors.textSecondary)),
            SizedBox(height: 8.h),
            DropdownButtonFormField<ReportReason>(
              value: _selectedReason,
              items: ReportReason.values
                  .map((r) => DropdownMenuItem(
                        value: r,
                        child: Text(r.name.replaceAll('_', ' ')),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedReason = val!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 16.h),
            Text('Description',
                style: AppTypography.labelLarge(context)
                    .copyWith(color: colors.textSecondary)),
            SizedBox(height: 8.h),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Describe what happened...',
              ),
            ),
            SizedBox(height: 24.h),
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting.value ? null : _submitReport,
                    icon: _isSubmitting.value
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Iconsax.tick_circle),
                    label: Text(_isSubmitting.value ? 'Submitting...' : 'Submit Report'),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
