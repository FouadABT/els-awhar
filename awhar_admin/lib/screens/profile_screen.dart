import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/auth_controller.dart';

/// Profile screen for current admin
/// Allows viewing profile info and changing password
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return DashboardLayout(
      title: 'My Profile',
      actions: [
        if (authController.canManageAdmins)
          OutlinedButton.icon(
            onPressed: () => Get.toNamed('/admins'),
            icon: const Icon(Icons.admin_panel_settings, size: 18),
            label: const Text('Manage Admins'),
          ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header card
            _buildProfileHeader(authController),
            
            const SizedBox(height: 24),
            
            // Info cards row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account info card
                Expanded(
                  child: _buildAccountInfoCard(authController),
                ),
                
                const SizedBox(width: 24),
                
                // Security card
                Expanded(
                  child: _buildSecurityCard(authController),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AdminColors.primary,
            AdminColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          Obx(() => CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white.withOpacity(0.2),
            backgroundImage: authController.adminPhotoUrl.value.isNotEmpty
                ? NetworkImage(authController.adminPhotoUrl.value)
                : null,
            child: authController.adminPhotoUrl.value.isEmpty
                ? Text(
                    authController.adminName.value.isNotEmpty
                        ? authController.adminName.value[0].toUpperCase()
                        : 'A',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          )),
          
          const SizedBox(width: 24),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  authController.adminName.value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
                const SizedBox(height: 8),
                Obx(() => Text(
                  authController.adminEmail.value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                )),
                const SizedBox(height: 12),
                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (authController.adminRole.value == 'super_admin')
                        const Icon(Icons.shield, size: 16, color: Colors.white),
                      if (authController.adminRole.value == 'super_admin')
                        const SizedBox(width: 6),
                      Text(
                        _getRoleDisplayName(authController.adminRole.value),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoCard(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: AdminColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          _buildInfoRow('Admin ID', '#${authController.adminId.value}'),
          const SizedBox(height: 16),
          _buildInfoRow('Full Name', authController.adminName.value),
          const SizedBox(height: 16),
          _buildInfoRow('Email', authController.adminEmail.value),
          const SizedBox(height: 16),
          _buildInfoRow('Role', _getRoleDisplayName(authController.adminRole.value)),
          const SizedBox(height: 16),
          
          Obx(() => authController.adminPermissions.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permissions',
                      style: TextStyle(
                        fontSize: 14,
                        color: AdminColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: authController.adminPermissions.map((perm) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AdminColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            perm == 'all' ? 'All Permissions' : _formatPermission(perm),
                            style: TextStyle(
                              fontSize: 12,
                              color: AdminColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildSecurityCard(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: AdminColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                'Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Change password button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AdminColors.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AdminColors.borderSoftLight),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AdminColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.lock_outline, color: AdminColors.warning, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Last changed: Unknown',
                        style: TextStyle(
                          fontSize: 12,
                          color: AdminColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showChangePasswordDialog(authController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AdminColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Change'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Session info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AdminColors.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AdminColors.borderSoftLight),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AdminColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.devices, color: AdminColors.success, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Session',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 12,
                          color: AdminColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () => authController.logout(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AdminColors.error,
                    side: BorderSide(color: AdminColors.error),
                  ),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AdminColors.textPrimaryLight,
            ),
          ),
        ),
      ],
    );
  }

  String _getRoleDisplayName(String role) {
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

  String _formatPermission(String permission) {
    return permission.replaceAll('_', ' ').split(' ').map((word) => 
      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : ''
    ).join(' ');
  }

  void _showChangePasswordDialog(AuthController authController) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final showCurrentPassword = false.obs;
    final showNewPassword = false.obs;
    final showConfirmPassword = false.obs;

    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lock_outline, color: AdminColors.primary),
            const SizedBox(width: 12),
            const Text('Change Password'),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => TextField(
                controller: currentPasswordController,
                obscureText: !showCurrentPassword.value,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(showCurrentPassword.value ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => showCurrentPassword.toggle(),
                  ),
                ),
              )),
              const SizedBox(height: 16),
              Obx(() => TextField(
                controller: newPasswordController,
                obscureText: !showNewPassword.value,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Min 6 characters',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(showNewPassword.value ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => showNewPassword.toggle(),
                  ),
                ),
              )),
              const SizedBox(height: 16),
              Obx(() => TextField(
                controller: confirmPasswordController,
                obscureText: !showConfirmPassword.value,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(showConfirmPassword.value ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => showConfirmPassword.toggle(),
                  ),
                ),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: authController.isLoading.value
                ? null
                : () async {
                    // Validate
                    if (currentPasswordController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter your current password',
                          backgroundColor: AdminColors.error, colorText: Colors.white);
                      return;
                    }
                    if (newPasswordController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter a new password',
                          backgroundColor: AdminColors.error, colorText: Colors.white);
                      return;
                    }
                    if (newPasswordController.text.length < 6) {
                      Get.snackbar('Error', 'Password must be at least 6 characters',
                          backgroundColor: AdminColors.error, colorText: Colors.white);
                      return;
                    }
                    if (newPasswordController.text != confirmPasswordController.text) {
                      Get.snackbar('Error', 'Passwords do not match',
                          backgroundColor: AdminColors.error, colorText: Colors.white);
                      return;
                    }

                    final success = await authController.changePassword(
                      currentPassword: currentPasswordController.text,
                      newPassword: newPasswordController.text,
                    );

                    if (success) {
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Password changed successfully',
                        backgroundColor: AdminColors.success,
                        colorText: Colors.white,
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        authController.errorMessage.value,
                        backgroundColor: AdminColors.error,
                        colorText: Colors.white,
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.primary,
              foregroundColor: Colors.white,
            ),
            child: authController.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Change Password'),
          )),
        ],
      ),
    );
  }
}
