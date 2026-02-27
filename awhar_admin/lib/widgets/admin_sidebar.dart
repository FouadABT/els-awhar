import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/auth_controller.dart';

/// Sidebar menu item data
class SidebarItem {
  final String title;
  final IconData icon;
  final String route;
  final int? badgeCount;
  final bool requiresManageAdmins;

  const SidebarItem({
    required this.title,
    required this.icon,
    required this.route,
    this.badgeCount,
    this.requiresManageAdmins = false,
  });
}

/// Admin sidebar navigation
class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  static const List<SidebarItem> _menuItems = [
    SidebarItem(title: 'Dashboard', icon: Icons.dashboard_rounded, route: '/dashboard'),
    SidebarItem(title: 'Users', icon: Icons.people_rounded, route: '/users'),
    SidebarItem(title: 'Drivers', icon: Icons.local_taxi_rounded, route: '/drivers'),
    SidebarItem(title: 'Stores', icon: Icons.store_rounded, route: '/stores'),
    SidebarItem(title: 'Orders', icon: Icons.receipt_long_rounded, route: '/orders'),
    SidebarItem(title: 'Requests', icon: Icons.assignment_rounded, route: '/requests'),
    SidebarItem(title: 'Promos', icon: Icons.campaign_rounded, route: '/promos'),
    SidebarItem(title: 'Reports', icon: Icons.flag_rounded, route: '/reports'),
    SidebarItem(title: 'Transactions', icon: Icons.account_balance_wallet_rounded, route: '/transactions'),
    SidebarItem(title: 'Notifications', icon: Icons.notifications_active_rounded, route: '/notifications'),
    SidebarItem(title: 'ES Strategist', icon: Icons.psychology_rounded, route: '/strategist'),
    SidebarItem(title: 'Fraud & Trust', icon: Icons.shield_rounded, route: '/fraud'),
    SidebarItem(title: 'MCP Tools', icon: Icons.hub_rounded, route: '/mcp-tools'),
    SidebarItem(title: 'Admins', icon: Icons.admin_panel_settings_rounded, route: '/admins', requiresManageAdmins: true),
    SidebarItem(title: 'Settings', icon: Icons.settings_rounded, route: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final authController = Get.find<AuthController>();

    // Filter menu items based on permissions
    final visibleItems = _menuItems.where((item) {
      if (item.requiresManageAdmins) {
        return authController.canManageAdmins;
      }
      return true;
    }).toList();

    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: AdminColors.sidebarBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Header
          _buildLogo(),
          
          const SizedBox(height: 16),
          
          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: visibleItems.length,
              itemBuilder: (context, index) {
                final item = visibleItems[index];
                final isActive = currentRoute == item.route;
                return _buildMenuItem(item, isActive);
              },
            ),
          ),
          
          // Bottom Section
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'appiconnobackgound.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Awhar',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AdminColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Admin',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AdminColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(SidebarItem item, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            if (Get.currentRoute != item.route) {
              Get.toNamed(item.route);
            }
          },
          borderRadius: BorderRadius.circular(10),
          hoverColor: AdminColors.sidebarHover,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? AdminColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: isActive ? Colors.white : AdminColors.sidebarText,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? Colors.white : AdminColors.sidebarText,
                    ),
                  ),
                ),
                if (item.badgeCount != null && item.badgeCount! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AdminColors.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${item.badgeCount}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final authController = Get.find<AuthController>();
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Section
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => Get.toNamed('/profile'),
              borderRadius: BorderRadius.circular(12),
              hoverColor: AdminColors.sidebarHover,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AdminColors.primary,
                      child: Text(
                        authController.adminName.value.isNotEmpty 
                            ? authController.adminName.value[0].toUpperCase()
                            : 'A',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            authController.adminName.value.isNotEmpty 
                                ? authController.adminName.value
                                : 'Admin',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Obx(() => Text(
                            authController.adminRole.value.isNotEmpty
                                ? authController.adminRole.value.replaceAll('_', ' ').capitalize!
                                : 'Administrator',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AdminColors.sidebarText,
                            ),
                          )),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AdminColors.sidebarText,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Logout Button
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () => authController.logout(),
              borderRadius: BorderRadius.circular(10),
              hoverColor: AdminColors.error.withOpacity(0.2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AdminColors.error.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout_rounded,
                      size: 18,
                      color: AdminColors.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AdminColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
