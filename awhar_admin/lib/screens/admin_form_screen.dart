import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/admins_controller.dart';
import '../controllers/auth_controller.dart';

/// Admin form screen for creating and editing admin users
class AdminFormScreen extends StatefulWidget {
  const AdminFormScreen({super.key});

  @override
  State<AdminFormScreen> createState() => _AdminFormScreenState();
}

class _AdminFormScreenState extends State<AdminFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _photoUrlController = TextEditingController();
  
  String _selectedRole = 'admin';
  List<String> _selectedPermissions = [];
  bool _isEditing = false;
  int? _adminId;
  bool _isLoading = true;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  late AdminsController _adminsController;
  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _adminsController = Get.find<AdminsController>();
    _authController = Get.find<AuthController>();
    _loadAdminIfEditing();
  }

  void _loadAdminIfEditing() async {
    final params = Get.parameters;
    if (params['id'] != null) {
      _isEditing = true;
      _adminId = int.tryParse(params['id']!);
      
      if (_adminId != null) {
        final admin = await _adminsController.getAdmin(_adminId!);
        if (admin != null) {
          _emailController.text = admin.email;
          _nameController.text = admin.name;
          _photoUrlController.text = admin.photoUrl ?? '';
          _selectedRole = admin.role;
          _selectedPermissions = admin.permissions != null 
              ? List<String>.from(admin.permissions!) 
              : [];
        }
      }
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Permission check
    if (!_authController.canManageAdmins) {
      return DashboardLayout(
        title: 'Access Denied',
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
      title: _isEditing ? 'Edit Admin' : 'Create Admin',
      actions: [
        OutlinedButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
          onPressed: _adminsController.isSubmitting.value ? null : _saveAdmin,
          icon: _adminsController.isSubmitting.value
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Icon(_isEditing ? Icons.save : Icons.add, size: 18),
          label: Text(_isEditing ? 'Save Changes' : 'Create Admin'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        )),
      ],
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic info card
                    _buildCard(
                      title: 'Basic Information',
                      icon: Icons.person_outline,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name *',
                            hintText: 'Enter admin name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address *',
                            hintText: 'Enter email address',
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _photoUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Photo URL (optional)',
                            hintText: 'Enter photo URL',
                            prefixIcon: Icon(Icons.image),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Password card (only for new admins or password reset)
                    if (!_isEditing)
                      _buildCard(
                        title: 'Password',
                        icon: Icons.lock_outline,
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: 'Password *',
                              hintText: 'Enter password (min 6 characters)',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (!_isEditing && (value == null || value.isEmpty)) {
                                return 'Please enter a password';
                              }
                              if (!_isEditing && value != null && value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_showConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password *',
                              hintText: 'Confirm password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_showConfirmPassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword = !_showConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (!_isEditing && value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    
                    if (!_isEditing) const SizedBox(height: 24),
                    
                    // Role and permissions card
                    _buildCard(
                      title: 'Role & Permissions',
                      icon: Icons.admin_panel_settings_outlined,
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: const InputDecoration(
                            labelText: 'Role *',
                            prefixIcon: Icon(Icons.shield),
                          ),
                          items: _adminsController.availableRoles.map((role) {
                            return DropdownMenuItem<String>(
                              value: role['value'],
                              child: Text(role['label']!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value ?? 'admin';
                              // Super admins automatically get all permissions
                              if (_selectedRole == 'super_admin') {
                                _selectedPermissions = ['all'];
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        if (_selectedRole != 'super_admin') ...[
                          Text(
                            'Permissions',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AdminColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _adminsController.availablePermissions.map((perm) {
                              final isSelected = _selectedPermissions.contains(perm['value']);
                              return FilterChip(
                                label: Text(perm['label']!),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      if (perm['value'] == 'all') {
                                        _selectedPermissions = ['all'];
                                      } else {
                                        _selectedPermissions.remove('all');
                                        _selectedPermissions.add(perm['value']!);
                                      }
                                    } else {
                                      _selectedPermissions.remove(perm['value']);
                                    }
                                  });
                                },
                                selectedColor: AdminColors.primary.withOpacity(0.2),
                                checkmarkColor: AdminColors.primary,
                              );
                            }).toList(),
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AdminColors.warning.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AdminColors.warning.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, color: AdminColors.warning),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Super Admins have all permissions by default.',
                                    style: TextStyle(color: AdminColors.warning),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
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
              Icon(icon, color: AdminColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  void _saveAdmin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool success;
    
    if (_isEditing && _adminId != null) {
      success = await _adminsController.updateAdmin(
        adminId: _adminId!,
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        photoUrl: _photoUrlController.text.trim().isEmpty ? null : _photoUrlController.text.trim(),
        role: _selectedRole,
        permissions: _selectedRole == 'super_admin' ? ['all'] : _selectedPermissions,
      );
    } else {
      success = await _adminsController.createAdmin(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        photoUrl: _photoUrlController.text.trim().isEmpty ? null : _photoUrlController.text.trim(),
        role: _selectedRole,
        permissions: _selectedRole == 'super_admin' ? ['all'] : _selectedPermissions,
      );
    }

    if (success) {
      Get.back();
      Get.snackbar(
        'Success',
        _isEditing ? 'Admin updated successfully' : 'Admin created successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AdminColors.success,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        _adminsController.errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AdminColors.error,
        colorText: Colors.white,
      );
    }
  }
}
