import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../shared/widgets/notification_bell.dart';
import 'store_detail_screen.dart';

/// Helper to map icon names to Iconsax icons
IconData _getIconFromName(String iconName) {
  switch (iconName.toLowerCase()) {
    case 'shop':
      return Iconsax.shop;
    case 'bag':
      return Iconsax.bag;
    case 'coffee':
      return Iconsax.coffee;
    case 'shopping_cart':
      return Iconsax.shopping_cart;
    case 'health':
      return Iconsax.health;
    case 'mobile':
      return Iconsax.mobile;
    case 'gift':
      return Iconsax.gift;
    case 'heart':
      return Iconsax.heart;
    case 'book':
      return Iconsax.book;
    default:
      return Iconsax.shop;
  }
}

/// Controller for client store browsing
class ClientStoreController extends GetxController {
  final _client = Get.find<Client>();
  final _authController = Get.find<AuthController>();

  // Categories
  final RxList<StoreCategory> categories = <StoreCategory>[].obs;
  final Rx<StoreCategory?> selectedCategory = Rx<StoreCategory?>(null);

  // Stores
  final RxList<Store> stores = <Store>[].obs;
  final RxList<Store> nearbyStores = <Store>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Filters
  final RxBool openOnly = false.obs;
  final RxDouble maxDistance =
      50.0.obs; // Increased from 10.0 to 50.0 to show more stores
  final RxString searchQuery = ''.obs;

  // User location
  double get userLatitude {
    final user = _authController.currentUser.value;
    return user?.currentLatitude ?? 33.5731;
  }

  double get userLongitude {
    final user = _authController.currentUser.value;
    return user?.currentLongitude ?? -7.5898;
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    // Ensure nearby stores are loaded even if no category is selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (stores.isEmpty) {
        loadNearbyStores();
      }
    });
  }

  Future<void> loadCategories() async {
    try {
      final result = await _client.store.getStoreCategories();
      categories.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load categories';
    }
  }

  Future<void> loadNearbyStores() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _client.store.getNearbyStores(
        latitude: userLatitude,
        longitude: userLongitude,
        radiusKm: maxDistance.value,
        categoryId: selectedCategory.value?.id,
        openOnly: openOnly.value,
      );

      nearbyStores.assignAll(result);
      stores.assignAll(result);

      // Debug logging
      debugPrint(
        '[ClientStoreController] Loaded ${result.length} stores with category=${selectedCategory.value?.id}, radius=${maxDistance.value}km',
      );

      if (result.isEmpty && selectedCategory.value == null) {
        // If no stores found for "All" with current radius, suggest increasing radius
        errorMessage.value =
            'No stores found nearby. Try adjusting filters or search by category.';
      }
    } catch (e) {
      debugPrint('[ClientStoreController] Error loading stores: $e');
      errorMessage.value = 'Failed to load stores: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadStoresByCategory(int categoryId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _client.store.getStoresByCategory(
        categoryId: categoryId,
        latitude: userLatitude,
        longitude: userLongitude,
        openOnly: openOnly.value,
      );

      stores.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load stores';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchStores(String query) async {
    if (query.isEmpty) {
      loadNearbyStores();
      return;
    }

    try {
      isLoading.value = true;
      searchQuery.value = query;

      final result = await _client.store.searchStores(
        query: query,
        latitude: userLatitude,
        longitude: userLongitude,
        categoryId: selectedCategory.value?.id,
      );

      stores.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Search failed';
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(StoreCategory? category) {
    selectedCategory.value = category;
    if (category == null) {
      loadNearbyStores();
    } else {
      loadStoresByCategory(category.id!);
    }
  }

  void toggleOpenOnly() {
    openOnly.value = !openOnly.value;
    loadNearbyStores();
  }

  void refreshStores() {
    loadCategories();
    loadNearbyStores();
  }
}

/// Client store browsing screen
class ClientStoresScreen extends StatelessWidget {
  const ClientStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.put(ClientStoreController());

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.stores.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refreshStores(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildHeader(context, colors, controller),
                      _buildCategoryChips(context, colors, controller),
                      _buildFilters(context, colors, controller),
                    ],
                  ),
                ),
                _buildStoreListSliver(context, colors, controller),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    dynamic colors,
    ClientStoreController controller,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'store_browsing.title'.tr,
                      style: AppTypography.headlineMedium(context).copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'store_browsing.nearby'.tr,
                          style: AppTypography.labelSmall(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const NotificationBell(),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: TextField(
              onChanged: (value) => controller.searchStores(value),
              decoration: InputDecoration(
                hintText: 'store_browsing.search_hint'.tr,
                hintStyle: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  color: colors.textSecondary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(
    BuildContext context,
    dynamic colors,
    ClientStoreController controller,
  ) {
    return SizedBox(
      height: 100.h,
      child: Obx(() {
        if (controller.categories.isEmpty) {
          return const SizedBox();
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Obx(
                () => _buildCategoryChip(
                  context,
                  colors,
                  name: 'common.all'.tr,
                  icon: Iconsax.category,
                  isSelected: controller.selectedCategory.value == null,
                  onTap: () => controller.selectCategory(null),
                ),
              );
            }

            final category = controller.categories[index - 1];
            return Obx(
              () => _buildCategoryChip(
                context,
                colors,
                name: category.nameEn,
                icon: _getIconFromName(category.iconName),
                imageUrl: category.iconUrl,
                isSelected:
                    controller.selectedCategory.value?.id == category.id,
                onTap: () => controller.selectCategory(category),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    dynamic colors, {
    required String name,
    IconData? icon,
    String? imageUrl,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: isSelected ? colors.primary : colors.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? colors.primary : colors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Icon(Iconsax.shop, color: colors.textSecondary),
                        errorWidget: (_, __, ___) =>
                            Icon(Iconsax.shop, color: colors.textSecondary),
                      ),
                    )
                  : Icon(
                      icon ?? Iconsax.shop,
                      color: isSelected ? Colors.white : colors.textSecondary,
                      size: 24.sp,
                    ),
            ),
            SizedBox(height: 8.h),
            Text(
              name,
              style: AppTypography.labelSmall(context).copyWith(
                color: isSelected ? colors.primary : colors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(
    BuildContext context,
    dynamic colors,
    ClientStoreController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Obx(
            () => FilterChip(
              label: Text(
                'store_browsing.open_now'.tr,
                style: AppTypography.labelSmall(context).copyWith(
                  color: controller.openOnly.value
                      ? Colors.white
                      : colors.textPrimary,
                ),
              ),
              selected: controller.openOnly.value,
              onSelected: (_) => controller.toggleOpenOnly(),
              selectedColor: colors.primary,
              checkmarkColor: Colors.white,
              backgroundColor: colors.surface,
            ),
          ),
          SizedBox(width: 8.w),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.location,
                    size: 14.sp,
                    color: colors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${controller.maxDistance.value.toInt()} km',
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Obx(
            () => Text(
              '${controller.stores.length} ${'store_browsing.stores_found'.tr}',
              style: AppTypography.labelSmall(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreListSliver(
    BuildContext context,
    dynamic colors,
    ClientStoreController controller,
  ) {
    return Obx(() {
      if (controller.errorMessage.value.isNotEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.warning_2, size: 48.sp, color: colors.error),
                SizedBox(height: 16.h),
                Text(
                  controller.errorMessage.value,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.refreshStores,
                  child: Text('common.retry'.tr),
                ),
              ],
            ),
          ),
        );
      }

      if (controller.stores.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.shop, size: 64.sp, color: colors.textSecondary),
                SizedBox(height: 16.h),
                Text(
                  'store_browsing.no_stores'.tr,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.all(16.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final store = controller.stores[index];
              return _buildStoreCard(context, colors, store);
            },
            childCount: controller.stores.length,
          ),
        ),
      );
    });
  }

  Widget _buildStoreList(
    BuildContext context,
    dynamic colors,
    ClientStoreController controller,
  ) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.warning_2, size: 48.sp, color: colors.error),
              SizedBox(height: 16.h),
              Text(
                controller.errorMessage.value,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: controller.refreshStores,
                child: Text('common.retry'.tr),
              ),
            ],
          ),
        );
      }

      if (controller.stores.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.shop, size: 64.sp, color: colors.textSecondary),
              SizedBox(height: 16.h),
              Text(
                'store_browsing.no_stores'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => controller.refreshStores(),
        child: ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.stores.length,
          itemBuilder: (context, index) {
            final store = controller.stores[index];
            return _buildStoreCard(context, colors, store);
          },
        ),
      );
    });
  }

  Widget _buildStoreCard(BuildContext context, dynamic colors, Store store) {
    // Calculate delivery info
    final hasMinOrder =
        store.minimumOrderAmount != null && store.minimumOrderAmount! > 0;
    final hasPrepTime =
        store.estimatedPrepTimeMinutes != null &&
        store.estimatedPrepTimeMinutes! > 0;

    return GestureDetector(
      onTap: () => Get.to(() => StoreDetailScreen(storeId: store.id!)),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced cover image with gradient overlay
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: store.coverImageUrl ?? '',
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      height: 160.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary.withValues(alpha: 0.2),
                            colors.primary.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.shop,
                          size: 48.sp,
                          color: colors.primary,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 160.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary.withValues(alpha: 0.2),
                            colors.primary.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.shop,
                          size: 48.sp,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay for better text visibility
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Status badge
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: store.isOpen
                            ? Colors.green.withValues(alpha: 0.95)
                            : Colors.red.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            store.isOpen
                                ? 'store_browsing.open'.tr
                                : 'store_browsing.closed'.tr,
                            style: AppTypography.labelSmall(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Logo overlay at bottom
                  Positioned(
                    bottom: -25.h,
                    left: 16.w,
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: colors.surface, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: store.logoUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(13.r),
                              child: CachedNetworkImage(
                                imageUrl: store.logoUrl!,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Icon(
                                  Iconsax.shop,
                                  color: colors.primary,
                                  size: 24.sp,
                                ),
                                errorWidget: (_, __, ___) => Icon(
                                  Iconsax.shop,
                                  color: colors.primary,
                                  size: 24.sp,
                                ),
                              ),
                            )
                          : Icon(
                              Iconsax.shop,
                              color: colors.primary,
                              size: 28.sp,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            // Store info section
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Store name and tagline
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.name,
                              style: AppTypography.titleLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (store.tagline != null &&
                                store.tagline!.isNotEmpty) ...[
                              SizedBox(height: 2.h),
                              Text(
                                store.tagline!,
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: colors.primary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Rating and reviews
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.star_1,
                              size: 14.sp,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              store.rating.toStringAsFixed(1),
                              style: AppTypography.labelMedium(context)
                                  .copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${store.totalRatings} ${'store_detail.reviews'.tr}',
                        style: AppTypography.bodySmall(
                          context,
                        ).copyWith(color: colors.textSecondary),
                      ),
                      SizedBox(width: 12.w),
                      if (store.totalOrders > 0) ...[
                        Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            color: colors.textSecondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Icon(
                          Iconsax.shopping_bag,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${store.totalOrders}+ orders',
                          style: AppTypography.bodySmall(
                            context,
                          ).copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Service options badges
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      if (store.hasDelivery == true)
                        _buildFeatureBadge(
                          context,
                          colors,
                          Iconsax.truck_fast,
                          'Delivery',
                        ),
                      if (store.hasPickup == true)
                        _buildFeatureBadge(
                          context,
                          colors,
                          Iconsax.box,
                          'Pickup',
                        ),
                      if (store.acceptsCash == true)
                        _buildFeatureBadge(
                          context,
                          colors,
                          Iconsax.money,
                          'Cash',
                        ),
                      if (store.acceptsCard == true)
                        _buildFeatureBadge(
                          context,
                          colors,
                          Iconsax.card,
                          'Card',
                        ),
                    ],
                  ),

                  // Divider
                  if (hasMinOrder ||
                      hasPrepTime ||
                      store.description != null) ...[
                    SizedBox(height: 12.h),
                    Divider(color: colors.border, height: 1),
                    SizedBox(height: 12.h),
                  ],

                  // Delivery info row
                  if (hasMinOrder || hasPrepTime)
                    Row(
                      children: [
                        if (hasMinOrder) ...[
                          Icon(
                            Iconsax.wallet,
                            size: 16.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Min ${CurrencyHelper.format(store.minimumOrderAmount!)}',
                            style: AppTypography.bodySmall(
                              context,
                            ).copyWith(color: colors.textSecondary),
                          ),
                        ],
                        if (hasMinOrder && hasPrepTime) ...[
                          SizedBox(width: 16.w),
                          Container(
                            width: 3.w,
                            height: 3.w,
                            decoration: BoxDecoration(
                              color: colors.textSecondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                        if (hasPrepTime) ...[
                          Icon(
                            Iconsax.clock,
                            size: 16.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${store.estimatedPrepTimeMinutes} min',
                            style: AppTypography.bodySmall(
                              context,
                            ).copyWith(color: colors.textSecondary),
                          ),
                        ],
                        const Spacer(),
                        Icon(
                          Iconsax.location,
                          size: 16.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${store.deliveryRadiusKm.toStringAsFixed(1)} km',
                          style: AppTypography.bodySmall(
                            context,
                          ).copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),

                  // Description
                  if (store.description != null &&
                      store.description!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      store.description!,
                      style: AppTypography.bodySmall(
                        context,
                      ).copyWith(color: colors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBadge(
    BuildContext context,
    dynamic colors,
    IconData icon,
    String label,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: colors.primary),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
