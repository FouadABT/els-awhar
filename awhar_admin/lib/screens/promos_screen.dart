import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/promos_controller.dart';
import 'promo_form_screen.dart';

/// Promos management screen
class PromosScreen extends StatelessWidget {
  const PromosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromosController());

    return DashboardLayout(
      title: 'Promos Management',
      actions: [
        // Status Filter Dropdown
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AdminColors.borderLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.statusFilter.value,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Status')),
                    DropdownMenuItem(value: 'active', child: Text('Active')),
                    DropdownMenuItem(
                        value: 'inactive', child: Text('Inactive')),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.setStatusFilter(value);
                  },
                ),
              ),
            )),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
              onPressed:
                  controller.isLoading.value ? null : controller.loadPromos,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.info,
                foregroundColor: Colors.white,
              ),
            )),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => Get.to(() => const PromoFormScreen()),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Promo'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Row
          Obx(() => _buildStatsRow(controller)),
          const SizedBox(height: 24),

          // Promos Grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.promos.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty &&
                  controller.promos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: AdminColors.error),
                      const SizedBox(height: 16),
                      Text(controller.errorMessage.value),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadPromos,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final filteredPromos = controller.filteredPromos;

              if (filteredPromos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.campaign_outlined,
                          size: 64, color: AdminColors.textSecondaryLight),
                      const SizedBox(height: 16),
                      Text(
                        'No promos found',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AdminColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your first promo to get started',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AdminColors.textMutedLight,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => Get.to(() => const PromoFormScreen()),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Promo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AdminColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: filteredPromos.length,
                itemBuilder: (context, index) {
                  return _buildPromoCard(
                      context, filteredPromos[index], controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(PromosController controller) {
    final totalPromos = controller.promos.length;
    final activePromos = controller.promos.where((p) => p.isActive).length;
    final inactivePromos = totalPromos - activePromos;
    final totalViews =
        controller.promos.fold<int>(0, (sum, p) => sum + p.viewCount);
    final totalClicks =
        controller.promos.fold<int>(0, (sum, p) => sum + p.clickCount);

    return Row(
      children: [
        _buildStatCard('Total Promos', totalPromos.toString(), Icons.campaign,
            AdminColors.primary),
        const SizedBox(width: 16),
        _buildStatCard('Active', activePromos.toString(), Icons.check_circle,
            AdminColors.success),
        const SizedBox(width: 16),
        _buildStatCard('Inactive', inactivePromos.toString(),
            Icons.pause_circle, AdminColors.warning),
        const SizedBox(width: 16),
        _buildStatCard('Total Views', _formatNumber(totalViews),
            Icons.visibility, AdminColors.info),
        const SizedBox(width: 16),
        _buildStatCard('Total Clicks', _formatNumber(totalClicks),
            Icons.touch_app, AdminColors.infoDark),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
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

  Widget _buildPromoCard(
      BuildContext context, dynamic promo, PromosController controller) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    promo.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AdminColors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: AdminColors.primary,
                      ),
                    ),
                  ),
                ),
                // Status badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: promo.isActive
                          ? AdminColors.success
                          : AdminColors.warning,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      promo.isActive ? 'Active' : 'Inactive',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Target roles badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      promo.targetRoles.toString().toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.titleEn,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.visibility,
                          size: 12, color: AdminColors.textSecondaryLight),
                      const SizedBox(width: 4),
                      Text(
                        '${promo.viewCount}',
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AdminColors.textSecondaryLight),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.touch_app,
                          size: 12, color: AdminColors.textSecondaryLight),
                      const SizedBox(width: 4),
                      Text(
                        '${promo.clickCount}',
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AdminColors.textSecondaryLight),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Toggle button
                      IconButton(
                        icon: Icon(
                          promo.isActive ? Icons.pause : Icons.play_arrow,
                          size: 18,
                        ),
                        onPressed: () =>
                            controller.togglePromoStatus(promo.id!),
                        tooltip: promo.isActive ? 'Deactivate' : 'Activate',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      // Edit button
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        onPressed: () =>
                            Get.to(() => PromoFormScreen(promo: promo)),
                        tooltip: 'Edit',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      // Delete button
                      IconButton(
                        icon: Icon(Icons.delete,
                            size: 18, color: AdminColors.error),
                        onPressed: () =>
                            _confirmDelete(context, promo, controller),
                        tooltip: 'Delete',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, dynamic promo, PromosController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Promo'),
        content: Text('Are you sure you want to delete "${promo.titleEn}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await controller.deletePromo(promo.id!);
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

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
