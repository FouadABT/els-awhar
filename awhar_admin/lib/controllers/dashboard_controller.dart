import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';

/// Dashboard controller - fetches real statistics from the server
class DashboardController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Dashboard stats
  final Rx<DashboardStats?> stats = Rx<DashboardStats?>(null);
  
  // Recent activities
  final RxList<RecentActivity> recentActivities = <RecentActivity>[].obs;

  // Reactive stats for Obx
  final RxInt totalUsersRx = 0.obs;
  final RxInt totalDriversRx = 0.obs;
  final RxInt onlineDriversRx = 0.obs;
  final RxInt totalStoresRx = 0.obs;
  final RxInt activeStoresRx = 0.obs;
  final RxInt pendingVerificationsRx = 0.obs;
  final RxDouble totalRevenueRx = 0.0.obs;
  final RxDouble todayRevenueRx = 0.0.obs;
  final RxInt newUsersTodayRx = 0.obs;

  // Individual stats for easy access (non-reactive getters)
  int get totalUsers => stats.value?.totalUsers ?? 0;
  int get totalDrivers => stats.value?.totalDrivers ?? 0;
  int get onlineDrivers => stats.value?.onlineDrivers ?? 0;
  int get totalClients => stats.value?.totalClients ?? 0;
  int get totalStores => stats.value?.totalStores ?? 0;
  int get activeStores => stats.value?.activeStores ?? 0;
  int get totalRequests => stats.value?.totalRequests ?? 0;
  int get pendingRequests => stats.value?.pendingRequests ?? 0;
  int get completedRequests => stats.value?.completedRequests ?? 0;
  int get totalOrders => stats.value?.totalOrders ?? 0;
  int get pendingOrders => stats.value?.pendingOrders ?? 0;
  int get pendingReports => stats.value?.pendingReports ?? 0;
  double get totalRevenue => stats.value?.totalRevenue ?? 0;
  double get totalCommission => stats.value?.totalCommission ?? 0;
  DateTime? get lastUpdated => stats.value?.updatedAt;

  @override
  void onInit() {
    super.onInit();
    debugPrint('[DashboardController] ⚡ Initializing dashboard controller...');
    loadStats();
    loadRecentActivities();
    debugPrint('[DashboardController] ⚡ Controller initialization complete');
  }

  /// Load dashboard statistics from the server
  Future<void> loadStats() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      final result = await ApiService.instance.client.admin.getDashboardStats();
      stats.value = result;
      
      // Update reactive values
      totalUsersRx.value = result.totalUsers;
      totalDriversRx.value = result.totalDrivers;
      onlineDriversRx.value = result.onlineDrivers;
      totalStoresRx.value = result.totalStores;
      activeStoresRx.value = result.activeStores;
      pendingVerificationsRx.value = result.pendingReports; // Using pendingReports as proxy
      totalRevenueRx.value = result.totalRevenue;
      todayRevenueRx.value = result.totalCommission; // Using commission as proxy for today revenue
      newUsersTodayRx.value = result.totalClients > 0 ? 5 : 0; // Mock value for now
      
      debugPrint('[DashboardController] Stats fetched successfully');
    } catch (e) {
      debugPrint('[DashboardController] Error fetching stats: $e');
      errorMessage.value = 'Failed to load dashboard data';
      // Keep showing old data if available
    } finally {
      isLoading.value = false;
    }
  }

  /// Load recent platform activities
  Future<void> loadRecentActivities() async {
    try {
      debugPrint('[DashboardController] Starting to load recent activities...');
      
      if (!ApiService.instance.isInitialized) {
        debugPrint('[DashboardController] ❌ API not initialized');
        throw Exception('API not initialized');
      }

      debugPrint('[DashboardController] ✅ API initialized, calling getRecentActivities...');
      final activities = await ApiService.instance.client.admin.getRecentActivities(limit: 10);
      
      debugPrint('[DashboardController] ✅ Received ${activities.length} activities from server');
      recentActivities.value = activities;
      
      if (activities.isEmpty) {
        debugPrint('[DashboardController] ⚠️ No activities returned from server');
      } else {
        debugPrint('[DashboardController] Activities:');
        for (var i = 0; i < activities.length && i < 3; i++) {
          debugPrint('  - ${activities[i].title}: ${activities[i].description}');
        }
      }
    } catch (e, stackTrace) {
      debugPrint('[DashboardController] ❌ Error fetching activities: $e');
      debugPrint('[DashboardController] Stack trace: $stackTrace');
      // Keep showing old data if available
    }
  }

  /// Refresh stats - alias for loadStats
  Future<void> refresh() async {
    await loadStats();
    await loadRecentActivities();
  }
}
