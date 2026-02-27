import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/admins_controller.dart';
import '../controllers/auth_controller.dart';

/// Admins management screen
/// Allows super admins to view and manage other admin users
class AdminsScreen extends StatelessWidget {
  const AdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminsController());
    final authController = Get.find<AuthController>();

    // Only super admins can access this page
    if (!authController.canManageAdmins) {
      return DashboardLayout(
        title: 'Admins Management',
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 64, color: AdminColors.textSecondaryLight),
              const SizedBox(height: 16),
              Text(
                'Access Denied',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You do not have permission to manage admins.',
                style: TextStyle(color: AdminColors.textSecondaryLight),
              ),
            ],
          ),
        ),
      );
    }

    return DashboardLayout(
      title: 'Admins Management',
      actions: [
        ElevatedButton.icon(
          onPressed: () => Get.toNamed('/admins/create'),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Admin'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Obx(() => OutlinedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.loadAdmins,
          icon: controller.isLoading.value
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.refresh, size: 18),
          label: const Text('Refresh'),
        )),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          _buildStatsRow(controller),
          
          const SizedBox(height: 24),
          
          // Admin cards grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.admins.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty && controller.admins.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: AdminColors.error),
                      const SizedBox(height: 16),
                      Text(controller.errorMessage.value),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadAdmins,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.admins.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings_outlined, size: 64, color: AdminColors.textSecondaryLight),
                      const SizedBox(height: 16),
                      Text(
                        'No admins found',
                        style: TextStyle(
                          fontSize: 18,
                          color: AdminColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3,
                ),
                itemCount: controller.admins.length,
                itemBuilder: (context, index) {
                  final admin = controller.admins[index];
                  return _buildAdminCard(context, admin, controller, authController);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(AdminsController controller) {
    return Obx(() {
      final totalAdmins = controller.admins.length;
      final activeAdmins = controller.admins.where((a) => a.isActive).length;
      final superAdmins = controller.admins.where((a) => a.role == 'super_admin').length;
      
      return Row(
        children: [
          _buildStatCard('Total Admins', totalAdmins.toString(), Icons.people, AdminColors.primary),
          const SizedBox(width: 16),
          _buildStatCard('Active', activeAdmins.toString(), Icons.check_circle, AdminColors.success),
          const SizedBox(width: 16),
          _buildStatCard('Super Admins', superAdmins.toString(), Icons.shield, AdminColors.warning),
        ],
      );
    });
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderSoftLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard(
    BuildContext context,
    dynamic admin,
    AdminsController controller,
    AuthController authController,
  ) {
    final isCurrentAdmin = admin.id == authController.adminId.value;
    final isSuperAdmin = admin.role == 'super_admin';
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentAdmin 
              ? AdminColors.primary.withOpacity(0.5) 
              : AdminColors.borderSoftLight,
          width: isCurrentAdmin ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with avatar and status
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AdminColors.primary.withOpacity(0.1),
                backgroundImage: admin.photoUrl != null && admin.photoUrl!.isNotEmpty
                    ? NetworkImage(admin.photoUrl!)
                    : null,
                child: admin.photoUrl == null || admin.photoUrl!.isEmpty
                    ? Text(
                        admin.name.isNotEmpty ? admin.name[0].toUpperCase() : 'A',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AdminColors.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            admin.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AdminColors.textPrimaryLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isCurrentAdmin)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AdminColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'You',
                              style: TextStyle(
                                fontSize: 10,
                                color: AdminColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      admin.email,
                      style: TextStyle(
                        fontSize: 13,
                        color: AdminColors.textSecondaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Role badge
          Row(
            children: [
              _buildRoleBadge(admin.role, controller),
              const SizedBox(width: 8),
              _buildStatusBadge(admin.isActive),
            ],
          ),
          
          const Spacer(),
          
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Edit button (can't edit yourself from here)
              if (!isCurrentAdmin)
                IconButton(
                  onPressed: () => Get.toNamed('/admins/edit/${admin.id}'),
                  icon: Icon(Icons.edit_outlined, size: 20, color: AdminColors.textSecondaryLight),
                  tooltip: 'Edit',
                ),
              
              // Reset password button
              if (!isCurrentAdmin)
                IconButton(
                  onPressed: () => _showResetPasswordDialog(context, admin, controller),
                  icon: Icon(Icons.lock_reset, size: 20, color: AdminColors.warning),
                  tooltip: 'Reset Password',
                ),
              
              // Toggle status button (can't toggle yourself)
              if (!isCurrentAdmin)
                IconButton(
                  onPressed: () => controller.toggleAdminStatus(admin.id!),
                  icon: Icon(
                    admin.isActive ? Icons.block : Icons.check_circle_outline,
                    size: 20,
                    color: admin.isActive ? AdminColors.error : AdminColors.success,
                  ),
                  tooltip: admin.isActive ? 'Deactivate' : 'Activate',
                ),
              
              // Delete button (can't delete yourself or if last super admin)
              if (!isCurrentAdmin && !(isSuperAdmin && controller.admins.where((a) => a.role == 'super_admin').length == 1))
                IconButton(
                  onPressed: () => _showDeleteDialog(context, admin, controller),
                  icon: Icon(Icons.delete_outline, size: 20, color: AdminColors.error),
                  tooltip: 'Delete',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleBadge(String role, AdminsController controller) {
    Color color;
    switch (role) {
      case 'super_admin':
        color = AdminColors.warning;
        break;
      case 'admin':
        color = AdminColors.primary;
        break;
      case 'moderator':
        color = Colors.purple;
        break;
      case 'support':
        color = Colors.teal;
        break;
      default:
        color = AdminColors.textSecondaryLight;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (role == 'super_admin') ...[
            Icon(Icons.shield, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            controller.getRoleDisplayName(role),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AdminColors.success : AdminColors.error).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? AdminColors.success : AdminColors.error,
        ),
      ),
    );
  }

  void _showResetPasswordDialog(BuildContext context, dynamic admin, AdminsController controller) {
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: Text('Reset Password for ${admin.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter new password',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm new password',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : () async {
                    if (passwordController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter a password');
                      return;
                    }
                    if (passwordController.text.length < 6) {
                      Get.snackbar('Error', 'Password must be at least 6 characters');
                      return;
                    }
                    if (passwordController.text != confirmController.text) {
                      Get.snackbar('Error', 'Passwords do not match');
                      return;
                    }
                    
                    final success = await controller.resetAdminPassword(
                      adminId: admin.id!,
                      newPassword: passwordController.text,
                    );
                    
                    if (success) {
                      Get.back();
                      Get.snackbar('Success', 'Password has been reset');
                    }
                  },
            child: controller.isSubmitting.value
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Reset Password'),
          )),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, dynamic admin, AdminsController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Admin'),
        content: Text('Are you sure you want to delete ${admin.name}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await controller.deleteAdmin(admin.id!);
              Get.back();
              if (success) {
                Get.snackbar('Success', 'Admin has been deleted');
              } else {
                Get.snackbar('Error', controller.errorMessage.value);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
