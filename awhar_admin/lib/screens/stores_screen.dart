import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/stores_controller.dart';

/// Enhanced stores management screen with full CRUD functionality
class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoresController());
    
    return DashboardLayout(
      title: 'Stores Management',
      actions: [
        Obx(() => OutlinedButton.icon(
          onPressed: controller.stores.isEmpty ? null : controller.exportStores,
          icon: const Icon(Icons.file_download_outlined, size: 18),
          label: const Text('Export CSV'),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AdminColors.primary),
            foregroundColor: AdminColors.primary,
          ),
        )),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
          onPressed: controller.isLoading.value ? null : controller.refresh,
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
          _buildStatisticsCards(controller),
          
          const SizedBox(height: 24),
          
          // Filters Row
          _buildFiltersRow(controller),
          
          const SizedBox(height: 24),
          
          // Stores Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.stores.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.isNotEmpty && controller.stores.isEmpty) {
                return _buildErrorState(controller);
              }
              
              if (controller.stores.isEmpty) {
                return _buildEmptyState();
              }
              
              return _buildStoresTable(controller);
            }),
          ),
          
          // Pagination
          const SizedBox(height: 16),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(StoresController controller) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Stores',
            controller.totalCount.value.toString(),
            Icons.store,
            AdminColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Active Stores',
            controller.activeCount.value.toString(),
            Icons.check_circle,
            AdminColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Inactive Stores',
            controller.inactiveCount.value.toString(),
            Icons.cancel,
            AdminColors.error,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Avg Rating',
            controller.averageRating.value.toStringAsFixed(1),
            Icons.star,
            AdminColors.warning,
          ),
        ),
      ],
    ));
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersRow(StoresController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search stores...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchQuery.value = '';
                          controller.loadStores();
                        },
                      )
                    : const SizedBox.shrink()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
                controller.loadStores();
              },
            ),
          ),
          const SizedBox(width: 16),
          
          // Status Filter
          Obx(() => SizedBox(
            width: 200,
            child: DropdownButtonFormField<String>(
              value: controller.selectedStatus.value,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: ['All Status', 'Active', 'Inactive'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.inter(fontSize: 14)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedStatus.value = newValue;
                  controller.loadStores();
                }
              },
            ),
          )),
          const SizedBox(width: 16),
          
          // Clear Filters Button
          OutlinedButton.icon(
            onPressed: controller.clearFilters,
            icon: const Icon(Icons.filter_alt_off, size: 18),
            label: const Text('Clear Filters'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresTable(StoresController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AdminColors.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Stores (${controller.stores.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Obx(() => Text(
                  'Page ${controller.currentPage.value} • ${controller.stores.length} results',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                )),
              ],
            ),
          ),
          
          // Table Content
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Table(
                columnWidths: const {
                  0: FlexColumnWidth(0.7),  // ID
                  1: FlexColumnWidth(2.2),  // Name
                  2: FlexColumnWidth(1.6),  // Category
                  3: FlexColumnWidth(1.6),  // Location
                  4: FlexColumnWidth(1.0),  // Rating
                  5: FlexColumnWidth(1.2),  // Orders
                  6: FlexColumnWidth(1.1),  // Status
                  7: FlexColumnWidth(2.0),  // Actions
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(
                      color: AdminColors.backgroundLight,
                      border: Border(bottom: BorderSide(color: AdminColors.borderLight)),
                    ),
                    children: [
                      _buildHeaderCell('ID'),
                      _buildHeaderCell('Name'),
                      _buildHeaderCell('Category'),
                      _buildHeaderCell('Location'),
                      _buildHeaderCell('Rating'),
                      _buildHeaderCell('Orders'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('Actions'),
                    ],
                  ),
                  // Data Rows
                  ...controller.stores.asMap().entries.map((entry) {
                    final store = entry.value;
                    return TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: AdminColors.borderLight.withOpacity(0.5))),
                      ),
                      children: [
                        _buildDataCell('S${store.id}'),
                        _buildNameCell(store),
                        _buildCategoryCell(store),
                        _buildLocationCell(store),
                        _buildRatingCell(store),
                        _buildOrdersCell(store),
                        _buildStatusCell(store),
                        _buildActionsCell(controller, store),
                      ],
                    );
                  }).toList(),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AdminColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AdminColors.textPrimaryLight,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildNameCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (store.logoUrl != null && store.logoUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                store.logoUrl!,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 32,
                  height: 32,
                  color: AdminColors.backgroundLight,
                  child: const Icon(Icons.store, size: 16, color: AdminColors.textMutedLight),
                ),
              ),
            )
          else
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AdminColors.backgroundLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.store, size: 16, color: AdminColors.textMutedLight),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AdminColors.textPrimaryLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (store.tagline != null && store.tagline!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    store.tagline!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AdminColors.textMutedLight,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        'Category #${store.storeCategoryId}',
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AdminColors.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildLocationCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.city ?? 'N/A',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            store.address.length > 30 ? '${store.address.substring(0, 30)}...' : store.address,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          const Icon(Icons.star, color: AdminColors.warning, size: 16),
          const SizedBox(width: 4),
          Text(
            store.rating.toStringAsFixed(1),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '(${store.totalRatings})',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        '${store.totalOrders} orders',
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AdminColors.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildStatusCell(Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: store.isActive 
              ? AdminColors.success.withOpacity(0.1) 
              : AdminColors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          store.isActive ? 'Active' : 'Inactive',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: store.isActive ? AdminColors.success : AdminColors.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildActionsCell(StoresController controller, Store store) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility, size: 18),
            onPressed: () => controller.showStoreDetails(store),
            tooltip: 'View Details',
            color: AdminColors.primary,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () => controller.editStore(store),
            tooltip: 'Edit Store',
            color: AdminColors.info,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: Icon(store.isActive ? Icons.block : Icons.check_circle, size: 18),
            onPressed: () => store.isActive 
                ? controller.deactivateStore(store)
                : controller.activateStore(store),
            tooltip: store.isActive ? 'Deactivate' : 'Activate',
            color: store.isActive ? AdminColors.warning : AdminColors.success,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 18),
            onPressed: () => controller.deleteStore(store),
            tooltip: 'Delete Store',
            color: AdminColors.error,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(StoresController controller) {
    return Obx(() {
      final totalPages = (controller.totalCount.value / controller.pageSize.value).ceil();
      if (totalPages <= 1) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Page Size Selector
            Row(
              children: [
                Text(
                  'Show:',
                  style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textSecondaryLight),
                ),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: controller.pageSize.value,
                  items: [10, 20, 50, 100].map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: Text('$size', style: GoogleFonts.inter(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.pageSize.value = value;
                      controller.currentPage.value = 1;
                      controller.loadStores();
                    }
                  },
                  underline: const SizedBox.shrink(),
                ),
              ],
            ),
            
            // Page Navigation
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: controller.currentPage.value > 1
                      ? () => controller.goToPage(controller.currentPage.value - 1)
                      : null,
                ),
                ...List.generate(
                  totalPages > 5 ? 5 : totalPages,
                  (index) {
                    final pageNum = index + 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => controller.goToPage(pageNum),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == pageNum
                                ? AdminColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$pageNum',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: controller.currentPage.value == pageNum
                                  ? Colors.white
                                  : AdminColors.textPrimaryLight,
                              fontWeight: controller.currentPage.value == pageNum
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: controller.currentPage.value < totalPages
                      ? () => controller.goToPage(controller.currentPage.value + 1)
                      : null,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildErrorState(StoresController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AdminColors.error),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            style: GoogleFonts.inter(fontSize: 16, color: AdminColors.textSecondaryLight),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_outlined, size: 64, color: AdminColors.textMutedLight),
          const SizedBox(height: 16),
          Text(
            'No stores found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Stores will appear here once they register',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }
}
