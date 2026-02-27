import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'auth_controller.dart';
import '../services/analytics_service.dart';

/// Controller for Driver Dashboard
/// Manages real-time earnings, statistics, and active requests
class DriverDashboardController extends GetxController {
  final Client _client = Get.find<Client>();
  final AuthController _authController = Get.find<AuthController>();

  // Loading states
  final RxBool isLoadingEarnings = false.obs;
  final RxBool isLoadingRequests = false.obs;
  final RxBool isLoadingStats = false.obs;

  // Earnings data
  final Rx<DriverEarningsResponse?> earnings = Rx<DriverEarningsResponse?>(null);
  
  // Active requests
  final RxList<ServiceRequest> activeRequests = <ServiceRequest>[].obs;
  final RxList<ServiceRequest> pendingRequests = <ServiceRequest>[].obs;
  
  // Today's statistics
  final RxInt todayTrips = 0.obs;
  final RxDouble todayEarnings = 0.0.obs;
  final RxDouble averageRating = 0.0.obs;
  final RxInt ratingCount = 0.obs;
  final RxInt totalTrips = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  /// Load all dashboard data
  Future<void> loadDashboardData() async {
    await Future.wait([
      loadEarnings(),
      loadActiveRequests(),
      loadStats(),
    ]);
  }

  /// Load driver earnings
  Future<void> loadEarnings() async {
    try {
      isLoadingEarnings.value = true;
      
      final userId = _authController.currentUser.value?.id;
      if (userId == null) {
        print('[DriverDashboard] ❌ User ID not available');
        return;
      }

      print('[DriverDashboard] 📊 Loading earnings for user $userId');
      
      // Get earnings from backend
      final response = await _client.transaction.getDriverEarnings(userId);
      earnings.value = response;

      // Calculate today's earnings
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      
      double todayTotal = 0.0;
      int todayCount = 0;

      // Filter transactions for today
      if (response.transactions != null) {
        for (final txn in response.transactions!) {
          if (txn.createdAt.isAfter(todayStart)) {
            todayTotal += txn.amount;
            todayCount++;
          }
        }
      }

      todayEarnings.value = todayTotal;
      todayTrips.value = todayCount;
      totalTrips.value = response.transactions?.length ?? 0;

      // ANALYTICS: Track earnings viewed
      try {
        if (Get.isRegistered<AnalyticsService>()) {
          final analytics = Get.find<AnalyticsService>();
          await analytics.trackDriverEarningsViewed(
            period: 'today',
            amount: todayTotal,
          );
        }
      } catch (e) {
        print('[DriverDashboard] ⚠️ Analytics tracking failed: $e');
      }

      print('[DriverDashboard] ✅ Earnings loaded: Total=${response.totalEarnings}, Today=$todayTotal MAD');
    } catch (e) {
      print('[DriverDashboard] ❌ Error loading earnings: $e');
    } finally {
      isLoadingEarnings.value = false;
    }
  }

  /// Load active and pending requests
  Future<void> loadActiveRequests() async {
    try {
      isLoadingRequests.value = true;
      
      final userId = _authController.currentUser.value?.id;
      if (userId == null) {
        print('[DriverDashboard] ❌ User ID not available');
        return;
      }

      print('[DriverDashboard] 📋 Loading requests for user $userId');

      // Get active requests (requests assigned to this driver)
      final active = await _client.request.getActiveRequestsForDriver(userId);
      activeRequests.value = active;
      print('[DriverDashboard] 📋 Active requests: ${active.length}');

      // Get ALL pending requests (no filter for testing)
      // This includes both catalog requests AND general concierge requests
      print('[DriverDashboard] 📡 Calling getAllPendingRequests...');
      final pending = await _client.request.getAllPendingRequests();
      pendingRequests.value = pending;
      print('[DriverDashboard] 📋 Pending requests: ${pending.length}');
      for (final req in pending) {
        print('[DriverDashboard]   📌 Request #${req.id}: ${req.clientName}, ${req.serviceType}');
      }

      print('[DriverDashboard] ✅ Loaded ${active.length} active, ${pending.length} pending requests');
    } catch (e, stackTrace) {
      print('[DriverDashboard] ❌ Error loading requests: $e');
      print('[DriverDashboard] 📚 Stack trace: $stackTrace');
    } finally {
      isLoadingRequests.value = false;
    }
  }

  /// Load driver stats (ratings)
  Future<void> loadStats() async {
    try {
      isLoadingStats.value = true;

      final userId = _authController.currentUser.value?.id;
      if (userId == null) {
        print('[DriverDashboard] ❌ User ID not available for stats');
        return;
      }

      print('[DriverDashboard] ⭐ Loading rating stats for user $userId');

      // Prefer driver profile rating data (source of truth for driver ratings)
      final profile = await _client.driver.getDriverProfileByUserId(userId: userId);

      if (profile != null) {
        averageRating.value = profile.ratingAverage;
        ratingCount.value = profile.ratingCount;
        print('[DriverDashboard] ✅ Rating stats loaded from profile: ${profile.ratingAverage} (${profile.ratingCount})');
        return;
      }

      // Fallback to rating stats endpoint
      final stats = await _client.rating.getUserRatingStats(userId);
      final avg = (stats['averageRating'] as num?)?.toDouble() ?? 0.0;
      final total = (stats['totalRatings'] as num?)?.toInt() ?? 0;

      averageRating.value = avg;
      ratingCount.value = total;

      print('[DriverDashboard] ✅ Rating stats loaded (fallback): $avg ($total ratings)');
    } catch (e) {
      // Fallback to cached user data if available
      final user = _authController.currentUser.value;
      averageRating.value = user?.rating ?? user?.averageRating ?? 0.0;
      ratingCount.value = user?.totalRatings ?? 0;
      print('[DriverDashboard] ⚠️ Error loading rating stats, using fallback: $e');
    } finally {
      isLoadingStats.value = false;
    }
  }

  /// Get percentage change from yesterday (mock for now, requires historical data)
  String get earningsChangePercentage {
    // TODO: Implement with historical data
    return '+0%';
  }

  /// Get hours online today (requires session tracking)
  String get hoursOnlineToday {
    // TODO: Implement with session tracking
    return '0.0';
  }

  /// Refresh all dashboard data
  Future<void> refresh() async {
    await loadDashboardData();
  }

  /// Accept a request
  Future<void> acceptRequest(int requestId) async {
    try {
      final userId = _authController.currentUser.value?.id;
      if (userId == null) return;

      print('[DriverDashboard] 📝 Accepting request $requestId');
      
      await _client.request.acceptRequest(requestId, userId);
      
      // ANALYTICS: Track job accepted from dashboard
      try {
        if (Get.isRegistered<AnalyticsService>()) {
          final analytics = Get.find<AnalyticsService>();
          await analytics.trackDriverJobAccepted(
            requestId: requestId,
            responseTimeSeconds: null, // Not tracked from dashboard
          );
        }
      } catch (e) {
        print('[DriverDashboard] ⚠️ Analytics tracking failed: $e');
      }
      
      // Reload requests
      await loadActiveRequests();
      
      Get.snackbar(
        'common.success'.tr,
        'request.accepted'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('[DriverDashboard] ❌ Error accepting request: $e');
      Get.snackbar(
        'common.error'.tr,
        'request.accept_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}
