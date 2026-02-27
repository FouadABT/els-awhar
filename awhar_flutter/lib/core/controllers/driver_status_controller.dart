import 'dart:async';
import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/auth_controller.dart';
import 'package:awhar_flutter/core/services/driver_status_service.dart';
import 'package:awhar_flutter/core/services/driver_location_service.dart';
import 'package:awhar_flutter/core/services/presence_service.dart';
import 'package:awhar_flutter/core/services/analytics_service.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Professional Driver Status Controller
/// 
/// Architecture:
/// - Driver toggles online → stays online for 30 minutes
/// - Heartbeat every 2 minutes extends the session
/// - After 25 min of background inactivity → show notification
/// - If no response in 5 min → auto-offline
/// - On app launch: restore status from database
class DriverStatusController extends GetxController {
  final DriverStatusService _statusService = Get.find<DriverStatusService>();
  final DriverLocationService _locationService =
      Get.find<DriverLocationService>();
  final PresenceService _presenceService = Get.find<PresenceService>();
  final AuthController _authController = Get.find<AuthController>();

  // Reactive state
  final RxBool isOnline = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt onlineDriversCount = 0.obs;
  
  // Session tracking
  final Rx<DateTime?> sessionStartTime = Rx<DateTime?>(null);
  final Rx<DateTime?> lastActivityTime = Rx<DateTime?>(null);

  // Timers
  Timer? _heartbeatTimer;
  Timer? _inactivityTimer;
  static const Duration _heartbeatInterval = Duration(minutes: 2);
  static const Duration _inactivityWarning = Duration(minutes: 25);
  static const Duration _autoOfflineDelay = Duration(minutes: 5);

  // Notifications
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initNotifications();
    _loadOnlineDriversCount();
    
    // Wait for auth to be ready, then load saved status
    if (_authController.currentUser.value != null) {
      _loadSavedStatus();
    } else {
      // Listen for auth to become ready
      ever(_authController.currentUser, (user) {
        if (user != null && user.roles.contains(UserRole.driver)) {
          _loadSavedStatus();
        }
      });
    }
  }

  @override
  void onClose() {
    _stopHeartbeat();
    _stopInactivityTimer();
    _locationService.stopTracking();
    super.onClose();
  }

  /// Initialize local notifications (fails gracefully if not configured)
  Future<void> _initNotifications() async {
    try {
      // Use @drawable/ic_notification for status bar icon (must be white/monochrome)
      const androidSettings = AndroidInitializationSettings('@drawable/ic_notification');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );
      
      await _notifications.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationResponse,
      );
      print('[DriverStatusController] ✅ Local notifications initialized');
    } catch (e) {
      // Notifications are optional - don't block driver functionality
      print('[DriverStatusController] ⚠️ Local notifications not available: $e');
    }
  }

  /// Handle notification tap
  void _onNotificationResponse(NotificationResponse response) {
    if (response.actionId == 'stay_online') {
      // User wants to stay online - extend session
      _extendSession();
    } else if (response.actionId == 'go_offline') {
      // User wants to go offline
      _goOffline();
    }
  }

  /// Load saved online status from database
  Future<void> _loadSavedStatus() async {
    print('[DriverStatusController] 🔄 _loadSavedStatus() called');
    
    try {
      final user = _authController.currentUser.value;
      print('[DriverStatusController] Current user: ${user?.id}, roles: ${user?.roles}');
      
      if (user == null || !user.roles.contains(UserRole.driver)) {
        print('[DriverStatusController] ❌ Not a driver or user null, skipping status load');
        return;
      }

      print('[DriverStatusController] 🔍 Fetching status from backend for userId=${user.id}');
      
      // Check backend for actual status
      final status = await _statusService.getDriverStatus(user.id!);
      isOnline.value = status;

      print('[DriverStatusController] 📱 App launched - Database says isOnline=$status');

      // Sync presence with database status
      if (isOnline.value) {
        print('[DriverStatusController] ✅ Restoring ONLINE status on app launch');
        sessionStartTime.value = DateTime.now();
        lastActivityTime.value = DateTime.now();
        
        print('[DriverStatusController] Setting Firebase presence...');
        await _presenceService.setOnlineForCurrentUser(true);
        
        print('[DriverStatusController] Starting heartbeat...');
        _startHeartbeat();
        _startInactivityTimer();
        
        print('[DriverStatusController] Starting location tracking...');
        await _locationService.startTracking();
        
        print('[DriverStatusController] ✅ Status restoration complete');
      } else {
        print('[DriverStatusController] 📍 Driver is OFFLINE per database');
        await _presenceService.setOnlineForCurrentUser(false);
      }
    } catch (e, stackTrace) {
      print('[DriverStatusController] ❌ Error loading status: $e');
      print('[DriverStatusController] Stack trace: $stackTrace');
    }
  }

  /// Toggle online/offline status
  Future<void> toggleStatus() async {
    final user = _authController.currentUser.value;
    if (user == null || !user.roles.contains(UserRole.driver)) {
      errorMessage.value = 'Only drivers can toggle online status';
      return;
    }

    print('[DriverStatusController] toggleStatus() called, current isOnline=${isOnline.value}');
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final newStatus = !isOnline.value;
      print('[DriverStatusController] Calling setDriverStatus with newStatus=$newStatus');
      final updatedUser = await _statusService.setDriverStatus(user.id!, newStatus);
      print('[DriverStatusController] setDriverStatus returned: ${updatedUser != null ? "success" : "null"}');

      if (updatedUser != null) {
        isOnline.value = newStatus;
        _authController.currentUser.value = updatedUser;

        // ANALYTICS: Track driver online/offline status change
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            final driverId = _authController.currentUser.value?.id ?? 0;
            if (newStatus) {
              await analytics.trackDriverWentOnline(driverId: driverId);
            } else {
              // Calculate session duration
              final sessionDuration = sessionStartTime.value != null
                  ? DateTime.now().difference(sessionStartTime.value!).inMinutes
                  : null;
              await analytics.trackDriverWentOffline(
                driverId: driverId,
                onlineDurationMinutes: sessionDuration,
              );
            }
          }
        } catch (e) {
          print('[DriverStatusController] ⚠️ Analytics tracking failed: $e');
        }

        if (newStatus) {
          // Going ONLINE
          sessionStartTime.value = DateTime.now();
          lastActivityTime.value = DateTime.now();
          
          print('[DriverStatusController] Starting heartbeat...');
          _startHeartbeat();
          _startInactivityTimer();
          print('[DriverStatusController] Starting location tracking...');
          await _locationService.startTracking();
          print('[DriverStatusController] Setting presence online...');
          await _presenceService.setOnlineForCurrentUser(true);
          print('[DriverStatusController] ✅ All online setup complete');
        } else {
          // Going OFFLINE
          sessionStartTime.value = null;
          lastActivityTime.value = null;
          
          print('[DriverStatusController] Stopping heartbeat...');
          _stopHeartbeat();
          _stopInactivityTimer();
          print('[DriverStatusController] Stopping location tracking...');
          _locationService.stopTracking();
          print('[DriverStatusController] Setting presence offline...');
          await _presenceService.setOnlineForCurrentUser(false);
          print('[DriverStatusController] ✅ All offline cleanup complete');
        }

        // Show success message
        Get.snackbar(
          newStatus ? 'You\'re Online' : 'You\'re Offline',
          newStatus
              ? 'You can now receive service requests'
              : 'You won\'t receive new requests',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: newStatus
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.surface,
          colorText: newStatus
              ? Get.theme.colorScheme.onPrimary
              : Get.theme.colorScheme.onSurface,
          duration: const Duration(seconds: 3),
        );
      } else {
        errorMessage.value = 'Failed to update status';
      }
    } catch (e) {
      print('[DriverStatusController] ERROR in toggleStatus: $e');
      errorMessage.value = 'Error: $e';
    } finally {
      print('[DriverStatusController] finally block - setting isLoading=false');
      isLoading.value = false;
    }
  }

  /// Record activity (called when driver interacts with app)
  void recordActivity() {
    if (isOnline.value) {
      lastActivityTime.value = DateTime.now();
      _resetInactivityTimer();
    }
  }

  /// Extend session (from notification tap)
  void _extendSession() {
    if (!isOnline.value) return;
    
    lastActivityTime.value = DateTime.now();
    _resetInactivityTimer();
    
    Get.snackbar(
      'Session Extended',
      'You\'ll remain online for another 30 minutes',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  /// Go offline (from notification tap or timeout)
  Future<void> _goOffline() async {
    if (!isOnline.value) return;
    await toggleStatus();
  }

  /// Set online status explicitly
  Future<void> setOnline(bool online) async {
    if (isOnline.value == online) return;
    await toggleStatus();
  }

  /// Start heartbeat to update lastSeenAt
  void _startHeartbeat() {
    _stopHeartbeat();

    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) async {
      final user = _authController.currentUser.value;
      if (user == null || !isOnline.value) {
        _stopHeartbeat();
        return;
      }

      try {
        await _statusService.updateLastSeen(user.id!);
        await _presenceService.sendHeartbeat();
        print('[DriverStatusController] 💓 Heartbeat sent');
      } catch (e) {
        print('[DriverStatusController] Heartbeat error: $e');
      }
    });

    print('[DriverStatusController] Heartbeat started');
  }

  /// Stop heartbeat timer
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Start inactivity timer
  void _startInactivityTimer() {
    _stopInactivityTimer();
    
    _inactivityTimer = Timer(_inactivityWarning, () {
      _showInactivityNotification();
    });
  }

  /// Reset inactivity timer
  void _resetInactivityTimer() {
    _startInactivityTimer();
  }

  /// Stop inactivity timer
  void _stopInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  /// Show notification asking if driver is still online
  Future<void> _showInactivityNotification() async {
    if (!isOnline.value) return;

    const androidDetails = AndroidNotificationDetails(
      'driver_status',
      'Driver Status',
      channelDescription: 'Notifications about your online status',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@drawable/ic_notification',
      actions: [
        AndroidNotificationAction('stay_online', 'Stay Online', showsUserInterface: true),
        AndroidNotificationAction('go_offline', 'Go Offline', showsUserInterface: true),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'driver_status',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      1001,
      'Are you still online?',
      'Tap to stay online or you\'ll be marked offline in 5 minutes',
      details,
    );

    // Schedule auto-offline
    Timer(_autoOfflineDelay, () async {
      // Check if still online and no recent activity
      if (isOnline.value && lastActivityTime.value != null) {
        final timeSinceActivity = DateTime.now().difference(lastActivityTime.value!);
        if (timeSinceActivity >= _inactivityWarning + _autoOfflineDelay) {
          print('[DriverStatusController] ⏰ Auto-offline due to inactivity');
          await _goOffline();
          
          await _notifications.show(
            1002,
            'You\'re now offline',
            'You were marked offline due to inactivity',
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'driver_status',
                'Driver Status',
                importance: Importance.defaultImportance,
                icon: '@drawable/ic_notification',
              ),
            ),
          );
        }
      }
    });
  }

  /// Load count of online drivers (for stats)
  Future<void> _loadOnlineDriversCount() async {
    try {
      final count = await _statusService.getOnlineDriversCount();
      onlineDriversCount.value = count;
    } catch (e) {
      print('[DriverStatusController] Error loading online drivers count: $e');
    }
  }

  /// Refresh online drivers count
  Future<void> refreshOnlineDriversCount() async {
    await _loadOnlineDriversCount();
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}
