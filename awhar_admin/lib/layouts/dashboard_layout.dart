import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/admin_sidebar.dart';

/// Main dashboard layout with sidebar navigation
class DashboardLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const DashboardLayout({
    super.key,
    required this.child,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.backgroundLight,
      body: Row(
        children: [
          // Sidebar
          const AdminSidebar(),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Bar
                _buildTopBar(context),
                
                // Content Area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        border: Border(
          bottom: BorderSide(
            color: AdminColors.borderSoftLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Page Title
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          
          const Spacer(),
          
          // Actions
          if (actions != null) ...actions!,
          
          const SizedBox(width: 16),
          
          // Notifications
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AdminColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          
          const SizedBox(width: 8),
          
          // User Menu
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AdminColors.primarySoft,
                  child: Obx(() => Text(
                    authController.adminName.value.isNotEmpty
                        ? authController.adminName.value[0].toUpperCase()
                        : 'A',
                    style: GoogleFonts.poppins(
                      color: AdminColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ),
                const SizedBox(width: 8),
                Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authController.adminName.value.isNotEmpty
                          ? authController.adminName.value
                          : 'Admin',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      'Administrator',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                )),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    const Icon(Icons.person_outline, size: 20),
                    const SizedBox(width: 12),
                    Text('Profile', style: GoogleFonts.inter()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    const Icon(Icons.settings_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text('Settings', style: GoogleFonts.inter()),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 20, color: AdminColors.error),
                    const SizedBox(width: 12),
                    Text('Logout', style: GoogleFonts.inter(color: AdminColors.error)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                authController.logout();
              } else if (value == 'profile') {
                Get.toNamed('/profile');
              } else if (value == 'settings') {
                Get.toNamed('/settings');
              }
            },
          ),
        ],
      ),
    );
  }
}
