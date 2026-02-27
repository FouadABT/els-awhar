import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/notification_planner_service.dart';
import '../services/notification_service.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Notification Planner Endpoint
///
/// Admin endpoint for managing the AI notification planner.
/// Allows manual cycle triggering, dry runs, status checks,
/// notification history, analytics stats, and runtime config.
/// Also provides admin custom notification sending.
class NotificationPlannerEndpoint extends Endpoint {
  /// Get current notification planner status
  ///
  /// Returns cycle count, last run, totals, dedup/quiet hour stats, and config.
  Future<String> getStatus(Session session) async {
    final status = NotificationPlannerService.getStatus();
    return jsonEncode(status);
  }

  /// Manually trigger a notification planning cycle
  ///
  /// [dryRun] if true, generates the plan but doesn't send FCM notifications.
  /// In-app notifications and ES logs are still created for inspection.
  Future<String> runCycle(Session session, {bool dryRun = false}) async {
    session.log('[NotificationPlannerEndpoint] Manual cycle triggered (dryRun=$dryRun)',
        level: LogLevel.info);
    final result = await NotificationPlannerService.runCycle(session, dryRun: dryRun);
    return jsonEncode(result);
  }

  /// Dry run — generates notification plan without sending FCM
  ///
  /// Shows what the AI agent would recommend. Logs to ES with status=planned.
  Future<String> dryRun(Session session) async {
    session.log('[NotificationPlannerEndpoint] Dry run triggered', level: LogLevel.info);
    final result = await NotificationPlannerService.runCycle(session, dryRun: true);
    return jsonEncode(result);
  }

  /// Get notification history from Elasticsearch
  ///
  /// [limit] max results (default 50)
  /// [type] optional filter by notification type (re_engagement, rating_reminder, etc.)
  /// [status] optional filter by status (planned, sent, delivered, opened, clicked, failed)
  Future<String> getHistory(
    Session session, {
    int limit = 50,
    String? type,
    String? status,
  }) async {
    final history = await NotificationPlannerService.getHistory(
      session,
      limit: limit,
      type: type,
      status: status,
    );
    return jsonEncode(history);
  }

  /// Get aggregated notification stats from Elasticsearch
  ///
  /// Returns breakdowns by type, status, priority + totals for 24h/7d.
  Future<String> getStats(Session session) async {
    final stats = await NotificationPlannerService.getStats(session);
    return jsonEncode(stats);
  }

  /// Update runtime configuration
  ///
  /// [maxPerCycle] max notifications per cycle (default 50)
  /// [cycleIntervalHours] hours between cycles (default 6)
  Future<String> updateConfig(
    Session session, {
    int? maxPerCycle,
    int? cycleIntervalHours,
  }) async {
    if (maxPerCycle != null && maxPerCycle > 0) {
      NotificationPlannerService.setMaxPerCycle(maxPerCycle);
    }
    if (cycleIntervalHours != null && cycleIntervalHours > 0) {
      NotificationPlannerService.setCycleInterval(Duration(hours: cycleIntervalHours));
    }

    session.log(
      '[NotificationPlannerEndpoint] Config updated: maxPerCycle=$maxPerCycle, interval=${cycleIntervalHours}h',
      level: LogLevel.info,
    );

    final status = NotificationPlannerService.getStatus();
    return jsonEncode({
      'status': 'updated',
      'config': status,
    });
  }

  /// Send custom notification from admin to specific users
  ///
  /// [userIds] list of target user IDs (comma-separated string for Serverpod compat)
  /// [title] notification title
  /// [body] notification body text
  /// [priority] optional: high, medium, low (default: medium)
  /// [type] optional: custom, promotion, announcement, system (default: custom)
  Future<String> sendCustomNotification(
    Session session, {
    required String userIds,
    required String title,
    required String body,
    String? priority,
    String? type,
  }) async {
    final stopwatch = Stopwatch()..start();
    session.log(
      '[NotificationPlannerEndpoint] Admin custom notification: "$title" to $userIds',
      level: LogLevel.info,
    );

    try {
      // Parse user IDs from comma-separated string
      final ids = userIds
          .split(',')
          .map((s) => int.tryParse(s.trim()))
          .where((id) => id != null)
          .cast<int>()
          .toList();

      if (ids.isEmpty) {
        return jsonEncode({
          'success': false,
          'error': 'No valid user IDs provided',
        });
      }

      final notifType = type ?? 'custom';
      final notifPriority = priority ?? 'medium';

      // Send FCM in parallel batches of 10
      final results = <Map<String, dynamic>>[];
      int successCount = 0;
      int failCount = 0;

      for (int i = 0; i < ids.length; i += 10) {
        final batch = ids.skip(i).take(10).toList();
        final futures = batch.map((userId) async {
          try {
            // Create in-app notification
            final notification = UserNotification(
              userId: userId,
              title: title,
              body: body,
              type: NotificationType.system,
              isRead: false,
            );
            await UserNotification.db.insertRow(session, notification);

            // Send FCM push
            final fcmOk = await NotificationService.sendToUser(
              session,
              userId: userId,
              title: title,
              body: body,
              data: {
                'type': notifType,
                'priority': notifPriority,
                'source': 'admin_custom',
              },
            );
            return {'userId': userId, 'success': fcmOk};
          } catch (e) {
            return {'userId': userId, 'success': false, 'error': e.toString()};
          }
        });

        final batchResults = await Future.wait(futures);
        for (final r in batchResults) {
          results.add(r);
          if (r['success'] == true) {
            successCount++;
          } else {
            failCount++;
          }
        }

        // Rate limit between batches
        if (i + 10 < ids.length) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }

      // Log to Elasticsearch
      try {
        final esClient = ElasticsearchService.instance.client;
        final esDocs = <Map<String, dynamic>>[];
        final esDocIds = <String>[];
        final now = DateTime.now().toUtc().toIso8601String();
        final cycleId = 'admin_${DateTime.now().millisecondsSinceEpoch}';
        
        for (final userId in ids) {
          final wasSuccess = results.firstWhere(
            (r) => r['userId'] == userId,
            orElse: () => {'success': false},
          )['success'] == true;
          
          esDocs.add({
            'user_id': userId,
            'title': title,
            'body': body,
            'type': notifType,
            'priority': notifPriority,
            'status': wasSuccess ? 'sent' : 'failed',
            'source': 'admin_custom',
            'created_at': now,
            'cycle_id': cycleId,
          });
          esDocIds.add('${cycleId}_$userId');
        }
        await esClient.bulkIndex(ElasticsearchConfig.notificationsIndex, esDocs, esDocIds);
      } catch (e) {
        session.log('[NotificationPlannerEndpoint] ES logging failed: $e',
            level: LogLevel.warning);
      }

      stopwatch.stop();

      return jsonEncode({
        'success': true,
        'total': ids.length,
        'sent': successCount,
        'failed': failCount,
        'duration_ms': stopwatch.elapsedMilliseconds,
        'results': results,
      });
    } catch (e) {
      stopwatch.stop();
      session.log('[NotificationPlannerEndpoint] Custom notification error: $e',
          level: LogLevel.error);
      return jsonEncode({
        'success': false,
        'error': e.toString(),
      });
    }
  }

  /// Send broadcast notification to all users or filtered group
  ///
  /// [title] notification title
  /// [body] notification body text
  /// [targetGroup] optional: all, clients, drivers (default: all)
  /// [limit] max users to notify (default: 100, safety cap)
  Future<String> sendBroadcast(
    Session session, {
    required String title,
    required String body,
    String? targetGroup,
    int? limit,
  }) async {
    final stopwatch = Stopwatch()..start();
    final group = targetGroup ?? 'all';
    final maxUsers = limit ?? 100;

    session.log(
      '[NotificationPlannerEndpoint] Broadcast: "$title" to $group (limit=$maxUsers)',
      level: LogLevel.info,
    );

    try {
      // Fetch users from DB based on target group
      // Note: roles is a List<UserRole>, so we fetch all and filter in Dart
      final allUsers = await User.db.find(session, limit: maxUsers * 2);
      List<User> users;
      if (group == 'drivers') {
        users = allUsers
            .where((u) => u.roles.any((r) => r.name == 'driver'))
            .take(maxUsers)
            .toList();
      } else if (group == 'clients') {
        users = allUsers
            .where((u) => u.roles.any((r) => r.name == 'client'))
            .take(maxUsers)
            .toList();
      } else {
        users = allUsers.take(maxUsers).toList();
      }

      if (users.isEmpty) {
        return jsonEncode({
          'success': true,
          'total': 0,
          'sent': 0,
          'message': 'No users found in group: $group',
        });
      }

      // Reuse sendCustomNotification logic via user IDs
      final userIdStr = users.map((u) => u.id.toString()).join(',');
      final result = await sendCustomNotification(
        session,
        userIds: userIdStr,
        title: title,
        body: body,
        priority: 'medium',
        type: 'broadcast',
      );

      stopwatch.stop();
      return result;
    } catch (e) {
      stopwatch.stop();
      return jsonEncode({
        'success': false,
        'error': e.toString(),
      });
    }
  }
}
