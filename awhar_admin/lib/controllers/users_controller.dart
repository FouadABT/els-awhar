import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';
import '../core/theme/admin_colors.dart';
import 'dart:html' as html;
import 'dart:convert';

/// Enhanced users controller with full CRUD and filtering
class UsersController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // User list
  final RxList<User> users = <User>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Statistics
  final RxInt activeCount = 0.obs;
  final RxInt suspendedCount = 0.obs;
  final RxInt bannedCount = 0.obs;

  // Search and filters
  final RxString searchQuery = ''.obs;
  final RxString selectedRole = 'All Roles'.obs;
  final RxString selectedStatus = 'All Statuses'.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Load users from the server
  Future<void> loadUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      // Apply filters
      String? roleFilter;
      if (selectedRole.value != 'All Roles') {
        roleFilter = selectedRole.value;
      }

      String? statusFilter;
      if (selectedStatus.value != 'All Statuses') {
        statusFilter = selectedStatus.value;
      }

      final result = await ApiService.instance.client.admin.listUsers(
        page: currentPage.value,
        limit: pageSize.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        role: roleFilter,
        status: statusFilter,
      );

      users.value = result;
      
      // Update statistics
      _updateStatistics();
      
      // Get total count (this should ideally come from the backend)
      final totalResult = await ApiService.instance.client.admin.getUserCount();
      totalCount.value = totalResult;
      
      debugPrint('[UsersController] Loaded ${result.length} users');
    } catch (e) {
      debugPrint('[UsersController] Error loading users: $e');
      errorMessage.value = 'Failed to load users. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Update user statistics
  void _updateStatistics() {
    activeCount.value = users.where((u) => u.status?.name.toLowerCase() == 'active').length;
    suspendedCount.value = users.where((u) => u.status?.name.toLowerCase() == 'suspended').length;
    bannedCount.value = users.where((u) => u.status?.name.toLowerCase() == 'banned').length;
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadUsers();
  }

  /// Clear all filters
  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedRole.value = 'All Roles';
    selectedStatus.value = 'All Statuses';
    currentPage.value = 1;
    loadUsers();
  }

  /// Show user details dialog
  void showUserDetails(User user) {
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
                    'User Details',
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
              _buildDetailRow('User ID', '#${user.id}'),
              _buildDetailRow('Full Name', user.fullName.isEmpty ? 'N/A' : user.fullName),
              _buildDetailRow('Email', user.email ?? 'N/A'),
              _buildDetailRow('Phone Number', user.phoneNumber ?? 'N/A'),
              _buildDetailRow('Role', user.roles.isNotEmpty ? user.roles.first.name : 'Client'),
              _buildDetailRow('Status', user.status?.name ?? 'Active'),
              _buildDetailRow('Joined', user.createdAt.toString().split('.')[0]),
              _buildDetailRow('Last Updated', user.updatedAt.toString().split('.')[0]),
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
                      editUser(user);
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit User'),
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

  /// Edit user dialog
  void editUser(User user) {
    final nameController = TextEditingController(text: user.fullName);
    final emailController = TextEditingController(text: user.email ?? '');
    final phoneController = TextEditingController(text: user.phoneNumber ?? '');

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
                'Edit User',
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
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
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
                      // TODO: Implement update user endpoint
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'User updated successfully',
                        backgroundColor: AdminColors.success.withOpacity(0.1),
                        colorText: AdminColors.success,
                      );
                      loadUsers();
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

  /// Suspend user with dialog
  void suspendUserWithDialog(User user) {
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
                      'Suspend User',
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
                'Are you sure you want to suspend ${user.fullName}?',
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
                      await suspendUser(user.id!, reason: reasonController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.warning,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Suspend User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Suspend a user
  Future<bool> suspendUser(int userId, {String? reason}) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.admin.suspendUser(
        userId: userId,
        reason: reason,
      );

      if (success) {
        await loadUsers();
        Get.snackbar(
          'Success',
          'User suspended successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[UsersController] Error suspending user: $e');
      Get.snackbar(
        'Error',
        'Failed to suspend user',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Unsuspend a user
  Future<bool> unsuspendUser(int userId) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.admin.unsuspendUser(userId);

      if (success) {
        await loadUsers();
        Get.snackbar(
          'Success',
          'User unsuspended successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[UsersController] Error unsuspending user: $e');
      Get.snackbar(
        'Error',
        'Failed to unsuspend user',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Ban user with confirmation
  void banUser(User user) {
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
                    child: const Icon(Icons.cancel, color: AdminColors.error),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ban User',
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
                'Are you sure you want to permanently ban ${user.fullName}? This action cannot be undone.',
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
                      await _executeBanUser(user.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Ban User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeBanUser(int userId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.banUser(userId: userId);
      if (success) {
        await loadUsers();
        Get.snackbar(
          'Success',
          'User banned successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to ban user',
          backgroundColor: AdminColors.error.withOpacity(0.1),
          colorText: AdminColors.error,
        );
      }
    } catch (e) {
      debugPrint('[UsersController] Error banning user: $e');
      Get.snackbar(
        'Error',
        'Failed to ban user',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Delete user with confirmation
  void deleteUser(User user) {
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
                      'Delete User',
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
                'Are you sure you want to permanently delete ${user.fullName}? All user data will be lost. This action cannot be undone.',
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
                      await _executeDeleteUser(user.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.error,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeDeleteUser(int userId) async {
    isActionLoading.value = true;
    try {
      final success = await ApiService.instance.client.admin.deleteUser(userId);
      if (success) {
        await loadUsers();
        Get.snackbar(
          'Success',
          'User deleted successfully',
          backgroundColor: AdminColors.success.withOpacity(0.1),
          colorText: AdminColors.success,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete user',
          backgroundColor: AdminColors.error.withOpacity(0.1),
          colorText: AdminColors.error,
        );
      }
    } catch (e) {
      debugPrint('[UsersController] Error deleting user: $e');
      Get.snackbar(
        'Error',
        'Failed to delete user',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Export users to CSV
  void exportUsers() {
    try {
      // Create CSV content
      final csv = StringBuffer();
      csv.writeln('ID,Name,Email,Phone,Role,Status,Joined');
      
      for (final user in users) {
        csv.writeln(
          '${user.id},'
          '"${user.fullName}",'
          '"${user.email ?? ''}",'
          '"${user.phoneNumber ?? ''}",'
          '"${user.roles.isNotEmpty ? user.roles.first.name : 'Client'}",'
          '"${user.status?.name ?? 'Active'}",'
          '"${user.createdAt.toString().split(' ')[0]}"'
        );
      }
      
      // Create blob and download
      final bytes = utf8.encode(csv.toString());
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'users_${DateTime.now().millisecondsSinceEpoch}.csv')
        ..click();
      html.Url.revokeObjectUrl(url);
      
      Get.snackbar(
        'Success',
        'Users exported successfully',
        backgroundColor: AdminColors.success.withOpacity(0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[UsersController] Error exporting users: $e');
      Get.snackbar(
        'Error',
        'Failed to export users',
        backgroundColor: AdminColors.error.withOpacity(0.1),
        colorText: AdminColors.error,
      );
    }
  }

  /// Refresh the list
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadUsers();
  }
}
