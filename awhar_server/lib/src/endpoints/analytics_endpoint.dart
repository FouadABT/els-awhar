import 'dart:convert';
import 'dart:math';
import 'package:serverpod/serverpod.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Analytics Endpoint for Awhar
/// 
/// Provides server-side analytics logging to Elasticsearch.
/// Used for tracking business events that happen on the backend
/// and optionally syncing events from the mobile app.
class AnalyticsEndpoint extends Endpoint {
  static final _random = Random();
  
  /// Generate a unique event ID
  static String _generateEventId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = _random.nextInt(999999).toString().padLeft(6, '0');
    return 'evt_${timestamp}_$randomPart';
  }
  
  /// Log an analytics event from the mobile app
  /// 
  /// This allows the app to log events directly to Elasticsearch
  /// for unified analytics across PostHog, Firebase, and ES.
  /// 
  /// [propertiesJson] should be a JSON-encoded string of the event properties.
  Future<bool> logEvent(
    Session session, {
    required String eventName,
    String? eventType,
    String? propertiesJson,
    String? screenName,
    String? platform,
    String? appVersion,
    int? userId,
    String? sessionId,
  }) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) {
        session.log('Elasticsearch not initialized, skipping analytics log');
        return false;
      }

      // Parse properties from JSON string
      Map<String, dynamic> properties = {};
      if (propertiesJson != null && propertiesJson.isNotEmpty) {
        try {
          properties = jsonDecode(propertiesJson) as Map<String, dynamic>;
        } catch (e) {
          session.log('Error parsing properties JSON: $e', level: LogLevel.warning);
        }
      }
      
      final eventId = _generateEventId();
      final event = <String, dynamic>{
        'eventId': eventId,
        'eventName': eventName,
        'eventType': eventType ?? _inferEventType(eventName),
        'userId': userId,
        'sessionId': sessionId,
        'properties': properties,
        'screenName': screenName,
        'platform': platform,
        'appVersion': appVersion,
        'source': 'app',
        'timestamp': DateTime.now().toUtc().toIso8601String(),
        'serverTimestamp': DateTime.now().toUtc().toIso8601String(),
      };

      await es.client.indexDocument(
        ElasticsearchConfig.analyticsIndex,
        eventId,
        event,
      );

      return true;
    } catch (e) {
      session.log('Error logging analytics event: $e', level: LogLevel.warning);
      return false;
    }
  }

  /// Log multiple events in batch
  /// 
  /// [eventsJson] should be a JSON-encoded array of event objects.
  Future<int> logEvents(
    Session session, {
    required String eventsJson,
    int? userId,
  }) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) {
        return 0;
      }
      
      final serverTimestamp = DateTime.now().toUtc().toIso8601String();
      
      // Parse events from JSON string
      List<dynamic> events = [];
      try {
        events = jsonDecode(eventsJson) as List<dynamic>;
      } catch (e) {
        session.log('Error parsing events JSON: $e', level: LogLevel.warning);
        return 0;
      }
      
      int successCount = 0;
      
      for (final event in events) {
        try {
          final eventId = _generateEventId();
          final enrichedEvent = <String, dynamic>{
            ...(event as Map<String, dynamic>),
            'eventId': eventId,
            'userId': userId,
            'source': 'app_batch',
            'serverTimestamp': serverTimestamp,
          };

          await es.client.indexDocument(
            ElasticsearchConfig.analyticsIndex,
            eventId,
            enrichedEvent,
          );
          successCount++;
        } catch (e) {
          session.log('Error in batch event: $e', level: LogLevel.warning);
        }
      }

      return successCount;
    } catch (e) {
      session.log('Error in batch logging: $e', level: LogLevel.warning);
      return 0;
    }
  }

  /// Log a business event (booking, payment, etc.)
  /// Can be called from the app or internally from other endpoints
  Future<bool> logBusinessEvent(
    Session session, {
    required String eventName,
    String? propertiesJson,
    double? revenue,
    double? commission,
    int? userId,
  }) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return false;

      // Parse properties from JSON string
      Map<String, dynamic> properties = {};
      if (propertiesJson != null && propertiesJson.isNotEmpty) {
        try {
          properties = jsonDecode(propertiesJson) as Map<String, dynamic>;
        } catch (e) {
          session.log('Error parsing properties JSON: $e', level: LogLevel.warning);
        }
      }

      final eventId = _generateEventId();
      final event = <String, dynamic>{
        'eventId': eventId,
        'eventName': eventName,
        'eventType': 'business',
        'userId': userId,
        'properties': properties,
        'revenue': revenue,
        'commission': commission,
        'source': 'backend',
        'timestamp': DateTime.now().toUtc().toIso8601String(),
        'serverTimestamp': DateTime.now().toUtc().toIso8601String(),
      };

      await es.client.indexDocument(
        ElasticsearchConfig.analyticsIndex,
        eventId,
        event,
      );
      return true;
    } catch (e) {
      session.log('Error logging business event: $e', level: LogLevel.warning);
      return false;
    }
  }

  /// Get analytics summary for admin dashboard
  Future<String> getAnalyticsSummary(
    Session session, {
    String? startDate,
    String? endDate,
    String? eventType,
  }) async {
    final es = ElasticsearchService();
    if (!es.isInitialized) {
      throw Exception('Elasticsearch not initialized');
    }

    final now = DateTime.now().toUtc();
    final start = startDate ?? now.subtract(const Duration(days: 7)).toIso8601String();
    final end = endDate ?? now.toIso8601String();

    final query = <String, dynamic>{
      'size': 0,
      'query': {
        'bool': {
          'filter': [
            {
              'range': {
                'timestamp': {
                  'gte': start,
                  'lte': end,
                }
              }
            },
            if (eventType != null)
              {'term': {'eventType': eventType}},
          ]
        }
      },
      'aggs': {
        'events_over_time': {
          'date_histogram': {
            'field': 'timestamp',
            'calendar_interval': 'day',
          }
        },
        'top_events': {
          'terms': {
            'field': 'eventName',
            'size': 20,
          }
        },
        'by_event_type': {
          'terms': {
            'field': 'eventType',
            'size': 10,
          }
        },
        'by_platform': {
          'terms': {
            'field': 'platform',
            'size': 5,
          }
        },
        'total_revenue': {
          'sum': {
            'field': 'revenue',
          }
        },
        'total_commission': {
          'sum': {
            'field': 'commission',
          }
        },
        'unique_users': {
          'cardinality': {
            'field': 'userId',
          }
        },
      }
    };

    final result = await es.client.search(
      ElasticsearchConfig.analyticsIndex,
      query,
    );

    return jsonEncode({
      'period': {'start': start, 'end': end},
      'totalEvents': result['hits']?['total']?['value'] ?? 0,
      'eventsOverTime': _extractBuckets(result['aggregations']?['events_over_time']),
      'topEvents': _extractBuckets(result['aggregations']?['top_events']),
      'byEventType': _extractBuckets(result['aggregations']?['by_event_type']),
      'byPlatform': _extractBuckets(result['aggregations']?['by_platform']),
      'totalRevenue': result['aggregations']?['total_revenue']?['value'] ?? 0,
      'totalCommission': result['aggregations']?['total_commission']?['value'] ?? 0,
      'uniqueUsers': result['aggregations']?['unique_users']?['value'] ?? 0,
    });
  }

  /// Get recent events for debugging
  Future<String> getRecentEvents(
    Session session, {
    int? limit,
    String? eventName,
    String? eventType,
  }) async {
    final es = ElasticsearchService();
    if (!es.isInitialized) {
      throw Exception('Elasticsearch not initialized');
    }

    final query = <String, dynamic>{
      'size': limit ?? 50,
      'sort': [
        {'timestamp': {'order': 'desc'}}
      ],
      'query': {
        'bool': {
          'filter': [
            if (eventName != null)
              {'term': {'eventName': eventName}},
            if (eventType != null)
              {'term': {'eventType': eventType}},
          ]
        }
      }
    };

    final result = await es.client.search(
      ElasticsearchConfig.analyticsIndex,
      query,
    );

    final events = (result['hits']?['hits'] as List?)
        ?.map((hit) => hit['_source'])
        .toList() ?? [];

    return jsonEncode({
      'total': result['hits']?['total']?['value'] ?? 0,
      'events': events,
    });
  }

  // Infer event type from event name
  String _inferEventType(String eventName) {
    if (eventName.startsWith('driver_')) return 'driver';
    if (eventName.startsWith('client_') || eventName.startsWith('request_')) return 'client';
    if (eventName.startsWith('error_') || eventName.contains('error')) return 'error';
    if (eventName.contains('payment') || eventName.contains('revenue') || eventName.contains('booking')) return 'business';
    return 'engagement';
  }

  // Extract buckets from aggregation result
  List<Map<String, dynamic>> _extractBuckets(Map<String, dynamic>? agg) {
    if (agg == null) return [];
    final buckets = agg['buckets'] as List?;
    if (buckets == null) return [];
    
    return buckets.map<Map<String, dynamic>>((bucket) => <String, dynamic>{
      'key': bucket['key'],
      'count': bucket['doc_count'],
    }).toList();
  }
}
