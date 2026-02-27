import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';

/// Notification endpoint
/// Handles in-app notifications and FCM push notifications
class NotificationEndpoint extends Endpoint {
  /// Get user notifications
  Future<List<UserNotification>> getUserNotifications(
    Session session, {
    required int userId,
    bool? unreadOnly,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      if (unreadOnly == true) {
        return await UserNotification.db.find(
          session,
          where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
          orderBy: (t) => t.id,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await UserNotification.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.id,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting notifications: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Mark notification as read
  Future<bool> markAsRead(Session session, int notificationId) async {
    try {
      final notification = await UserNotification.db.findById(
        session,
        notificationId,
      );
      if (notification == null) return false;

      notification.isRead = true;
      notification.readAt = DateTime.now();
      await UserNotification.db.updateRow(session, notification);

      return true;
    } catch (e) {
      session.log(
        'Error marking notification as read: $e',
        level: LogLevel.error,
      );
      return false;
    }
  }

  /// Mark all notifications as read for a user
  Future<bool> markAllAsRead(Session session, int userId) async {
    try {
      final unreadNotifications = await UserNotification.db.find(
        session,
        where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
      );

      final now = DateTime.now();
      for (final notification in unreadNotifications) {
        notification.isRead = true;
        notification.readAt = now;
      }

      await UserNotification.db.update(session, unreadNotifications);

      return true;
    } catch (e) {
      session.log('Error marking all as read: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get unread count
  Future<int> getUnreadCount(Session session, int userId) async {
    try {
      final unread = await UserNotification.db.find(
        session,
        where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
      );
      return unread.length;
    } catch (e) {
      session.log('Error getting unread count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Create notification (internal helper) - Also sends FCM push
  Future<UserNotification?> createNotification(
    Session session, {
    required int userId,
    required String title,
    required String body,
    required NotificationType type,
    int? relatedEntityId,
    String? relatedEntityType,
    Map<String, dynamic>? data,
  }) async {
    session.log(
      '[NotificationEndpoint] 📝 Creating notification for user $userId, type=${type.name}',
    );
    try {
      // Create in-app notification
      final notification = UserNotification(
        userId: userId,
        title: title,
        body: body,
        type: type,
        relatedEntityId: relatedEntityId,
        relatedEntityType: relatedEntityType,
        dataJson: data != null ? jsonEncode(data) : null,
        isRead: false,
      );

      final created = await UserNotification.db.insertRow(
        session,
        notification,
      );
      session.log(
        '[NotificationEndpoint] ✅ In-app notification created id=${created.id}',
      );

      // Send FCM push notification
      session.log(
        '[NotificationEndpoint] 📤 Sending FCM push to user $userId...',
      );
      try {
        final success = await NotificationService.sendToUser(
          session,
          userId: userId,
          title: title,
          body: body,
          data: {
            'notificationId': created.id.toString(),
            'type': type.name,
            if (relatedEntityId != null)
              'relatedEntityId': relatedEntityId.toString(),
            if (relatedEntityType != null)
              'relatedEntityType': relatedEntityType,
            if (data != null) ...data.map((k, v) => MapEntry(k, v.toString())),
          },
        );
        if (success) {
          session.log(
            '[NotificationEndpoint] ✅ FCM push sent successfully to user $userId',
          );
        } else {
          session.log(
            '[NotificationEndpoint] ⚠️ FCM push returned false for user $userId',
            level: LogLevel.warning,
          );
        }
      } catch (e, stack) {
        session.log(
          '[NotificationEndpoint] ❌ FCM push failed: $e\n$stack',
          level: LogLevel.error,
        );
      }

      return created;
    } catch (e, stack) {
      session.log(
        '[NotificationEndpoint] ❌ Error creating notification: $e\n$stack',
        level: LogLevel.error,
      );
      return null;
    }
  }
}
