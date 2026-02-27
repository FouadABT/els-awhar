import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
import '../controllers/drivers_controller.dart';

/// Enhanced drivers management screen with full CRUD functionality
class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriversController());
    
    return DashboardLayout(
      title: 'Drivers Management',
      actions: [
        OutlinedButton.icon(
          onPressed: () => controller.exportDrivers(),
          icon: const Icon(Icons.file_download_outlined, size: 18),
          label: const Text('Export'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AdminColors.primary,
            side: const BorderSide(color: AdminColors.primary),
          ),
        ),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.loadDrivers,
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
          
          // Enhanced Drivers Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.drivers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.isNotEmpty && controller.drivers.isEmpty) {
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
                        onPressed: controller.loadDrivers,
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

  Widget _buildStatsCards(DriversController controller) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Drivers',
            controller.totalCount.value.toString(),
            Icons.local_taxi,
            AdminColors.info,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Online Now',
            controller.onlineCount.value.toString(),
            Icons.circle,
            AdminColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Verified',
            controller.verifiedCount.value.toString(),
            Icons.verified_user,
            AdminColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Pending Verification',
            controller.unverifiedCount.value.toString(),
            Icons.pending,
            AdminColors.warning,
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

  Widget _buildFiltersRow(DriversController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.searchQuery.value = value,
              onSubmitted: (_) => controller.loadDrivers(),
              decoration: InputDecoration(
                hintText: 'Search drivers by name, vehicle, or phone...',
                hintStyle: GoogleFonts.inter(fontSize: 14, color: AdminColors.textMutedLight),
                prefixIcon: const Icon(Icons.search, size: 20, color: AdminColors.textMutedLight),
                suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchQuery.value = '';
                          controller.loadDrivers();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.search, size: 20),
                        onPressed: controller.loadDrivers,
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
          
          // Status Filter
          Expanded(
            child: Obx(() => _buildDropdown(
              controller.selectedStatus.value,
              ['All Status', 'Online', 'Offline'],
              (value) {
                controller.selectedStatus.value = value!;
                controller.loadDrivers();
              },
            )),
          ),
          
          const SizedBox(width: 16),
          
          // Verification Filter
          Expanded(
            child: Obx(() => _buildDropdown(
              controller.selectedVerification.value,
              ['All Verification', 'Verified', 'Unverified'],
              (value) {
                controller.selectedVerification.value = value!;
                controller.loadDrivers();
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

  Widget _buildEnhancedTable(DriversController controller) {
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
                  'All Drivers',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Text(
                  'Showing ${controller.drivers.length} of ${controller.totalCount.value} entries',
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
                          label: Text('DRIVER', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('VEHICLE', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('RATING', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('EARNINGS', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('STATUS', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('VERIFIED', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('JOINED', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                        DataColumn(
                          label: Text('ACTIONS', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AdminColors.textSecondaryLight)),
                        ),
                      ],
                      rows: controller.drivers.map((driver) {
                        return DataRow(
                          cells: [
                            // Driver Info
                            DataCell(_buildDriverCell(driver)),
                            // Vehicle
                            DataCell(_buildVehicleCell(driver)),
                            // Rating
                            DataCell(_buildRatingCell(driver)),
                            // Earnings
                            DataCell(Text(
                              CurrencyHelper.format(driver.totalEarnings),
                              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AdminColors.success),
                            )),
                            // Status
                            DataCell(_buildStatusChip(driver.isOnline)),
                            // Verified
                            DataCell(_buildVerifiedChip(driver.isVerified)),
                            // Joined Date
                            DataCell(Text(
                              DateFormat('MMM d, yyyy').format(driver.createdAt),
                              style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textPrimaryLight),
                            )),
                            // Actions
                            DataCell(_buildActionButtons(controller, driver)),
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

  Widget _buildDriverCell(DriverProfile driver) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AdminColors.info.withOpacity(0.1),
          child: Text(
            driver.displayName.isNotEmpty ? driver.displayName[0].toUpperCase() : 'D',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AdminColors.info,
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
                driver.displayName.isEmpty ? 'Unknown Driver' : driver.displayName,
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
                '#D${driver.id}',
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

  Widget _buildVehicleCell(DriverProfile driver) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Icons.directions_car, size: 14, color: AdminColors.textMutedLight),
            const SizedBox(width: 6),
            Text(
              driver.vehicleType?.name ?? 'Not specified',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AdminColors.textPrimaryLight),
            ),
          ],
        ),
        if (driver.vehicleMake != null && driver.vehicleMake!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${driver.vehicleMake} ${driver.vehicleModel ?? ''}',
            style: GoogleFonts.inter(fontSize: 12, color: AdminColors.textMutedLight),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingCell(DriverProfile driver) {
    return Row(
      children: [
        const Icon(Icons.star, size: 16, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          driver.ratingAverage.toStringAsFixed(1),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AdminColors.textPrimaryLight,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${driver.totalCompletedOrders})',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AdminColors.textMutedLight,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(bool isOnline) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isOnline ? AdminColors.success : AdminColors.textMutedLight).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isOnline ? AdminColors.success : AdminColors.textMutedLight,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isOnline ? AdminColors.success : AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedChip(bool isVerified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isVerified ? AdminColors.primary : AdminColors.warning).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isVerified ? Icons.verified : Icons.pending,
            size: 14,
            color: isVerified ? AdminColors.primary : AdminColors.warning,
          ),
          const SizedBox(width: 6),
          Text(
            isVerified ? 'Verified' : 'Pending',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isVerified ? AdminColors.primary : AdminColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(DriversController controller, DriverProfile driver) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // View Details
        IconButton(
          onPressed: () => controller.showDriverDetails(driver),
          icon: const Icon(Icons.visibility_outlined, size: 18),
          tooltip: 'View Details',
          color: AdminColors.info,
        ),
        // Edit
        IconButton(
          onPressed: () => controller.editDriver(driver),
          icon: const Icon(Icons.edit_outlined, size: 18),
          tooltip: 'Edit Driver',
          color: AdminColors.primary,
        ),
        // Verify/Unverify
        if (driver.isVerified)
          IconButton(
            onPressed: () => controller.unverifyDriver(driver),
            icon: const Icon(Icons.remove_circle_outline, size: 18),
            tooltip: 'Unverify Driver',
            color: AdminColors.warning,
          )
        else
          IconButton(
            onPressed: () => controller.verifyDriver(driver.id!),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            tooltip: 'Verify Driver',
            color: AdminColors.success,
          ),
        // More Actions
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 18),
          tooltip: 'More Actions',
          onSelected: (value) {
            switch (value) {
              case 'suspend':
                controller.suspendDriver(driver);
                break;
              case 'delete':
                controller.deleteDriver(driver);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'suspend',
              child: Row(
                children: [
                  Icon(Icons.block, size: 18, color: AdminColors.warning),
                  SizedBox(width: 8),
                  Text('Suspend Driver'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 18, color: AdminColors.error),
                  SizedBox(width: 8),
                  Text('Delete Driver'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPagination(DriversController controller) {
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
                    controller.loadDrivers();
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
