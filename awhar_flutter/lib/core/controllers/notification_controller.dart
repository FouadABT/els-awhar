import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/app_notification.dart';

/// Controller for managing app notifications
/// SECURITY: Uses user-specific storage keys to prevent cross-user notification leaks
class NotificationController extends GetxController {
  final _storage = GetStorage();
  static const String _notificationsKeyPrefix = 'app_notifications_user_';
  static const String _currentUserIdKey = 'notification_current_user_id';
  static const int _maxNotifications = 100;

  // Current user ID for user-specific storage
  int? _currentUserId;

  // Reactive state
  final RxList<AppNotification> notifications = <AppNotification>[].obs;
  final RxInt unreadCount = 0.obs;
  final RxBool isLoading = false.obs;

  /// Get the storage key for the current user
  String get _notificationsKey {
    if (_currentUserId == null) {
      return 'app_notifications_anonymous';
    }
    return '$_notificationsKeyPrefix$_currentUserId';
  }

  @override
  void onInit() {
    super.onInit();

    // MIGRATION: Remove old shared notification key (security fix)
    _migrateOldNotifications();

    // Try to restore last known user ID
    _currentUserId = _storage.read<int>(_currentUserIdKey);
    if (_currentUserId != null) {
      _loadNotifications();
    }
  }

  /// Migration: Remove old shared notification data
  /// This is a one-time cleanup for the security fix
  void _migrateOldNotifications() {
    try {
      // Check if old shared key exists
      final oldData = _storage.read<List<dynamic>>('app_notifications');
      if (oldData != null) {
        print(
          '[NotificationController] 🔄 Migrating: Removing old shared notification data (${oldData.length} items)',
        );
        _storage.remove('app_notifications');
        print(
          '[NotificationController] ✅ Old shared notifications removed for security',
        );
      }
    } catch (e) {
      print('[NotificationController] ⚠️ Migration error (non-critical): $e');
    }
  }

  /// Set the current user ID - MUST be called on login
  /// This ensures notifications are stored per-user for security
  void setCurrentUser(int userId) {
    if (_currentUserId == userId) {
      print('[NotificationController] 👤 User already set: $userId');
      return;
    }

    print(
      '[NotificationController] 👤 Switching to user: $userId (was: $_currentUserId)',
    );

    // Clear current notifications (they belong to previous user)
    notifications.clear();
    unreadCount.value = 0;

    // Set new user ID and persist it
    _currentUserId = userId;
    _storage.write(_currentUserIdKey, userId);

    // Load notifications for this user
    _loadNotifications();
  }

  /// Clear notifications on logout - MUST be called on logout
  /// This prevents cross-user notification leaks
  void onUserLogout() {
    print(
      '[NotificationController] 🚪 User logging out, clearing notifications',
    );

    // Clear in-memory notifications
    notifications.clear();
    unreadCount.value = 0;

    // Clear user ID
    _currentUserId = null;
    _storage.remove(_currentUserIdKey);

    // Note: We don't delete the user's stored notifications - they'll be
    // available if they log back in. This is intentional behavior.
  }

  /// Load notifications from local storage (user-specific)
  void _loadNotifications() {
    try {
      if (_currentUserId == null) {
        print('[NotificationController] ⚠️ No user set, skipping load');
        return;
      }

      final stored = _storage.read<List<dynamic>>(_notificationsKey);
      if (stored != null) {
        notifications.value = stored
            .map(
              (json) =>
                  AppNotification.fromJson(Map<String, dynamic>.from(json)),
            )
            .toList();
        _updateUnreadCount();
        print(
          '[NotificationController] ✅ Loaded ${notifications.length} notifications for user $_currentUserId',
        );
      } else {
        print(
          '[NotificationController] ℹ️ No stored notifications for user $_currentUserId',
        );
      }
    } catch (e) {
      print('[NotificationController] ❌ Error loading notifications: $e');
    }
  }

  /// Save notifications to local storage (user-specific)
  void _saveNotifications() {
    try {
      if (_currentUserId == null) {
        print('[NotificationController] ⚠️ No user set, skipping save');
        return;
      }

      final jsonList = notifications.map((n) => n.toJson()).toList();
      _storage.write(_notificationsKey, jsonList);
    } catch (e) {
      print('[NotificationController] ❌ Error saving notifications: $e');
    }
  }

  /// Update unread count
  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.isRead).length;
  }

  /// Add a new notification
  /// SECURITY: Only adds if a user is logged in
  void addNotification(AppNotification notification) {
    // Security check: Don't store notifications if no user is logged in
    if (_currentUserId == null) {
      print(
        '[NotificationController] ⚠️ Ignoring notification - no user logged in',
      );
      return;
    }

    // Add at the beginning (most recent first)
    notifications.insert(0, notification);

    // Trim to max size
    if (notifications.length > _maxNotifications) {
      notifications.removeRange(_maxNotifications, notifications.length);
    }

    _updateUnreadCount();
    _saveNotifications();

    print(
      '[NotificationController] ➕ Added notification for user $_currentUserId: ${notification.title}',
    );
  }

  /// Mark a notification as read
  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      _updateUnreadCount();
      _saveNotifications();
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (!notifications[i].isRead) {
        notifications[i] = notifications[i].copyWith(isRead: true);
      }
    }
    _updateUnreadCount();
    _saveNotifications();
    print('[NotificationController] ✅ All notifications marked as read');
  }

  /// Delete a notification
  void deleteNotification(String notificationId) {
    notifications.removeWhere((n) => n.id == notificationId);
    _updateUnreadCount();
    _saveNotifications();
  }

  /// Clear all notifications
  void clearAll() {
    notifications.clear();
    unreadCount.value = 0;
    _saveNotifications();
    print('[NotificationController] 🗑️ All notifications cleared');
  }

  /// Get notifications filtered by type
  List<AppNotification> getByType(String type) {
    return notifications.where((n) => n.type == type).toList();
  }

  /// Get notifications for a specific request
  List<AppNotification> getByRequestId(String requestId) {
    return notifications.where((n) => n.requestId == requestId).toList();
  }
}
