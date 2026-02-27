import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/notification_service.dart';
import '../services/elasticsearch/elasticsearch.dart';
import '../services/elasticsearch/kibana_agent_client.dart';

/// AI-Powered Notification Planner Service (Production-Grade)
///
/// Uses the awhar-pulse Kibana Agent to autonomously analyze platform
/// behavioral data and generate targeted notification plans. Optimized
/// for large user bases with batch processing, parallel sends, bulk ES
/// logging, cross-cycle deduplication, and quiet hours.
///
/// ## Architecture (Cost-Optimized + Scale-Ready)
///
/// ```
/// Timer.periodic (every 6 hours)
///   │
///   ├─ Quick ES count queries (free) — any targets?
///   │   If all zero → SKIP agent call → $0.00
///   │
///   ├─ Cross-cycle dedup: fetch recently-notified userIds (ES)
///   │
///   ├─ Call awhar-pulse agent (≈$0.005-$0.02)
///   │   Agent returns JSON notification plan
///   │
///   ├─ Filter: quiet hours, dedup, preferences
///   │
///   ├─ Batch FCM sends (parallel batches of 10)
///   │
///   ├─ Batch in-app notifications (PostgreSQL)
///   │
///   └─ Bulk log to awhar-notifications index (single ES call)
/// ```
///
/// Estimated cost: $0.02/day = $7.30/year
class NotificationPlannerService {
  // ═══════════════════════════════════════════════════════════════════
  // Configuration (tunable for scale)
  // ═══════════════════════════════════════════════════════════════════
  static Duration _cycleInterval = const Duration(hours: 6);
  static int _maxNotificationsPerCycle = 50;
  static const String _agentId = 'awhar-pulse';
  static const String _connectorId = 'Google-Gemini-2-5-Flash';

  /// How many FCM sends to fire in parallel per batch
  static const int _fcmParallelBatchSize = 10;

  /// Cross-cycle dedup window — don't re-notify a user within this period
  static const Duration _dedupWindow = Duration(hours: 12);

  /// Quiet hours: skip sending during these hours (user local time, UTC fallback)
  /// 22:00-08:00 = night time, queue for next cycle
  static const int _quietHourStart = 22; // 10 PM
  static const int _quietHourEnd = 8; // 8 AM

  static Timer? _cycleTimer;
  static bool _isRunning = false;
  static DateTime? _lastCycleTime;
  static int _totalCyclesRun = 0;
  static int _totalNotificationsSent = 0;
  static int _totalSkippedQuietHours = 0;
  static int _totalSkippedDedup = 0;

  static final _random = Random();

  /// Initialize the notification planner (runs every N hours)
  static void initialize(Serverpod serverpod) {
    _cycleTimer?.cancel();

    _cycleTimer = Timer.periodic(_cycleInterval, (_) async {
      final session = await serverpod.createSession();
      try {
        await runCycle(session);
      } catch (e) {
        print('[NotificationPlanner] ❌ Cycle error: $e');
      } finally {
        await session.close();
      }
    });

    print('[NotificationPlanner] ✅ Initialized (runs every ${_cycleInterval.inHours} hours)');

    // Run first cycle after 10 minutes (let ES sync settle on startup)
    Future.delayed(const Duration(minutes: 10), () async {
      final session = await serverpod.createSession();
      try {
        print('[NotificationPlanner] 🚀 Running initial cycle...');
        await runCycle(session);
      } catch (e) {
        print('[NotificationPlanner] ❌ Initial cycle error: $e');
      } finally {
        await session.close();
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════
  // Runtime Configuration (admin-tunable)
  // ═══════════════════════════════════════════════════════════════════

  /// Update cycle interval at runtime (admin endpoint)
  static void setCycleInterval(Duration interval) {
    _cycleInterval = interval;
    print('[NotificationPlanner] Cycle interval updated to ${interval.inHours}h');
  }

  /// Update max notifications per cycle at runtime
  static void setMaxPerCycle(int max) {
    _maxNotificationsPerCycle = max;
    print('[NotificationPlanner] Max per cycle updated to $max');
  }

  // ═══════════════════════════════════════════════════════════════════
  // Main Cycle
  // ═══════════════════════════════════════════════════════════════════

  /// Run a single notification planning cycle
  static Future<Map<String, dynamic>> runCycle(
    Session session, {
    bool dryRun = false,
  }) async {
    if (_isRunning) {
      session.log('[NotificationPlanner] ⚠️ Cycle already in progress, skipping',
          level: LogLevel.warning);
      return {'status': 'skipped', 'reason': 'cycle_already_running'};
    }

    _isRunning = true;
    final cycleStart = DateTime.now();
    final cycleId = 'cycle_${cycleStart.millisecondsSinceEpoch}';

    session.log('[NotificationPlanner] 🔄 Starting cycle $cycleId (dryRun=$dryRun)',
        level: LogLevel.info);

    try {
      // ═══════════════════════════════════════════════════════════════
      // STEP 1: Quick pre-check — are there any targets? (free)
      // ═══════════════════════════════════════════════════════════════
      final preCheck = await _quickPreCheck(session);
      if (!preCheck['hasTargets']) {
        session.log('[NotificationPlanner] ✅ No targets found — skipping agent call',
            level: LogLevel.info);
        _lastCycleTime = cycleStart;
        _totalCyclesRun++;
        return {
          'status': 'skipped',
          'reason': 'no_targets',
          'cycle_id': cycleId,
          'pre_check': preCheck,
          'duration_ms': DateTime.now().difference(cycleStart).inMilliseconds,
        };
      }

      // ═══════════════════════════════════════════════════════════════
      // STEP 2: Cross-cycle dedup — get recently-notified userIds
      // ═══════════════════════════════════════════════════════════════
      final recentlyNotifiedUserIds = await _getRecentlyNotifiedUserIds(session);
      session.log(
          '[NotificationPlanner] 🔄 ${recentlyNotifiedUserIds.length} users notified in last ${_dedupWindow.inHours}h',
          level: LogLevel.info);

      // ═══════════════════════════════════════════════════════════════
      // STEP 3: Call the AI agent to generate notification plan
      // ═══════════════════════════════════════════════════════════════
      session.log('[NotificationPlanner] 🤖 Calling awhar-pulse agent...',
          level: LogLevel.info);

      final agentClient = KibanaAgentClient.fromEnvironment();
      final result = await agentClient.converse(
        agentId: _agentId,
        input: _buildAgentPrompt(preCheck),
        connectorId: _connectorId,
      );

      if (!result.success) {
        session.log('[NotificationPlanner] ❌ Agent call failed: ${result.errorMessage}',
            level: LogLevel.error);
        return {
          'status': 'error',
          'reason': 'agent_call_failed',
          'error': result.errorMessage,
          'cycle_id': cycleId,
        };
      }

      // ═══════════════════════════════════════════════════════════════
      // STEP 4: Parse the notification plan from agent response
      // ═══════════════════════════════════════════════════════════════
      final rawPlan = _parseNotificationPlan(result.message, session);
      session.log('[NotificationPlanner] 📋 Agent returned ${rawPlan.length} notification(s)',
          level: LogLevel.info);

      if (rawPlan.isEmpty) {
        _lastCycleTime = cycleStart;
        _totalCyclesRun++;
        return {
          'status': 'completed',
          'notifications_planned': 0,
          'cycle_id': cycleId,
          'agent_conversation_id': result.conversationId,
          'duration_ms': DateTime.now().difference(cycleStart).inMilliseconds,
        };
      }

      // ═══════════════════════════════════════════════════════════════
      // STEP 5: Filter — dedup, quiet hours, cap
      // ═══════════════════════════════════════════════════════════════
      final filtered = _filterNotifications(
        rawPlan,
        recentlyNotifiedUserIds: recentlyNotifiedUserIds,
        session: session,
      );

      session.log(
        '[NotificationPlanner] 🔍 After filters: ${filtered.eligible.length} eligible, '
        '${filtered.skippedDedup} deduped, ${filtered.skippedQuietHours} quiet hours',
        level: LogLevel.info,
      );

      _totalSkippedDedup += filtered.skippedDedup;
      _totalSkippedQuietHours += filtered.skippedQuietHours;

      if (filtered.eligible.isEmpty) {
        _lastCycleTime = cycleStart;
        _totalCyclesRun++;
        return {
          'status': 'completed',
          'notifications_planned': rawPlan.length,
          'notifications_eligible': 0,
          'skipped_dedup': filtered.skippedDedup,
          'skipped_quiet_hours': filtered.skippedQuietHours,
          'cycle_id': cycleId,
          'agent_conversation_id': result.conversationId,
          'duration_ms': DateTime.now().difference(cycleStart).inMilliseconds,
        };
      }

      // ═══════════════════════════════════════════════════════════════
      // STEP 6: Execute — parallel batch FCM + batch in-app + bulk ES
      // ═══════════════════════════════════════════════════════════════
      final execResult = await _executeBatch(
        session,
        notifications: filtered.eligible,
        cycleId: cycleId,
        agentConversationId: result.conversationId,
        dryRun: dryRun,
      );

      _lastCycleTime = cycleStart;
      _totalCyclesRun++;
      _totalNotificationsSent += execResult['sent'] as int;

      final duration = DateTime.now().difference(cycleStart).inMilliseconds;
      session.log(
        '[NotificationPlanner] ✅ Cycle complete: ${execResult['sent']} sent, '
        '${execResult['failed']} failed, ${duration}ms',
        level: LogLevel.info,
      );

      return {
        'status': 'completed',
        'cycle_id': cycleId,
        'notifications_planned': rawPlan.length,
        'notifications_eligible': filtered.eligible.length,
        'notifications_sent': execResult['sent'],
        'notifications_failed': execResult['failed'],
        'skipped_dedup': filtered.skippedDedup,
        'skipped_quiet_hours': filtered.skippedQuietHours,
        'dry_run': dryRun,
        'agent_conversation_id': result.conversationId,
        'duration_ms': duration,
      };
    } finally {
      _isRunning = false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 1: Pre-Check (free ES count queries)
  // ═══════════════════════════════════════════════════════════════════

  /// Quick pre-check: Are there any notification targets?
  /// Returns counts so the agent prompt can be optimized too.
  static Future<Map<String, dynamic>> _quickPreCheck(Session session) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return {'hasTargets': false};

      // Run all 3 count queries in parallel (faster)
      final results = await Future.wait([
        // Check 1: Inactive users (3-30 days)
        es.client.search(ElasticsearchConfig.usersIndex, {
          'query': {
            'bool': {
              'must': [
                {'range': {'lastSeenAt': {'lte': 'now-3d', 'gte': 'now-30d'}}},
                {'term': {'isSuspended': false}},
              ]
            }
          },
          'size': 0,
        }),
        // Check 2: Unrated completed orders (7 days)
        es.client.search(ElasticsearchConfig.requestsIndex, {
          'query': {
            'bool': {
              'must': [
                {'term': {'isCompleted': true}},
                {'range': {'completedAt': {'gte': 'now-7d'}}},
              ]
            }
          },
          'size': 0,
        }),
        // Check 3: Pending requests (driver demand, 6 hours)
        es.client.search(ElasticsearchConfig.requestsIndex, {
          'query': {
            'bool': {
              'must': [
                {'term': {'status': 'pending'}},
                {'range': {'createdAt': {'gte': 'now-6h'}}},
              ]
            }
          },
          'size': 0,
        }),
      ]);

      final inactiveCount = results[0]['hits']?['total']?['value'] ?? 0;
      final unratedCount = results[1]['hits']?['total']?['value'] ?? 0;
      final pendingCount = results[2]['hits']?['total']?['value'] ?? 0;

      session.log(
        '[NotificationPlanner] Pre-check: inactive=$inactiveCount, '
        'unrated=$unratedCount, pending=$pendingCount',
        level: LogLevel.info,
      );

      return {
        'hasTargets': (inactiveCount as int) > 0 ||
            (unratedCount as int) > 0 ||
            (pendingCount as int) > 0,
        'inactive': inactiveCount,
        'unrated': unratedCount,
        'pending': pendingCount,
      };
    } catch (e) {
      session.log('[NotificationPlanner] Pre-check error: $e', level: LogLevel.warning);
      return {'hasTargets': true}; // Conservative: run agent on error
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 2: Cross-Cycle Deduplication
  // ═══════════════════════════════════════════════════════════════════

  /// Fetch userIds that were already notified in the dedup window
  static Future<Set<int>> _getRecentlyNotifiedUserIds(Session session) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return {};

      final result = await es.client.search(
        ElasticsearchConfig.notificationsIndex,
        {
          'query': {
            'bool': {
              'must': [
                {'range': {'createdAt': {'gte': 'now-${_dedupWindow.inHours}h'}}},
                {
                  'terms': {'status': ['sent', 'delivered', 'planned']}
                },
              ]
            }
          },
          'size': 0,
          'aggs': {
            'notified_users': {
              'terms': {'field': 'userId', 'size': 1000}
            }
          },
        },
      );

      final buckets =
          result['aggregations']?['notified_users']?['buckets'] as List<dynamic>? ?? [];
      return buckets.map((b) => (b['key'] as num).toInt()).toSet();
    } catch (e) {
      session.log('[NotificationPlanner] Dedup query error: $e', level: LogLevel.warning);
      return {};
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 3: Smart Agent Prompt
  // ═══════════════════════════════════════════════════════════════════

  /// Build an optimized agent prompt based on pre-check results
  static String _buildAgentPrompt(Map<String, dynamic> preCheck) {
    final parts = <String>[
      'Generate notification plan for this cycle.',
      'ALWAYS check recent_notifications first to avoid duplicates.',
    ];

    final inactive = preCheck['inactive'] ?? 0;
    final unrated = preCheck['unrated'] ?? 0;
    final pending = preCheck['pending'] ?? 0;

    // Only ask agent to analyze categories where we found targets
    if ((inactive as int) > 0) {
      parts.add('Found $inactive inactive users — check inactive_users and churn_risk_users.');
    }
    if ((unrated as int) > 0) {
      parts.add('Found $unrated unrated orders — check pending_ratings.');
    }
    if ((pending as int) > 0) {
      parts.add('Found $pending pending requests — check driver_demand_alerts.');
    }

    // Always check these lightweight tools
    parts.add('Also check new_user_onboarding and milestone_users.');
    parts.add('Return ONLY a JSON array. Max $_maxNotificationsPerCycle notifications.');

    return parts.join(' ');
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 4: Parse Agent Response
  // ═══════════════════════════════════════════════════════════════════

  /// Parse the agent's JSON response into a list of notification objects
  static List<Map<String, dynamic>> _parseNotificationPlan(
    String agentMessage,
    Session session,
  ) {
    try {
      String jsonStr = agentMessage.trim();

      // Strip markdown code fences if present
      if (jsonStr.startsWith('```')) {
        jsonStr = jsonStr.replaceFirst(RegExp(r'^```\w*\n?'), '');
        jsonStr = jsonStr.replaceFirst(RegExp(r'\n?```$'), '');
        jsonStr = jsonStr.trim();
      }

      // Find the JSON array in the response
      final startIdx = jsonStr.indexOf('[');
      final endIdx = jsonStr.lastIndexOf(']');
      if (startIdx == -1 || endIdx == -1 || endIdx <= startIdx) {
        session.log('[NotificationPlanner] ⚠️ No JSON array found in agent response',
            level: LogLevel.warning);
        return [];
      }

      jsonStr = jsonStr.substring(startIdx, endIdx + 1);
      final parsed = jsonDecode(jsonStr) as List<dynamic>;

      return parsed
          .whereType<Map<String, dynamic>>()
          .where((n) => n.containsKey('userId') && n.containsKey('type'))
          .toList();
    } catch (e) {
      session.log('[NotificationPlanner] ❌ Failed to parse notification plan: $e',
          level: LogLevel.error);
      return [];
    }
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 5: Filter (Dedup + Quiet Hours)
  // ═══════════════════════════════════════════════════════════════════

  /// Filter notifications: cross-cycle dedup, quiet hours, and cap
  static _FilterResult _filterNotifications(
    List<Map<String, dynamic>> plan, {
    required Set<int> recentlyNotifiedUserIds,
    required Session session,
  }) {
    final eligible = <Map<String, dynamic>>[];
    int skippedDedup = 0;
    int skippedQuietHours = 0;
    final seenUserIds = <int>{}; // within-cycle dedup

    final nowUtc = DateTime.now().toUtc();

    for (final notification in plan) {
      final userId = notification['userId'] as int?;
      if (userId == null) continue;

      // Within-cycle dedup (1 notification per user per cycle)
      if (seenUserIds.contains(userId)) {
        skippedDedup++;
        continue;
      }

      // Cross-cycle dedup (don't re-notify within dedup window)
      if (recentlyNotifiedUserIds.contains(userId)) {
        skippedDedup++;
        continue;
      }

      // Quiet hours check (use UTC; in production use user timezone)
      if (_isQuietHours(nowUtc)) {
        // High-priority notifications (re_engagement, churn_prevention) bypass quiet hours
        final priority = notification['priority'] as String? ?? 'medium';
        if (priority != 'high') {
          skippedQuietHours++;
          continue;
        }
      }

      seenUserIds.add(userId);
      eligible.add(notification);

      // Cap at max per cycle
      if (eligible.length >= _maxNotificationsPerCycle) break;
    }

    return _FilterResult(
      eligible: eligible,
      skippedDedup: skippedDedup,
      skippedQuietHours: skippedQuietHours,
    );
  }

  /// Check if current time is in quiet hours (22:00-08:00 UTC)
  static bool _isQuietHours(DateTime nowUtc) {
    final hour = nowUtc.hour;
    return hour >= _quietHourStart || hour < _quietHourEnd;
  }

  // ═══════════════════════════════════════════════════════════════════
  // STEP 6: Batch Execution (Parallel FCM + Bulk ES)
  // ═══════════════════════════════════════════════════════════════════

  /// Execute notifications in optimized batches
  static Future<Map<String, int>> _executeBatch(
    Session session, {
    required List<Map<String, dynamic>> notifications,
    required String cycleId,
    required String agentConversationId,
    required bool dryRun,
  }) async {
    int sent = 0;
    int failed = 0;

    // Collect ES documents for bulk logging at the end
    final esDocuments = <Map<String, dynamic>>[];
    final esDocIds = <String>[];

    // Process FCM sends in parallel batches
    for (var i = 0; i < notifications.length; i += _fcmParallelBatchSize) {
      final batchEnd = (i + _fcmParallelBatchSize).clamp(0, notifications.length);
      final batch = notifications.sublist(i, batchEnd);

      // Fire all FCM sends in this batch concurrently
      final futures = batch.map((notification) async {
        final userId = notification['userId'] as int;
        bool fcmSuccess = false;

        try {
          if (!dryRun) {
            fcmSuccess = await NotificationService.sendToUser(
              session,
              userId: userId,
              title: notification['title'] as String? ?? 'Awhar',
              body: notification['body'] as String? ?? '',
              data: {
                'type': notification['type'] as String? ?? 'general',
                'source': 'ai_pulse',
                'cycle_id': cycleId,
              },
            );

            // Create in-app notification
            await _createInAppNotification(session, notification);
          }
        } catch (e) {
          session.log('[NotificationPlanner] ❌ FCM error for user $userId: $e',
              level: LogLevel.error);
        }

        return _SendResult(
          userId: userId,
          notification: notification,
          fcmSuccess: fcmSuccess,
          dryRun: dryRun,
        );
      });

      // Wait for this batch to complete
      final results = await Future.wait(futures);

      // Collect results for bulk ES logging
      for (final r in results) {
        final status = dryRun ? 'planned' : (r.fcmSuccess ? 'sent' : 'failed');
        if (r.fcmSuccess || dryRun) {
          sent++;
        } else {
          failed++;
        }

        // Prepare ES document
        final notificationId =
            'notif_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(99999).toString().padLeft(5, '0')}';
        final now = DateTime.now().toUtc().toIso8601String();

        esDocuments.add({
          'notificationId': notificationId,
          'userId': r.userId,
          'userRole': r.notification['userRole'] ?? 'client',
          'userName': r.notification['userName'] ?? '',
          'type': r.notification['type'] ?? 'general',
          'title': r.notification['title'] ?? '',
          'body': r.notification['body'] ?? '',
          'channel': 'push',
          'priority': r.notification['priority'] ?? 'medium',
          'triggerReason': r.notification['triggerReason'] ?? '',
          'agentCycleId': agentConversationId,
          'status': status,
          'fcmSuccess': r.fcmSuccess,
          'actionTaken': 'none',
          'plannedAt': now,
          'sentAt': status == 'sent' ? now : null,
          'createdAt': now,
        });
        esDocIds.add(notificationId);
      }

      // Small delay between batches to be nice to FCM rate limits
      if (batchEnd < notifications.length) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    // Bulk log ALL notifications to ES in one call
    await _bulkLogToEs(session, esDocuments, esDocIds);

    return {'sent': sent, 'failed': failed};
  }

  // ═══════════════════════════════════════════════════════════════════
  // Helpers
  // ═══════════════════════════════════════════════════════════════════

  /// Bulk log notifications to Elasticsearch (single API call)
  static Future<void> _bulkLogToEs(
    Session session,
    List<Map<String, dynamic>> documents,
    List<String> documentIds,
  ) async {
    if (documents.isEmpty) return;

    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return;

      await es.client.bulkIndex(
        ElasticsearchConfig.notificationsIndex,
        documents,
        documentIds,
      );

      session.log('[NotificationPlanner] 📊 Bulk logged ${documents.length} notifications to ES',
          level: LogLevel.info);
    } catch (e) {
      session.log('[NotificationPlanner] ES bulk logging error: $e', level: LogLevel.warning);

      // Fallback: log individually so we don't lose data
      for (var i = 0; i < documents.length; i++) {
        try {
          final es = ElasticsearchService();
          await es.client.indexDocument(
            ElasticsearchConfig.notificationsIndex,
            documentIds[i],
            documents[i],
          );
        } catch (_) {
          // Best effort
        }
      }
    }
  }

  /// Create an in-app notification (persisted in PostgreSQL)
  static Future<void> _createInAppNotification(
    Session session,
    Map<String, dynamic> notification,
  ) async {
    try {
      final userId = notification['userId'] as int;
      final type = notification['type'] as String? ?? 'general';

      // Map pulse notification types to existing NotificationType enum
      NotificationType notifType;
      switch (type) {
        case 're_engagement':
        case 'churn_prevention':
        case 'milestone':
        case 'onboarding':
          notifType = NotificationType.system;
          break;
        case 'rating_reminder':
        case 'abandoned_funnel':
          notifType = NotificationType.order;
          break;
        case 'driver_demand':
          notifType = NotificationType.delivery;
          break;
        default:
          notifType = NotificationType.system;
      }

      final userNotification = UserNotification(
        userId: userId,
        title: notification['title'] as String? ?? 'Awhar',
        body: notification['body'] as String? ?? '',
        type: notifType,
        dataJson: jsonEncode({
          'source': 'ai_pulse',
          'pulse_type': type,
          'trigger_reason': notification['triggerReason'],
        }),
        isRead: false,
      );

      await UserNotification.db.insertRow(session, userNotification);
    } catch (e) {
      session.log('[NotificationPlanner] Could not create in-app notification: $e',
          level: LogLevel.warning);
    }
  }

  /// Get recent notification history from ES (for admin dashboard)
  static Future<List<Map<String, dynamic>>> getHistory(
    Session session, {
    int limit = 50,
    String? type,
    String? status,
  }) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return [];

      final mustClauses = <Map<String, dynamic>>[];
      if (type != null) mustClauses.add({'term': {'type': type}});
      if (status != null) mustClauses.add({'term': {'status': status}});

      final query = mustClauses.isEmpty
          ? {'match_all': {}}
          : {
              'bool': {'must': mustClauses}
            };

      final result = await es.client.search(
        ElasticsearchConfig.notificationsIndex,
        {
          'query': query,
          'sort': [
            {'createdAt': 'desc'}
          ],
          'size': limit,
        },
      );

      final hits = result['hits']?['hits'] as List<dynamic>? ?? [];
      return hits.map((h) => h['_source'] as Map<String, dynamic>).toList();
    } catch (e) {
      session.log('[NotificationPlanner] History query error: $e', level: LogLevel.warning);
      return [];
    }
  }

  /// Get aggregated stats from ES (for admin dashboard)
  static Future<Map<String, dynamic>> getStats(Session session) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return {};

      final result = await es.client.search(
        ElasticsearchConfig.notificationsIndex,
        {
          'size': 0,
          'aggs': {
            'by_type': {
              'terms': {'field': 'type', 'size': 20}
            },
            'by_status': {
              'terms': {'field': 'status', 'size': 10}
            },
            'by_priority': {
              'terms': {'field': 'priority', 'size': 5}
            },
            'total': {
              'value_count': {'field': 'notificationId'}
            },
            'last_24h': {
              'filter': {'range': {'createdAt': {'gte': 'now-24h'}}},
              'aggs': {
                'count': {'value_count': {'field': 'notificationId'}}
              }
            },
            'last_7d': {
              'filter': {'range': {'createdAt': {'gte': 'now-7d'}}},
              'aggs': {
                'count': {'value_count': {'field': 'notificationId'}}
              }
            },
          },
        },
      );

      return {
        'total': result['aggregations']?['total']?['value'] ?? 0,
        'last_24h': result['aggregations']?['last_24h']?['count']?['value'] ?? 0,
        'last_7d': result['aggregations']?['last_7d']?['count']?['value'] ?? 0,
        'by_type': _bucketsToMap(result['aggregations']?['by_type']?['buckets']),
        'by_status': _bucketsToMap(result['aggregations']?['by_status']?['buckets']),
        'by_priority': _bucketsToMap(result['aggregations']?['by_priority']?['buckets']),
      };
    } catch (e) {
      session.log('[NotificationPlanner] Stats query error: $e', level: LogLevel.warning);
      return {};
    }
  }

  /// Convert ES aggregation buckets to a simple map
  static Map<String, int> _bucketsToMap(List<dynamic>? buckets) {
    if (buckets == null) return {};
    return {for (final b in buckets) b['key'] as String: (b['doc_count'] as num).toInt()};
  }

  /// Get service health status
  static Map<String, dynamic> getStatus() {
    return {
      'initialized': _cycleTimer != null,
      'is_running': _isRunning,
      'cycle_interval_hours': _cycleInterval.inHours,
      'max_per_cycle': _maxNotificationsPerCycle,
      'fcm_batch_size': _fcmParallelBatchSize,
      'dedup_window_hours': _dedupWindow.inHours,
      'quiet_hours': '${_quietHourStart}:00-${_quietHourEnd}:00 UTC',
      'last_cycle_time': _lastCycleTime?.toIso8601String(),
      'total_cycles_run': _totalCyclesRun,
      'total_notifications_sent': _totalNotificationsSent,
      'total_skipped_dedup': _totalSkippedDedup,
      'total_skipped_quiet_hours': _totalSkippedQuietHours,
      'agent_id': _agentId,
    };
  }

  /// Shut down the service
  static void shutdown() {
    _cycleTimer?.cancel();
    _cycleTimer = null;
    print('[NotificationPlanner] Service stopped');
  }
}

// ═══════════════════════════════════════════════════════════════════
// Internal Data Classes
// ═══════════════════════════════════════════════════════════════════

class _FilterResult {
  final List<Map<String, dynamic>> eligible;
  final int skippedDedup;
  final int skippedQuietHours;

  _FilterResult({
    required this.eligible,
    required this.skippedDedup,
    required this.skippedQuietHours,
  });
}

class _SendResult {
  final int userId;
  final Map<String, dynamic> notification;
  final bool fcmSuccess;
  final bool dryRun;

  _SendResult({
    required this.userId,
    required this.notification,
    required this.fcmSuccess,
    required this.dryRun,
  });
}
