import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/service_catalog_controller.dart';
import '../../../../shared/widgets/notification_bell.dart';
import '../../../../shared/widgets/catalog_filter_sheet.dart';
import '../../../routes/app_routes.dart';
import '../../../../shared/widgets/live_driver_card.dart';
import '../catalog/driver_catalog_screen.dart';

/// Client explore screen for browsing service catalog
class ClientExploreScreen extends StatefulWidget {
  const ClientExploreScreen({super.key});

  @override
  State<ClientExploreScreen> createState() => _ClientExploreScreenState();
}

class _ClientExploreScreenState extends State<ClientExploreScreen>
    with TickerProviderStateMixin {
  late final ServiceCatalogController _controller;
  final TextEditingController _searchController = TextEditingController();
  final RxBool _isFilterExpanded = false.obs;
  late final AnimationController _filterAnimController;
  late final Animation<double> _filterAnimation;
  
  // Tab controller for All/Live tabs
  late final TabController _tabController;
  final RxInt _currentTabIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ServiceCatalogController());
    _filterAnimController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterAnimController,
      curve: Curves.easeInOut,
    );
    
    // Initialize tab controller
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _currentTabIndex.value = _tabController.index;
      if (_tabController.index == 1) {
        // Start live monitoring when switching to Live tab
        _controller.startLiveDriversMonitoring();
      } else {
        // Stop monitoring when switching away from Live tab
        _controller.stopLiveDriversMonitoring();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterAnimController.dispose();
    _tabController.dispose();
    _controller.stopLiveDriversMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search and location
            _buildHeader(context, colors),
            
            // Tab Bar
            _buildTabBar(context, colors),
            
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // All Drivers Tab
                  _buildAllDriversTab(context, colors),
                  
                  // Live Drivers Tab
                  _buildLiveDriversTab(context, colors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER SECTION
  // ============================================================

  Widget _buildHeader(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row with notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'client.catalog.explore_services'.tr,
                    style: AppTypography.headlineLarge(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Obx(
                    () => Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _controller.maxDistance.value < 50
                              ? 'client.catalog.within_km'.trParams({
                                  'km': _controller.maxDistance.value
                                      .toStringAsFixed(0),
                                })
                              : 'client.catalog.nearby'.tr,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // AI Smart Search button
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.smartSearch),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: colors.primary,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const NotificationBell(),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Search and filter section
          _buildSearchSection(context, colors),
        ],
      ),
    );
  }
  
  // ============================================================
  // TAB BAR
  // ============================================================
  
  Widget _buildTabBar(BuildContext context, AppColorScheme colors) {
    // Debug tab translations
    final allDriversKey = 'client.catalog.all_drivers';
    final liveNowKey = 'client.catalog.live_now';
    final allDriversText = allDriversKey.tr;
    final liveNowText = liveNowKey.tr;
    
    print('🔍 [Tab Translation Debug] all_drivers: "$allDriversText" (key: $allDriversKey)');
    print('🔍 [Tab Translation Debug] live_now: "$liveNowText" (key: $liveNowKey)');
    
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border.withValues(alpha: 0.5)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: AppTypography.bodyMedium(context).copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: AppTypography.bodyMedium(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.all(4.w),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.grid_1, size: 16.sp),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    allDriversText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.flash_1, size: 16.sp),
                SizedBox(width: 4.w),
                Flexible(
                  child: Obx(() {
                    final count = _controller.liveDrivers.length;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          liveNowText,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (count > 0) ...[
                          SizedBox(width: 4.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: _currentTabIndex.value == 1
                                  ? Colors.white.withValues(alpha: 0.25)
                                  : colors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                color: _currentTabIndex.value == 1
                                    ? Colors.white
                                    : colors.success,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // ============================================================
  // ALL DRIVERS TAB
  // ============================================================
  
  Widget _buildAllDriversTab(BuildContext context, AppColorScheme colors) {
    return RefreshIndicator(
      onRefresh: _controller.refresh,
      color: colors.primary,
      child: CustomScrollView(
        slivers: [
          // Category chips
          _buildCategorySection(context, colors),

          // Active filters indicator
          Obx(() {
            if (_controller.activeFilterCount > 0) {
              return _buildFilterChips(context, colors);
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }),

          // Drivers grid
          _buildDriversGrid(context, colors),
        ],
      ),
    );
  }
  
  // ============================================================
  // LIVE DRIVERS TAB
  // ============================================================
  
  Widget _buildLiveDriversTab(BuildContext context, AppColorScheme colors) {
    return Obx(() {
      if (_controller.isLoadingLiveDrivers.value && _controller.liveDrivers.isEmpty) {
        return _buildLiveDriversShimmer(colors);
      }

      if (_controller.liveDrivers.isEmpty) {
        return _buildNoLiveDrivers(context, colors);
      }

      return RefreshIndicator(
        onRefresh: _controller.loadLiveDrivers,
        color: colors.primary,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
          itemCount: _controller.liveDrivers.length,
          itemBuilder: (context, index) {
            final driver = _controller.liveDrivers[index];
            final lastSeenText = _controller.getLastSeenText(driver);
            
            return LiveDriverCard(
              driver: driver,
              lastSeenText: lastSeenText,
              onTap: () => _navigateToDriverCatalog(driver),
            );
          },
        ),
      );
    });
  }
  
  Widget _buildLiveDriversShimmer(AppColorScheme colors) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      color: colors.border,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: colors.border,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 120.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: colors.border,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: 40.h,
                      margin: EdgeInsets.only(right: index < 2 ? 10.w : 0),
                      decoration: BoxDecoration(
                        color: colors.border,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildNoLiveDrivers(BuildContext context, AppColorScheme colors) {
    // Debug translations
    final noLiveDriversKey = 'client.catalog.no_live_drivers';
    final noLiveDriversDescKey = 'client.catalog.no_live_drivers_desc';
    final refreshKey = 'common.refresh';
    
    final noLiveDriversText = noLiveDriversKey.tr;
    final noLiveDriversDescText = noLiveDriversDescKey.tr;
    final refreshText = refreshKey.tr;
    
    print('🔍 [Translation Debug] no_live_drivers: "$noLiveDriversText" (key: $noLiveDriversKey)');
    print('🔍 [Translation Debug] no_live_drivers_desc: "$noLiveDriversDescText" (key: $noLiveDriversDescKey)');
    print('🔍 [Translation Debug] refresh: "$refreshText" (key: $refreshKey)');
    print('🔍 [Translation Debug] Current locale: ${Get.locale}');
    
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.flash_1,
              size: 64.sp,
              color: colors.textSecondary.withValues(alpha: 0.5),
            ),
            SizedBox(height: 20.h),
            Text(
              noLiveDriversText,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              noLiveDriversDescText,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: _controller.loadLiveDrivers,
              icon: Icon(Iconsax.refresh, size: 18.sp),
              label: Text(refreshText),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER SECTION (OLD - NOW SIMPLIFIED)
  // ============================================================

  Widget _buildHeaderOld(BuildContext context, AppColorScheme colors) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row with notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'client.catalog.explore_services'.tr,
                          style: AppTypography.headlineLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Obx(
                          () => Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                size: 14.sp,
                                color: colors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _controller.maxDistance.value < 50
                                    ? 'client.catalog.within_km'.trParams({
                                        'km': _controller.maxDistance.value
                                            .toStringAsFixed(0),
                                      })
                                    : 'client.catalog.nearby'.tr,
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: colors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const NotificationBell(),
                  ],
                ),
                SizedBox(height: 20.h),
                // Search and filter section
                _buildSearchSection(context, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, AppColorScheme colors) {
    return Column(
      children: [
        // Search input row
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: colors.border,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(
                  Iconsax.search_normal_1,
                  color: colors.textSecondary.withValues(alpha: 0.7),
                  size: 18.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _controller.searchDrivers,
                    decoration: InputDecoration(
                      hintText: 'client.catalog.search_drivers'.tr,
                      hintStyle: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textSecondary.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                        height: 1.4,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                    cursorColor: colors.primary,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                // Clear button
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, child) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return InkWell(
                      onTap: () {
                        _searchController.clear();
                        _controller.searchDrivers('');
                      },
                      borderRadius: BorderRadius.circular(999),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                        child: Icon(
                          Icons.close_rounded,
                          size: 16.sp,
                          color: colors.textSecondary,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 6.w),
                // Filter toggle button
                Obx(
                  () => InkWell(
                    onTap: _toggleFilter,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 36.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color:
                            _isFilterExpanded.value ||
                                _controller.activeFilterCount > 0
                            ? colors.primary
                            : colors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.setting_4,
                            size: 16.sp,
                            color:
                                _isFilterExpanded.value ||
                                    _controller.activeFilterCount > 0
                                ? Colors.white
                                : colors.primary,
                          ),
                          if (_controller.activeFilterCount > 0) ...[
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${_controller.activeFilterCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expandable filter section
        SizeTransition(
          sizeFactor: _filterAnimation,
          axisAlignment: -1,
          child: _buildQuickFilters(context, colors),
        ),
      ],
    );
  }

  void _toggleFilter() {
    _isFilterExpanded.value = !_isFilterExpanded.value;
    if (_isFilterExpanded.value) {
      _filterAnimController.forward();
    } else {
      _filterAnimController.reverse();
    }
  }

  Widget _buildQuickFilters(BuildContext context, AppColorScheme colors) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: colors.border.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Distance filter
          _buildFilterRow(
            context,
            colors,
            icon: Iconsax.location,
            label: 'client.catalog.distance'.tr,
            child: Obx(
              () => Row(
                children: [
                  _buildQuickChip(
                    context,
                    colors,
                    '5 km',
                    isSelected: _controller.maxDistance.value == 5,
                    onTap: () => _controller.setMaxDistance(5),
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    '15 km',
                    isSelected: _controller.maxDistance.value == 15,
                    onTap: () => _controller.setMaxDistance(15),
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    '30 km',
                    isSelected: _controller.maxDistance.value == 30,
                    onTap: () => _controller.setMaxDistance(30),
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    'common.all'.tr,
                    isSelected: _controller.maxDistance.value >= 50,
                    onTap: () => _controller.setMaxDistance(100),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Rating filter
          _buildFilterRow(
            context,
            colors,
            icon: Iconsax.star,
            label: 'client.catalog.min_rating'.tr,
            child: Obx(
              () => Row(
                children: [
                  _buildQuickChip(
                    context,
                    colors,
                    'common.any'.tr,
                    isSelected: _controller.minRating.value == 0,
                    onTap: () => _controller.setMinRating(0),
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    '3+',
                    isSelected: _controller.minRating.value == 3,
                    onTap: () => _controller.setMinRating(3),
                    icon: Iconsax.star_1,
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    '4+',
                    isSelected: _controller.minRating.value == 4,
                    onTap: () => _controller.setMinRating(4),
                    icon: Iconsax.star_1,
                  ),
                  SizedBox(width: 8.w),
                  _buildQuickChip(
                    context,
                    colors,
                    '4.5+',
                    isSelected: _controller.minRating.value == 4.5,
                    onTap: () => _controller.setMinRating(4.5),
                    icon: Iconsax.star_1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _controller.resetFilters,
                  icon: Icon(Iconsax.refresh, size: 18.sp),
                  label: Text('common.reset'.tr),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.textSecondary,
                    side: BorderSide(color: colors.border),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showFilterSheet,
                  icon: Icon(Iconsax.setting_4, size: 18.sp),
                  label: Text('client.catalog.more_filters'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(
    BuildContext context,
    AppColorScheme colors, {
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16.sp, color: colors.textSecondary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: child,
        ),
      ],
    );
  }

  Widget _buildQuickChip(
    BuildContext context,
    AppColorScheme colors,
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.background,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14.sp,
                color: isSelected ? Colors.white : colors.textSecondary,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(
                color: isSelected ? Colors.white : colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY SECTION
  // ============================================================

  Widget _buildCategorySection(BuildContext context, AppColorScheme colors) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (_controller.isLoadingCategories.value) {
          return _buildCategoryShimmer(colors);
        }

        if (_controller.categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
              child: Text(
                'client.catalog.categories'.tr,
                style: AppTypography.headlineMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 84.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                itemCount: _controller.categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _CategoryChip(
                      label: 'common.all'.tr,
                      icon: Iconsax.grid_1,
                      isSelected: _controller.selectedCategory.value == null,
                      colors: colors,
                      onTap: () => _controller.selectCategory(null),
                    );
                  }
                  final category = _controller.categories[index - 1];
                  return _CategoryChip(
                    label: category.name,
                    icon: _getCategoryIcon(category.icon),
                    isSelected:
                        _controller.selectedCategory.value?.id == category.id,
                    colors: colors,
                    onTap: () => _controller.selectCategory(category),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCategoryShimmer(AppColorScheme colors) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 80.w,
            margin: EdgeInsets.only(right: 12.w),
            child: Column(
              children: [
                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 60.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FILTER CHIPS
  // ============================================================

  Widget _buildFilterChips(BuildContext context, AppColorScheme colors) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _showFilterSheet,
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: colors.primary.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.tune, size: 14.sp, color: colors.primary),
                                SizedBox(width: 6.w),
                                Text(
                                  _controller.activeFilterCount > 0
                                      ? '${_controller.activeFilterCount} ${'client.catalog.filters_active'.tr}'
                                      : 'client.catalog.more_filters'.tr,
                                  style: AppTypography.bodySmall(context).copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    if (_controller.activeFilterCount > 0)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _controller.resetFilters,
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.error.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: colors.error.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              'client.catalog.reset_filters'.tr,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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

  // ============================================================
  // DRIVERS GRID
  // ============================================================

  Widget _buildDriversGrid(BuildContext context, AppColorScheme colors) {
    return Obx(() {
      if (_controller.isLoadingDrivers.value && _controller.drivers.isEmpty) {
        return _buildDriversShimmer(colors);
      }

      if (_controller.errorMessage.isNotEmpty) {
        return _buildErrorState(context, colors);
      }

      if (_controller.drivers.isEmpty) {
        return _buildEmptyState(context, colors);
      }

      return SliverPadding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final driver = _controller.drivers[index];
              return _DriverCard(
                driver: driver,
                colors: colors,
                controller: _controller,
                onTap: () => _navigateToDriverCatalog(driver),
              );
            },
            childCount: _controller.drivers.length,
          ),
        ),
      );
    });
  }

  Widget _buildDriversShimmer(AppColorScheme colors) {
    return SliverPadding(
      padding: EdgeInsets.all(20.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: colors.border,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: colors.border,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: 120.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: colors.border,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          childCount: 3,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppColorScheme colors) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.search_normal,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 20.h),
              Text(
                'client.catalog.no_drivers_found'.tr,
                style: AppTypography.titleLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                'client.catalog.try_different_filters'.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _controller.resetFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('client.catalog.reset_filters'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, AppColorScheme colors) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.info_circle,
                size: 80.sp,
                color: colors.error.withOpacity(0.7),
              ),
              SizedBox(height: 24.h),
              Text(
                _controller.errorMessage.value,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: _controller.loadNearbyDrivers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text('common.retry'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _navigateToDriverCatalog(DriverProfile driver) {
    Get.to(
      () => DriverCatalogScreen(driver: driver),
      transition: Transition.rightToLeft,
    );
  }

  void _showFilterSheet() {
    Get.bottomSheet(
      const CatalogFilterSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  IconData _getCategoryIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'car':
        return Iconsax.car;
      case 'box':
        return Iconsax.box;
      case 'truck':
      case 'local_shipping':
        return Iconsax.truck_fast;
      case 'shopping':
      case 'shopping_cart':
        return Iconsax.shopping_cart;
      case 'restaurant':
        return Iconsax.shop;
      case 'home':
        return Iconsax.home;
      case 'briefcase':
      case 'work':
        return Iconsax.briefcase;
      default:
        return Iconsax.category;
    }
  }
}

// ============================================================
// CATEGORY CHIP WIDGET
// ============================================================

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final AppColorScheme colors;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 94.w,
          margin: EdgeInsets.only(right: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.withValues(alpha: 0.10) : colors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? colors.primary : colors.border,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary
                      : colors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : colors.primary,
                  size: 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: AppTypography.labelSmall(context).copyWith(
                  color: isSelected ? colors.primary : colors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DRIVER CARD WIDGET
// ============================================================

class _DriverCard extends StatelessWidget {
  final DriverProfile driver;
  final AppColorScheme colors;
  final ServiceCatalogController controller;
  final VoidCallback onTap;

  const _DriverCard({
    required this.driver,
    required this.colors,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final distance = controller.getDistanceToDriver(driver);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Driver avatar with favorite button
                Stack(
                  children: [
                    _buildAvatar(context),
                    // Favorite button
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () => controller.toggleFavorite(driver.id!),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              shape: BoxShape.circle,
                              border: Border.all(color: colors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              controller.isFavorite(driver.id!)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 16.sp,
                              color: controller.isFavorite(driver.id!)
                                  ? colors.error
                                  : colors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                // Driver info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              driver.displayName,
                              style: AppTypography.titleLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (driver.isOnline)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: colors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'common.online'.tr,
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: colors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Iconsax.star,
                            size: 14.sp,
                            color: colors.warning,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${(driver.ratingAverage ?? 0.0).toStringAsFixed(1)} (${driver.ratingCount ?? 0} ${'common.reviews'.tr})',
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      if (distance != null) ...[
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
                              '${distance.toStringAsFixed(1)} km ${'client.catalog.away'.tr}',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // View catalog button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('client.catalog.view_services'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (driver.profilePhotoUrl != null && driver.profilePhotoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CachedNetworkImage(
          imageUrl: driver.profilePhotoUrl!,
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 80.w,
            height: 80.h,
            color: colors.surface,
            child: Icon(Iconsax.user, color: colors.textSecondary, size: 32.sp),
          ),
          errorWidget: (context, url, error) => Container(
            width: 80.w,
            height: 80.h,
            color: colors.primary.withOpacity(0.1),
            child: Icon(Iconsax.user, color: colors.primary, size: 32.sp),
          ),
        ),
      );
    }

    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Iconsax.user, color: colors.primary, size: 32.sp),
    );
  }
}
