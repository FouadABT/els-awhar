import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../core/services/api_service.dart';

/// Controller for managing admin users
/// Allows super admins to create, edit, and delete other admins
class AdminsController extends GetxController {
  // Reactive state
  final RxList<AdminUser> admins = <AdminUser>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isSubmitting = false.obs;

  // For editing
  final Rx<AdminUser?> selectedAdmin = Rx<AdminUser?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAdmins();
  }

  /// Load all admin users from the server
  Future<void> loadAdmins() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await ApiService.instance.client.admin.getAllAdmins();
      admins.value = result;
    } catch (e) {
      debugPrint('[AdminsController] Error loading admins: $e');
      errorMessage.value = 'Failed to load admins. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get a single admin by ID
  Future<AdminUser?> getAdmin(int adminId) async {
    try {
      return await ApiService.instance.client.admin.getAdmin(adminId: adminId);
    } catch (e) {
      debugPrint('[AdminsController] Error getting admin: $e');
      return null;
    }
  }

  /// Create a new admin user
  Future<bool> createAdmin({
    required String email,
    required String password,
    required String name,
    String? photoUrl,
    required String role,
    List<String> permissions = const [],
  }) async {
    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      final newAdmin = await ApiService.instance.client.admin.createAdmin(
        email: email,
        password: password,
        name: name,
        photoUrl: photoUrl,
        role: role,
        permissions: permissions,
      );

      if (newAdmin != null) {
        admins.add(newAdmin);
        return true;
      } else {
        errorMessage.value = 'Failed to create admin. Please try again.';
        return false;
      }
    } catch (e) {
      debugPrint('[AdminsController] Error creating admin: $e');
      if (e.toString().contains('duplicate')) {
        errorMessage.value = 'An admin with this email already exists.';
      } else {
        errorMessage.value = 'Failed to create admin. Please try again.';
      }
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Update an existing admin user
  Future<bool> updateAdmin({
    required int adminId,
    String? email,
    String? name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
  }) async {
    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      final updatedAdmin = await ApiService.instance.client.admin.updateAdmin(
        adminId: adminId,
        email: email,
        name: name,
        photoUrl: photoUrl,
        role: role,
        permissions: permissions,
        isActive: isActive,
      );

      if (updatedAdmin != null) {
        // Update the admin in the list
        final index = admins.indexWhere((a) => a.id == adminId);
        if (index >= 0) {
          admins[index] = updatedAdmin;
        }
        return true;
      } else {
        errorMessage.value = 'Failed to update admin. Please try again.';
        return false;
      }
    } catch (e) {
      debugPrint('[AdminsController] Error updating admin: $e');
      errorMessage.value = 'Failed to update admin. Please try again.';
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Reset an admin's password (super admin only)
  Future<bool> resetAdminPassword({
    required int adminId,
    required String newPassword,
  }) async {
    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      final result = await ApiService.instance.client.admin.resetAdminPassword(
        adminId: adminId,
        newPassword: newPassword,
      );

      if (!result) {
        errorMessage.value = 'Failed to reset password.';
      }
      
      return result;
    } catch (e) {
      debugPrint('[AdminsController] Error resetting password: $e');
      errorMessage.value = 'Failed to reset password. Please try again.';
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Toggle admin active status
  Future<bool> toggleAdminStatus(int adminId) async {
    try {
      final result = await ApiService.instance.client.admin.toggleAdminStatus(adminId: adminId);

      if (result) {
        // Reload the admin to get updated status
        await loadAdmins();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[AdminsController] Error toggling status: $e');
      errorMessage.value = 'Failed to update admin status.';
      return false;
    }
  }

  /// Delete an admin user
  Future<bool> deleteAdmin(int adminId) async {
    try {
      final success = await ApiService.instance.client.admin.deleteAdmin(adminId: adminId);

      if (success) {
        admins.removeWhere((a) => a.id == adminId);
      } else {
        errorMessage.value = 'Cannot delete this admin.';
      }
      
      return success;
    } catch (e) {
      debugPrint('[AdminsController] Error deleting admin: $e');
      if (e.toString().contains('super_admin')) {
        errorMessage.value = 'Cannot delete the last super admin.';
      } else {
        errorMessage.value = 'Failed to delete admin. Please try again.';
      }
      return false;
    }
  }

  /// Get role display name
  String getRoleDisplayName(String role) {
    switch (role) {
      case 'super_admin':
        return 'Super Admin';
      case 'admin':
        return 'Admin';
      case 'moderator':
        return 'Moderator';
      case 'support':
        return 'Support';
      default:
        return role;
    }
  }

  /// Get available admin roles
  List<Map<String, String>> get availableRoles => [
    {'value': 'super_admin', 'label': 'Super Admin'},
    {'value': 'admin', 'label': 'Admin'},
    {'value': 'moderator', 'label': 'Moderator'},
    {'value': 'support', 'label': 'Support'},
  ];

  /// Get available permissions
  List<Map<String, String>> get availablePermissions => [
    {'value': 'all', 'label': 'All Permissions'},
    {'value': 'manage_admins', 'label': 'Manage Admins'},
    {'value': 'manage_users', 'label': 'Manage Users'},
    {'value': 'manage_drivers', 'label': 'Manage Drivers'},
    {'value': 'manage_stores', 'label': 'Manage Stores'},
    {'value': 'manage_orders', 'label': 'Manage Orders'},
    {'value': 'manage_promos', 'label': 'Manage Promos'},
    {'value': 'view_reports', 'label': 'View Reports'},
    {'value': 'manage_transactions', 'label': 'Manage Transactions'},
  ];
}
