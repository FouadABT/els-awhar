import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import 'add_product_screen.dart';

/// Store products screen
/// Displays and manages products for the store
class StoreProductsScreen extends StatefulWidget {
  const StoreProductsScreen({super.key});

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> 
    with SingleTickerProviderStateMixin {
  late final StoreController _storeController;
  late TabController _tabController;
  
  int? _selectedCategoryId;
  bool _showGrid = true;

  @override
  void initState() {
    super.initState();
    _storeController = Get.find<StoreController>();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'store_products.title'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Help/Info icon
          IconButton(
            icon: Icon(Iconsax.info_circle, color: colors.textSecondary),
            onPressed: () => _showHelpDialog(context, colors),
          ),
          // Grid/List toggle
          IconButton(
            icon: Icon(
              _showGrid ? Iconsax.menu : Iconsax.grid_2,
              color: colors.textPrimary,
            ),
            onPressed: () {
              setState(() => _showGrid = !_showGrid);
            },
          ),
          // Add product
          IconButton(
            icon: Icon(Iconsax.add, color: colors.primary),
            onPressed: () => Get.to(() => const AddProductScreen()),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: colors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: colors.primary,
          tabs: [
            Tab(text: 'store_products.title'.tr),
            Tab(text: 'store_products.categories'.tr),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductsTab(colors),
          _buildCategoriesTab(colors),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AddProductScreen()),
        backgroundColor: colors.primary,
        icon: const Icon(Iconsax.add, color: Colors.white),
        label: Text(
          'store_products.add_product'.tr,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildProductsTab(dynamic colors) {
    return Obx(() {
      if (_storeController.isLoadingProducts.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final products = _storeController.products;
      final categories = _storeController.productCategories;

      // Filter by category if selected
      final filteredProducts = _selectedCategoryId != null
        ? products.where((p) => p.productCategoryId == _selectedCategoryId).toList()
        : products;

      return Column(
        children: [
          // Category filter chips
          if (categories.isNotEmpty) ...[
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _buildFilterChip(
                    'common.all'.tr,
                    _selectedCategoryId == null,
                    () => setState(() => _selectedCategoryId = null),
                    colors,
                  ),
                  ...categories.map((category) => _buildFilterChip(
                    category.name,
                    _selectedCategoryId == category.id,
                    () => setState(() => _selectedCategoryId = category.id),
                    colors,
                  )).toList(),
                ],
              ),
            ),
            SizedBox(height: 12.h),
          ],
          // Products list/grid
          Expanded(
            child: filteredProducts.isEmpty
              ? _buildEmptyState(colors)
              : _showGrid
                ? _buildProductGrid(filteredProducts, colors)
                : _buildProductList(filteredProducts, colors),
          ),
        ],
      );
    });
  }

  Widget _buildFilterChip(
    String label, 
    bool isSelected, 
    VoidCallback onTap, 
    dynamic colors,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : colors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? colors.primary : colors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(
                color: isSelected ? Colors.white : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<StoreProduct> products, dynamic colors) {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductGridCard(
          product: products[index],
          onTap: () => _editProduct(products[index]),
          onToggle: () => _toggleAvailability(products[index]),
        );
      },
    );
  }

  Widget _buildProductList(List<StoreProduct> products, dynamic colors) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductListCard(
          product: products[index],
          onTap: () => _editProduct(products[index]),
          onToggle: () => _toggleAvailability(products[index]),
          onDelete: () => _deleteProduct(products[index]),
        );
      },
    );
  }

  Widget _buildEmptyState(dynamic colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.box,
            size: 64.sp,
            color: colors.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'store_products.no_products'.tr,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'store_products.add_first_product'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.to(() => const AddProductScreen()),
              icon: const Icon(Iconsax.add, color: Colors.white),
              label: Text(
                'store_products.add_product'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(dynamic colors) {
    return Obx(() {
      final categories = _storeController.productCategories;

      if (categories.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.category,
                size: 64.sp,
                color: colors.textSecondary,
              ),
              SizedBox(height: 16.h),
              Text(
                'store_products.no_categories'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'store_products.add_first_category'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showAddCategoryDialog,
                  icon: const Icon(Iconsax.add, color: Colors.white),
                  label: Text(
                    'store_products.add_category'.tr,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: categories.length + 1, // +1 for add button
        itemBuilder: (context, index) {
          if (index == categories.length) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: OutlinedButton.icon(
                onPressed: _showAddCategoryDialog,
                icon: const Icon(Iconsax.add),
                label: Text('store_products.add_category'.tr),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            );
          }
          
          final category = categories[index];
          return _CategoryListCard(
            category: category,
            onEdit: () => _showEditCategoryDialog(category),
            onDelete: () => _deleteCategory(category),
          );
        },
      );
    });
  }

  void _editProduct(StoreProduct product) {
    Get.to(() => AddProductScreen(product: product));
  }

  Future<void> _toggleAvailability(StoreProduct product) async {
    await _storeController.toggleProductAvailability(product.id!);
  }

  Future<void> _deleteProduct(StoreProduct product) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('store_products.confirm_delete'.tr),
        content: Text('Delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'common.delete'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storeController.deleteProduct(product.id!);
    }
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: Text('store_products.add_category'.tr),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'store_products.category_name'.tr,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty) {
                await _storeController.createProductCategory(
                  name: nameController.text.trim(),
                );
                Get.back();
              }
            },
            child: Text('common.add'.tr),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(ProductCategory category) {
    final nameController = TextEditingController(text: category.name);
    
    Get.dialog(
      AlertDialog(
        title: Text('store_products.edit_category'.tr),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'store_products.category_name'.tr,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty) {
                await _storeController.updateProductCategory(
                  categoryId: category.id!,
                  name: nameController.text.trim(),
                );
                Get.back();
              }
            },
            child: Text('common.save'.tr),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCategory(ProductCategory category) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('store_products.confirm_delete'.tr),
        content: Text('Delete "${category.name}" and deactivate all its products?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              'common.delete'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _storeController.deleteProductCategory(category.id!);
    }
  }

  /// Show help dialog with instructions
  void _showHelpDialog(BuildContext context, dynamic colors) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: 600.h),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Iconsax.info_circle, color: colors.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'store_products.help_title'.tr,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              
              // Content
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHelpSection(
                        context,
                        colors,
                        'store_products.help_categories_title'.tr,
                        'store_products.help_categories_desc'.tr,
                        Iconsax.category,
                      ),
                      SizedBox(height: 16.h),
                      _buildHelpSection(
                        context,
                        colors,
                        'store_products.help_products_title'.tr,
                        'store_products.help_products_desc'.tr,
                        Iconsax.box,
                      ),
                      SizedBox(height: 16.h),
                      _buildHelpSection(
                        context,
                        colors,
                        'store_products.help_manage_title'.tr,
                        'store_products.help_manage_desc'.tr,
                        Iconsax.edit,
                      ),
                      SizedBox(height: 16.h),
                      _buildHelpSection(
                        context,
                        colors,
                        'store_products.help_tips_title'.tr,
                        'store_products.help_tips_desc'.tr,
                        Iconsax.lamp,
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'common.close'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(
    BuildContext context,
    dynamic colors,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: colors.primary, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Product grid card
class _ProductGridCard extends StatelessWidget {
  final StoreProduct product;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const _ProductGridCard({
    required this.product,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    child: product.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: colors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.gallery_slash,
                                    size: 32.sp,
                                    color: colors.textSecondary,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'No Image',
                                    style: AppTypography.labelSmall(context).copyWith(
                                      color: colors.textSecondary,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.gallery,
                                size: 36.sp,
                                color: colors.primary.withOpacity(0.5),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'No Image',
                                style: AppTypography.labelSmall(context).copyWith(
                                  color: colors.textSecondary,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                  // Availability badge
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onToggle,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: product.isAvailable 
                            ? Colors.green 
                            : Colors.red,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          product.isAvailable 
                            ? 'store_products.available'.tr 
                            : 'store_products.unavailable'.tr,
                          style: AppTypography.labelSmall(context).copyWith(
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTypography.labelMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      CurrencyHelper.format(product.price),
                      style: AppTypography.labelLarge(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Product list card
class _ProductListCard extends StatelessWidget {
  final StoreProduct product;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _ProductListCard({
    required this.product,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.all(12.w),
        leading: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: product.imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl!,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(Iconsax.box, color: colors.textSecondary),
        ),
        title: Text(
          product.name,
          style: AppTypography.labelLarge(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        subtitle: Text(
          CurrencyHelper.format(product.price),
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch.adaptive(
              value: product.isAvailable,
              onChanged: (_) => onToggle(),
              activeTrackColor: colors.primary.withValues(alpha: 0.4),
              thumbColor: WidgetStateProperty.all(colors.primary),
            ),
            IconButton(
              icon: Icon(Iconsax.trash, color: Colors.red, size: 20.sp),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// Category list card
class _CategoryListCard extends StatelessWidget {
  final ProductCategory category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CategoryListCard({
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Iconsax.category, color: colors.primary),
        ),
        title: Text(
          category.name,
          style: AppTypography.labelLarge(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        subtitle: Text(
          category.isActive ? 'Active' : 'Inactive',
          style: AppTypography.bodySmall(context).copyWith(
            color: category.isActive ? Colors.green : Colors.red,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Iconsax.edit, size: 20.sp, color: colors.textSecondary),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Iconsax.trash, size: 20.sp, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
