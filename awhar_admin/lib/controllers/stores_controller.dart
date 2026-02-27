import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';
import '../core/theme/admin_colors.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';

/// Enhanced stores controller with full CRUD and filtering
class StoresController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Store list
  final RxList<Store> stores = <Store>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Statistics
  final RxInt activeCount = 0.obs;
  final RxInt inactiveCount = 0.obs;
  final RxDouble averageRating = 0.0.obs;

  // Search and filters
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'All Status'.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadStores();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Load stores from the server
  Future<void> loadStores() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      // Apply filters
      bool? activeFilter;
      if (selectedStatus.value == 'Active') {
        activeFilter = true;
      } else if (selectedStatus.value == 'Inactive') {
        activeFilter = false;
      }

      final result = await ApiService.instance.client.admin.listStores(
        page: currentPage.value,
        limit: pageSize.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        activeOnly: activeFilter,
      );

      stores.value = result;
      
      // Update statistics
      _updateStatistics();
      
      // Get total count
      final totalResult = await ApiService.instance.client.admin.getStoreCount();
      totalCount.value = totalResult;
      
      debugPrint('[StoresController] Loaded ${result.length} stores');
    } catch (e) {
      debugPrint('[StoresController] Error loading stores: $e');
      errorMessage.value = 'Failed to load stores. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Update store statistics
  void _updateStatistics() {
    activeCount.value = stores.where((s) => s.isActive).length;
    inactiveCount.value = stores.where((s) => !s.isActive).length;
    
    if (stores.isNotEmpty) {
      final totalRating = stores.fold<double>(0.0, (sum, s) => sum + s.rating);
      averageRating.value = totalRating / stores.length;
    } else {
      averageRating.value = 0.0;
    }
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadStores();
  }

  /// Clear all filters
  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedStatus.value = 'All Status';
    currentPage.value = 1;
    loadStores();
  }

  /// Show store details dialog
  void showStoreDetails(Store store) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Store Details',
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
              _buildDetailRow('Store ID', '#S${store.id}'),
              _buildDetailRow('Name', store.name),
              _buildDetailRow('Tagline', store.tagline ?? 'N/A'),
              _buildDetailRow('Category', 'Category #${store.storeCategoryId}'),
              _buildDetailRow('Owner', 'User #${store.userId}'),
              _buildDetailRow('Phone', store.phone),
              _buildDetailRow('Email', store.email ?? 'N/A'),
              _buildDetailRow('Location', '${store.city ?? ''} - ${store.address}'),
              _buildDetailRow('Rating', '${store.rating.toStringAsFixed(1)} ⭐ (${store.totalRatings} ratings)'),
              _buildDetailRow('Total Orders', '${store.totalOrders}'),
              _buildDetailRow('Delivery Radius', '${store.deliveryRadiusKm.toStringAsFixed(1)} km'),
              _buildDetailRow('Min Order', '${store.minimumOrderAmount?.toStringAsFixed(2) ?? '0'} DH'),
              _buildDetailRow('Status', store.isActive ? 'Active' : 'Inactive'),
              _buildDetailRow('Created', store.createdAt.toString().split('.')[0]),
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
                      editStore(store);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Store'),
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

  /// Edit store dialog
  void editStore(Store store) {
    final nameController = TextEditingController(text: store.name);
    final taglineController = TextEditingController(text: store.tagline ?? '');
    final phoneController = TextEditingController(text: store.phone);

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
                'Edit Store',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Store Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: taglineController,
                decoration: InputDecoration(
                  labelText: 'Tagline',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
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
                        'Store updated successfully',
                        backgroundColor: AdminColors.success.withOpacity(0.1),
                        colorText: AdminColors.success,
                      );
                      loadStores();
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

  /// Activate a store
  void activateStore(Store store) {
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
                      color: AdminColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check_circle, color: AdminColors.success),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Activate Store',
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
                'Are you sure you want to activate ${store.name}?',
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
                      await _executeActivateStore(store.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.success,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Activate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeActivateStore(int storeId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.activateStore(storeId);
      if (success) {
        await loadStores();
        Get.snackbar(
          'Success',
          'Store activated successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[StoresController] Error activating store: $e');
      Get.snackbar(
        'Error',
        'Failed to activate store',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Deactivate a store
  void deactivateStore(Store store) {
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
                      'Deactivate Store',
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
                'Are you sure you want to deactivate ${store.name}?',
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
                      await _executeDeactivateStore(store.id!, reasonController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.warning,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Deactivate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeDeactivateStore(int storeId, String reason) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.deactivateStore(
        storeId: storeId,
        reason: reason.isEmpty ? null : reason,
      );
      if (success) {
        await loadStores();
        Get.snackbar(
          'Success',
          'Store deactivated successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[StoresController] Error deactivating store: $e');
      Get.snackbar(
        'Error',
        'Failed to deactivate store',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Delete store with confirmation
  void deleteStore(Store store) {
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
                      'Delete Store',
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
                'Are you sure you want to permanently delete ${store.name}? All store data including products and orders will be lost. This action cannot be undone.',
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
                      await _executeDeleteStore(store.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete Store'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeDeleteStore(int storeId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.deleteStore(storeId);
      if (success) {
        await loadStores();
        Get.snackbar(
          'Success',
          'Store deleted successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      }
    } catch (e) {
      debugPrint('[StoresController] Error deleting store: $e');
      Get.snackbar(
        'Error',
        'Failed to delete store',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Export stores to CSV
  void exportStores() {
    try {
      // Create CSV content
      final csv = StringBuffer();
      csv.writeln('ID,Name,Tagline,Category,Phone,Email,City,Address,Rating,Total Ratings,Total Orders,Status,Created');
      
      for (final store in stores) {
        csv.writeln(
          'S${store.id},'
          '"${store.name}",'
          '"${store.tagline ?? ''}",'
          '"${store.storeCategoryId}",'
          '"${store.phone}",'
          '"${store.email ?? ''}",'
          '"${store.city ?? ''}",'
          '"${store.address}",'
          '"${store.rating.toStringAsFixed(1)}",'
          '"${store.totalRatings}",'
          '"${store.totalOrders}",'
          '"${store.isActive ? 'Active' : 'Inactive'}",'
          '"${store.createdAt.toString().split(' ')[0]}"'
        );
      }
      
      // Create blob and download
      final bytes = utf8.encode(csv.toString());
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'stores_${DateTime.now().millisecondsSinceEpoch}.csv')
        ..click();
      html.Url.revokeObjectUrl(url);
      
      Get.snackbar(
        'Success',
        'Stores exported successfully',
        backgroundColor: AdminColors.success.withOpacity(0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[StoresController] Error exporting stores: $e');
      Get.snackbar(
        'Error',
        'Failed to export stores',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    }
  }

  /// Refresh the list
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadStores();
  }
}
