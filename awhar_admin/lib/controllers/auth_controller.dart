import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';
import '../core/services/api_service.dart';

/// Admin authentication controller
/// Handles authentication state for the admin dashboard
/// Uses database-backed admin accounts (no hardcoded credentials)
class AuthController extends GetxController {
  final _storage = GetStorage();

  // Reactive state
  final RxBool isAuthenticated = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Admin info
  final RxInt adminId = 0.obs;
  final RxString adminEmail = ''.obs;
  final RxString adminName = ''.obs;
  final RxString adminPhotoUrl = ''.obs;
  final RxString adminRole = ''.obs;
  final RxList<String> adminPermissions = <String>[].obs;
  final RxString authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkStoredSession();
  }

  /// Check for existing session on app start
  void _checkStoredSession() {
    final storedToken = _storage.read<String>('admin_token');
    final storedEmail = _storage.read<String>('admin_email');
    final storedName = _storage.read<String>('admin_name');
    final storedId = _storage.read<int>('admin_id');
    final storedPhotoUrl = _storage.read<String>('admin_photo_url');
    final storedRole = _storage.read<String>('admin_role');
    final storedPermissions = _storage.read<List>('admin_permissions');

    if (storedToken != null && storedToken.isNotEmpty) {
      authToken.value = storedToken;
      adminEmail.value = storedEmail ?? '';
      adminName.value = storedName ?? '';
      adminId.value = storedId ?? 0;
      adminPhotoUrl.value = storedPhotoUrl ?? '';
      adminRole.value = storedRole ?? '';
      adminPermissions.value = storedPermissions?.cast<String>() ?? [];
      isAuthenticated.value = true;
    }
  }

  /// Login with email and password
  /// Authenticates against the database via server endpoint
  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final trimmedEmail = email.toLowerCase().trim();
      
      // Check if API service is available
      if (!ApiService.instance.isInitialized) {
        errorMessage.value = 'Server connection not available. Please try again.';
        return false;
      }

      // Authenticate via server endpoint
      final response = await ApiService.instance.client.admin.loginWithPassword(
        email: trimmedEmail,
        password: password,
      );

      if (response.success && response.token != null) {
        _setSession(
          token: response.token!,
          id: response.adminId ?? 0,
          email: response.adminEmail ?? trimmedEmail,
          name: response.adminName ?? 'Admin User',
          photoUrl: response.adminPhotoUrl ?? '',
          role: response.adminRole ?? 'admin',
          permissions: response.adminPermissions ?? [],
        );
        return true;
      } else {
        errorMessage.value = response.message;
        return false;
      }
      
    } catch (e) {
      debugPrint('[AuthController] Login error: $e');
      errorMessage.value = 'Connection error. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Change the current admin's password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        errorMessage.value = 'Server connection not available';
        return false;
      }

      final success = await ApiService.instance.client.admin.changePassword(
        adminId: adminId.value,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!success) {
        errorMessage.value = 'Current password is incorrect or new password is too short (min 8 characters).';
      }
      
      return success;
    } catch (e) {
      debugPrint('[AuthController] Change password error: $e');
      errorMessage.value = 'Failed to change password. Please try again.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if current admin has a specific permission
  bool hasPermission(String permission) {
    // Super admin has all permissions
    if (adminRole.value == 'super_admin') return true;
    if (adminPermissions.contains('all')) return true;
    return adminPermissions.contains(permission);
  }

  /// Check if current admin is super admin
  bool get isSuperAdmin => adminRole.value == 'super_admin';

  /// Check if current admin can manage other admins
  bool get canManageAdmins => isSuperAdmin || hasPermission('manage_admins');

  /// Set session data
  void _setSession({
    required String token,
    required int id,
    required String email,
    required String name,
    required String photoUrl,
    required String role,
    required List<String> permissions,
  }) {
    authToken.value = token;
    adminId.value = id;
    adminEmail.value = email;
    adminName.value = name;
    adminPhotoUrl.value = photoUrl;
    adminRole.value = role;
    adminPermissions.value = permissions;
    isAuthenticated.value = true;

    // Persist to storage
    _storage.write('admin_token', token);
    _storage.write('admin_email', email);
    _storage.write('admin_name', name);
    _storage.write('admin_id', id);
    _storage.write('admin_photo_url', photoUrl);
    _storage.write('admin_role', role);
    _storage.write('admin_permissions', permissions);
  }

  /// Logout and clear session
  void logout() {
    authToken.value = '';
    adminId.value = 0;
    adminEmail.value = '';
    adminName.value = '';
    adminPhotoUrl.value = '';
    adminRole.value = '';
    adminPermissions.clear();
    isAuthenticated.value = false;

    _storage.remove('admin_token');
    _storage.remove('admin_email');
    _storage.remove('admin_name');
    _storage.remove('admin_id');
    _storage.remove('admin_photo_url');
    _storage.remove('admin_role');
    _storage.remove('admin_permissions');

    Get.offAllNamed('/login');
  }
}
