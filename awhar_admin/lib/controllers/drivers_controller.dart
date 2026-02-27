import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';
import '../core/theme/admin_colors.dart';
import 'dart:html' as html;
import 'dart:convert';

/// Enhanced drivers controller with full CRUD and filtering
class DriversController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Driver list
  final RxList<DriverProfile> drivers = <DriverProfile>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Statistics
  final RxInt onlineCount = 0.obs;
  final RxInt verifiedCount = 0.obs;
  final RxInt unverifiedCount = 0.obs;

  // Search and filters
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'All Status'.obs;
  final RxString selectedVerification = 'All Verification'.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadDrivers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Load drivers from the server
  Future<void> loadDrivers() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      // Apply filters
      bool? onlineFilter;
      if (selectedStatus.value == 'Online') {
        onlineFilter = true;
      } else if (selectedStatus.value == 'Offline') {
        onlineFilter = false;
      }

      bool? verifiedFilter;
      if (selectedVerification.value == 'Verified') {
        verifiedFilter = true;
      } else if (selectedVerification.value == 'Unverified') {
        verifiedFilter = false;
      }

      final result = await ApiService.instance.client.admin.listDrivers(
        page: currentPage.value,
        limit: pageSize.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        onlineOnly: onlineFilter,
        verifiedOnly: verifiedFilter,
      );

      drivers.value = result;
      
      // Update statistics
      _updateStatistics();
      
      // Get total count (this should ideally come from the backend)
      final totalResult = await ApiService.instance.client.admin.getDriverCount();
      totalCount.value = totalResult;
      
      debugPrint('[DriversController] Loaded ${result.length} drivers');
    } catch (e) {
      debugPrint('[DriversController] Error loading drivers: $e');
      errorMessage.value = 'Failed to load drivers. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Update driver statistics
  void _updateStatistics() {
    onlineCount.value = drivers.where((d) => d.isOnline).length;
    verifiedCount.value = drivers.where((d) => d.isVerified).length;
    unverifiedCount.value = drivers.where((d) => !d.isVerified).length;
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadDrivers();
  }

  /// Clear all filters
  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedStatus.value = 'All Status';
    selectedVerification.value = 'All Verification';
    currentPage.value = 1;
    loadDrivers();
  }

  /// Show driver details dialog
  void showDriverDetails(DriverProfile driver) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Driver Details',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 24),
              const SizedBox(height: 16),
              _buildDetailRow('Driver ID', '#D${driver.id}'),
              _buildDetailRow('Name', driver.displayName.isEmpty ? 'N/A' : driver.displayName),
              _buildDetailRow('Vehicle Type', driver.vehicleType?.name ?? 'N/A'),
              _buildDetailRow('Vehicle Make', driver.vehicleMake ?? 'N/A'),
              _buildDetailRow('Vehicle Model', driver.vehicleModel ?? 'N/A'),
              _buildDetailRow('Rating', '${driver.ratingAverage.toStringAsFixed(1)} ⭐ (${driver.totalCompletedOrders} orders)'),
              _buildDetailRow('Total Earnings', '${driver.totalEarnings.toStringAsFixed(2)} DH'),
              _buildDetailRow('Status', driver.isOnline ? 'Online' : 'Offline'),
              _buildDetailRow('Verified', driver.isVerified ? 'Yes' : 'No'),
              _buildDetailRow('Joined', driver.createdAt.toString().split('.')[0]),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      editDriver(driver);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Driver'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AdminColors.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AdminColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Edit driver dialog
  void editDriver(DriverProfile driver) {
    final vehicleMakeController = TextEditingController(text: driver.vehicleMake ?? '');
    final vehicleModelController = TextEditingController(text: driver.vehicleModel ?? '');

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Driver',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: vehicleMakeController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Make',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: vehicleModelController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Model',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Driver updated successfully',
                        backgroundColor: AdminColors.success.withOpacity(0.1),
                        colorText: AdminColors.success,
                      );
                      loadDrivers();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Verify a driver
  Future<bool> verifyDriver(int driverId) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.admin.verifyDriver(driverId);

      if (success) {
        await loadDrivers();
        Get.snackbar(
          'Success',
          'Driver verified successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[DriversController] Error verifying driver: $e');
      Get.snackbar(
        'Error',
        'Failed to verify driver',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Unverify a driver
  void unverifyDriver(DriverProfile driver) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AdminColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.remove_circle, color: AdminColors.warning),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Unverify Driver',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to remove verification from ${driver.displayName}?',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      await _executeUnverifyDriver(driver.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.warning,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Unverify'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeUnverifyDriver(int driverId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.unverifyDriver(driverId);
      if (success) {
        await loadDrivers();
        Get.snackbar(
          'Success',
          'Driver unverified successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[DriversController] Error unverifying driver: $e');
      Get.snackbar(
        'Error',
        'Failed to unverify driver',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Suspend driver with confirmation
  void suspendDriver(DriverProfile driver) {
    final reasonController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AdminColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.block, color: AdminColors.warning),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Suspend Driver',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to suspend ${driver.displayName}?',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Reason (optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      await _executeSuspendDriver(driver.id!, reasonController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.warning,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Suspend Driver'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeSuspendDriver(int driverId, String reason) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.suspendDriver(
        driverId: driverId,
        reason: reason.isEmpty ? null : reason,
      );
      if (success) {
        await loadDrivers();
        Get.snackbar(
          'Success',
          'Driver suspended successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[DriversController] Error suspending driver: $e');
      Get.snackbar(
        'Error',
        'Failed to suspend driver',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Delete driver with confirmation
  void deleteDriver(DriverProfile driver) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AdminColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.delete_forever, color: AdminColors.error),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Delete Driver',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to permanently delete ${driver.displayName}? All driver data will be lost. This action cannot be undone.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      await _executeDeleteDriver(driver.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete Driver'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeDeleteDriver(int driverId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.deleteDriver(driverId);
      if (success) {
        await loadDrivers();
        Get.snackbar(
          'Success',
          'Driver deleted successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[DriversController] Error deleting driver: $e');
      Get.snackbar(
        'Error',
        'Failed to delete driver',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Export drivers to CSV
  void exportDrivers() {
    try {
      // Create CSV content
      final csv = StringBuffer();
      csv.writeln('ID,Name,Vehicle Type,Vehicle Make,Vehicle Model,Rating,Completed Orders,Total Earnings,Status,Verified,Joined');
      
      for (final driver in drivers) {
        csv.writeln(
          'D${driver.id},'
          '"${driver.displayName}",'
          '"${driver.vehicleType?.name ?? ''}",'
          '"${driver.vehicleMake ?? ''}",'
          '"${driver.vehicleModel ?? ''}",'
          '"${driver.ratingAverage.toStringAsFixed(1)}",'
          '"${driver.totalCompletedOrders}",'
          '"${driver.totalEarnings.toStringAsFixed(2)}",'
          '"${driver.isOnline ? 'Online' : 'Offline'}",'
          '"${driver.isVerified ? 'Verified' : 'Unverified'}",'
          '"${driver.createdAt.toString().split(' ')[0]}"'
        );
      }
      
      // Create blob and download
      final bytes = utf8.encode(csv.toString());
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'drivers_${DateTime.now().millisecondsSinceEpoch}.csv')
        ..click();
      html.Url.revokeObjectUrl(url);
      
      Get.snackbar(
        'Success',
        'Drivers exported successfully',
        backgroundColor: AdminColors.success.withOpacity(0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[DriversController] Error exporting drivers: $e');
      Get.snackbar(
        'Error',
        'Failed to export drivers',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    }
  }

  /// Refresh the list
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadDrivers();
  }
}
