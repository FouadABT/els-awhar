import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/users_controller.dart';

/// Enhanced users management screen with full CRUD functionality
class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UsersController());
    
    return DashboardLayout(
      title: 'Users Management',
      actions: [
        OutlinedButton.icon(
          onPressed: () => controller.exportUsers(),
          icon: const Icon(Icons.file_download_outlined, size: 18),
          label: const Text('Export'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AdminColors.primary,
            side: const BorderSide(color: AdminColors.primary),
          ),
        ),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.loadUsers,
          icon: controller.isLoading.value
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.refresh, size: 18),
          label: const Text('Refresh'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AdminColors.primary,
            foregroundColor: Colors.white,
          ),
        )),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          _buildStatsCards(controller),
          
          const SizedBox(height: 24),
          
          // Filters Row
          _buildFiltersRow(controller),
          
          const SizedBox(height: 24),
          
          // Enhanced Users Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.users.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.isNotEmpty && controller.users.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: AdminColors.error),
                      const SizedBox(height: 16),
                      Text(
                        controller.errorMessage.value,
                        style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textSecondaryLight),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadUsers,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              
              return _buildEnhancedTable(controller);
            }),
          ),
          
          // Pagination
          Obx(() => _buildPagination(controller)),
        ],
      ),
    );
  }

  Widget _buildStatsCards(UsersController controller) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Users',
            controller.totalCount.value.toString(),
            Icons.people_outline,
            AdminColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Active Users',
            controller.activeCount.value.toString(),
            Icons.check_circle_outline,
            AdminColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Suspended',
            controller.suspendedCount.value.toString(),
            Icons.block,
            AdminColors.warning,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Banned',
            controller.bannedCount.value.toString(),
            Icons.cancel_outlined,
            AdminColors.error,
          ),
        ),
      ],
    ));
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersRow(UsersController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Search
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (value) => controller.searchQuery.value = value,
                  onSubmitted: (_) => controller.loadUsers(),
                  decoration: InputDecoration(
                    hintText: 'Search by name, email, or phone...',
                    hintStyle: GoogleFonts.inter(fontSize: 14, color: AdminColors.textMutedLight),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AdminColors.textMutedLight),
                    suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              controller.searchController.clear();
                              controller.searchQuery.value = '';
                              controller.loadUsers();
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.search, size: 20),
                            onPressed: controller.loadUsers,
                          ),
                    ),
                    filled: true,
                    fillColor: AdminColors.backgroundLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Role Filter
              Expanded(
                child: Obx(() => _buildDropdown(
                  controller.selectedRole.value,
                  ['All Roles', 'Client', 'Driver', 'Store'],
                  (value) {
                    controller.selectedRole.value = value!;
                    controller.loadUsers();
                  },
                )),
              ),
              
              const SizedBox(width: 16),
              
              // Status Filter
              Expanded(
                child: Obx(() => _buildDropdown(
                  controller.selectedStatus.value,
                  ['All Statuses', 'Active', 'Suspended', 'Banned'],
                  (value) {
                    controller.selectedStatus.value = value!;
                    controller.loadUsers();
                  },
                )),
              ),
              
              const SizedBox(width: 16),
              
              // Clear Filters Button
              OutlinedButton.icon(
                onPressed: () => controller.clearFilters(),
                icon: const Icon(Icons.filter_alt_off, size: 18),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AdminColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AdminColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item, style: GoogleFonts.inter(fontSize: 14)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEnhancedTable(UsersController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Users',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Text(
                  'Showing ${controller.users.length} of ${controller.totalCount.value} entries',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textMutedLight,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Table Content
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: DataTable(
                      columnSpacing: 24,
                      horizontalMargin: 20,
                      headingRowHeight: 56,
                      dataRowMinHeight: 72,
                      dataRowMaxHeight: 72,
                      headingRowColor: WidgetStateProperty.all(AdminColors.backgroundLight),
                      columns: [
                        DataColumn(
                          label: Text('USER', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('CONTACT', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('ROLE', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('STATUS', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('JOINED', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('ACTIONS', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                      ],
                      rows: controller.users.map((user) {
                        return DataRow(
                          cells: [
                            // User Info
                            DataCell(_buildUserCell(user)),
                            // Contact
                            DataCell(_buildContactCell(user)),
                            // Role
                            DataCell(_buildRoleChip(user)),
                            // Status
                            DataCell(_buildStatusChip(user.status?.name ?? 'Active')),
                            // Joined Date
                            DataCell(Text(
                              DateFormat('MMM d, yyyy').format(user.createdAt),
                              style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textPrimaryLight),
                            )),
                            // Actions
                            DataCell(_buildActionButtons(controller, user)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCell(User user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AdminColors.primary.withOpacity(0.1),
          child: Text(
            user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AdminColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.fullName.isEmpty ? 'Unknown User' : user.fullName,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AdminColors.textPrimaryLight,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '#${user.id}',
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  color: AdminColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCell(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.email != null && user.email!.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 14, color: AdminColors.textMutedLight),
              const SizedBox(width: 6),
              Text(
                user.email!,
                style: GoogleFonts.inter(fontSize: 13, color: AdminColors.textPrimaryLight),
              ),
            ],
          ),
        if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 14, color: AdminColors.textMutedLight),
              const SizedBox(width: 6),
              Text(
                user.phoneNumber!,
                style: GoogleFonts.inter(fontSize: 13, color: AdminColors.textPrimaryLight),
              ),
            ],
          ),
        ],
        if ((user.email == null || user.email!.isEmpty) && (user.phoneNumber == null || user.phoneNumber!.isEmpty))
          Text(
            'No contact info',
            style: GoogleFonts.inter(fontSize: 13, color: AdminColors.textMutedLight, fontStyle: FontStyle.italic),
          ),
      ],
    );
  }

  Widget _buildRoleChip(User user) {
    final role = user.roles.isNotEmpty ? user.roles.first.name : 'Client';
    Color color;
    IconData icon;
    
    switch (role.toLowerCase()) {
      case 'driver':
        color = AdminColors.info;
        icon = Icons.local_taxi;
        break;
      case 'store':
        color = AdminColors.warning;
        icon = Icons.store;
        break;
      default:
        color = AdminColors.primary;
        icon = Icons.person;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            role,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    
    switch (status.toLowerCase()) {
      case 'active':
        color = AdminColors.success;
        icon = Icons.check_circle;
        break;
      case 'suspended':
        color = AdminColors.warning;
        icon = Icons.pause_circle;
        break;
      case 'banned':
        color = AdminColors.error;
        icon = Icons.cancel;
        break;
      default:
        color = AdminColors.textMutedLight;
        icon = Icons.help;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(UsersController controller, User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // View Details
        IconButton(
          onPressed: () => controller.showUserDetails(user),
          icon: const Icon(Icons.visibility_outlined, size: 18),
          tooltip: 'View Details',
          color: AdminColors.info,
        ),
        // Edit
        IconButton(
          onPressed: () => controller.editUser(user),
          icon: const Icon(Icons.edit_outlined, size: 18),
          tooltip: 'Edit User',
          color: AdminColors.primary,
        ),
        // Suspend/Unsuspend
        if (user.status?.name.toLowerCase() == 'suspended')
          IconButton(
            onPressed: () => controller.unsuspendUser(user.id!),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            tooltip: 'Unsuspend User',
            color: AdminColors.success,
          )
        else
          IconButton(
            onPressed: () => controller.suspendUserWithDialog(user),
            icon: const Icon(Icons.block, size: 18),
            tooltip: 'Suspend User',
            color: AdminColors.warning,
          ),
        // Delete/Ban
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 18),
          tooltip: 'More Actions',
          onSelected: (value) {
            switch (value) {
              case 'ban':
                controller.banUser(user);
                break;
              case 'delete':
                controller.deleteUser(user);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'ban',
              child: Row(
                children: [
                  Icon(Icons.cancel, size: 18, color: AdminColors.error),
                  SizedBox(width: 8),
                  Text('Ban User'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 18, color: AdminColors.error),
                  SizedBox(width: 8),
                  Text('Delete User'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPagination(UsersController controller) {
    final totalPages = (controller.totalCount.value / controller.pageSize.value).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${((controller.currentPage.value - 1) * controller.pageSize.value) + 1} to ${(controller.currentPage.value * controller.pageSize.value).clamp(0, controller.totalCount.value)} of ${controller.totalCount.value} entries',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AdminColors.textMutedLight,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: controller.currentPage.value > 1 
                    ? () => controller.goToPage(controller.currentPage.value - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(width: 8),
              ...List.generate(
                totalPages > 5 ? 5 : totalPages,
                (index) {
                  int pageNum;
                  if (totalPages <= 5) {
                    pageNum = index + 1;
                  } else if (controller.currentPage.value <= 3) {
                    pageNum = index + 1;
                  } else if (controller.currentPage.value >= totalPages - 2) {
                    pageNum = totalPages - 4 + index;
                  } else {
                    pageNum = controller.currentPage.value - 2 + index;
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildPageButton(
                      pageNum,
                      controller.currentPage.value == pageNum,
                      () => controller.goToPage(pageNum),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: controller.currentPage.value < totalPages
                    ? () => controller.goToPage(controller.currentPage.value + 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          // Page size selector
          Row(
            children: [
              Text(
                'Rows per page:',
                style: GoogleFonts.inter(fontSize: 13, color: AdminColors.textMutedLight),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: controller.pageSize.value,
                underline: const SizedBox(),
                items: [10, 20, 50, 100].map((size) => DropdownMenuItem(
                  value: size,
                  child: Text('$size', style: GoogleFonts.inter(fontSize: 13)),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.pageSize.value = value;
                    controller.currentPage.value = 1;
                    controller.loadUsers();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(int pageNum, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isActive ? AdminColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AdminColors.primary : AdminColors.borderSoftLight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '$pageNum',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? Colors.white : AdminColors.textPrimaryLight,
          ),
        ),
      ),
    );
  }
}
