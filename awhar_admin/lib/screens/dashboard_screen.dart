import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
import '../widgets/stat_card.dart';
import '../controllers/dashboard_controller.dart';

/// Dashboard overview screen with statistics
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    
    return DashboardLayout(
      title: 'Dashboard',
      actions: [
        Obx(() => ElevatedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.loadStats,
          icon: controller.isLoading.value 
              ? const SizedBox(
                  width: 18, 
                  height: 18, 
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.refresh, size: 18),
          label: Text(controller.isLoading.value ? 'Loading...' : 'Refresh'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        )),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(),
            
            const SizedBox(height: 24),
            
            // Stats Grid
            _buildStatsGrid(),
            
            const SizedBox(height: 24),
            
            // Two Column Layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recent Activity
                Expanded(
                  flex: 2,
                  child: _buildRecentActivity(controller),
                ),
                
                const SizedBox(width: 24),
                
                // Quick Actions
                Expanded(
                  child: _buildQuickActions(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AdminColors.primary,
            AdminColors.primaryPressed,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AdminColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '🎯 Awhar Dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome back, Admin! 👋',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Here\'s what\'s happening with your platform today.',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.insights_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final controller = Get.find<DashboardController>();
    
    return Obx(() => GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          title: 'Total Users',
          value: _formatNumber(controller.totalUsersRx.value),
          icon: Icons.people_rounded,
          color: AdminColors.info,
          change: '+${controller.newUsersTodayRx.value} today',
          isPositive: true,
        ),
        StatCard(
          title: 'Active Drivers',
          value: '${controller.onlineDriversRx.value}/${controller.totalDriversRx.value}',
          icon: Icons.local_taxi_rounded,
          color: AdminColors.success,
          change: '${controller.pendingVerificationsRx.value} pending',
          isPositive: controller.onlineDriversRx.value > 0,
        ),
        StatCard(
          title: 'Total Stores',
          value: _formatNumber(controller.totalStoresRx.value),
          icon: Icons.store_rounded,
          color: AdminColors.warning,
          change: '${controller.activeStoresRx.value} active',
          isPositive: true,
        ),
        StatCard(
          title: 'Revenue',
          value: CurrencyHelper.format(controller.totalRevenueRx.value),
          icon: Icons.account_balance_wallet_rounded,
          color: AdminColors.primary,
          change: '${CurrencyHelper.format(controller.todayRevenueRx.value)} commission',
          isPositive: true,
        ),
      ],
    ));
  }
  
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildRecentActivity(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AdminColors.borderSoftLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Latest platform events',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AdminColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('View All'),
                style: TextButton.styleFrom(
                  foregroundColor: AdminColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Activity List - Real Data
          Obx(() {
            final controller = Get.find<DashboardController>();
            
            // Show loading state
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            // Show empty state
            if (controller.recentActivities.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 48,
                        color: AdminColors.textSecondaryLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recent activities',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AdminColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () => controller.loadRecentActivities(),
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            // Show activities
            return Column(
              children: controller.recentActivities.map((activity) => 
                _buildActivityItem(activity)
              ).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActivityItem(RecentActivity activity) {
    // Map activity types to icons and colors
    IconData icon;
    Color iconColor;
    
    switch (activity.activityType) {
      case 'user_registration':
        icon = Icons.person_add_rounded;
        iconColor = Colors.blue;
        break;
      case 'order_placed':
        icon = Icons.shopping_bag_rounded;
        iconColor = Colors.green;
        break;
      case 'order_completed':
        icon = Icons.local_shipping_rounded;
        iconColor = Colors.orange;
        break;
      case 'new_rating':
        icon = Icons.star_rounded;
        iconColor = Colors.amber;
        break;
      case 'payment_processed':
        icon = Icons.account_balance_wallet_rounded;
        iconColor = Colors.purple;
        break;
      default:
        icon = Icons.notifications_active_rounded;
        iconColor = AdminColors.primary;
    }
    
    final timeAgo = _getTimeAgo(activity.createdAt);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          
          // Time Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AdminColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              timeAgo,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AdminColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AdminColors.borderSoftLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Common admin tasks',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          _buildActionButton(
            'Add New User',
            'Create new client or driver account',
            Icons.person_add_rounded,
            Colors.blue,
            Colors.blue.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Verify Driver',
            'Review and approve driver documents',
            Icons.verified_user_rounded,
            Colors.green,
            Colors.green.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Review Reports',
            'Handle user reports and complaints',
            Icons.flag_rounded,
            Colors.orange,
            Colors.orange.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            'Update Settings',
            'Configure platform settings',
            Icons.settings_rounded,
            Colors.purple,
            Colors.purple.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, String subtitle, IconData icon, Color iconColor, Color bgColor) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: iconColor.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      iconColor.withOpacity(0.15),
                      iconColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: iconColor.withOpacity(0.3)),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow
              Icon(
                Icons.arrow_forward_rounded,
                color: iconColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }}