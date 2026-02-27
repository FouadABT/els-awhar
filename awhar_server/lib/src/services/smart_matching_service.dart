/// Smart Matching Service
///
/// Bridges the Kibana `awhar-match` Agent Builder agent with the Serverpod
/// backend. Sends a natural-language matching prompt to the agent, parses
/// the ranked driver list from the LLM response, and returns structured
/// results that the notification layer can use.
///
/// Flow:
///   ServiceRequest → SmartMatchingService.findMatchedDrivers()
///       → KibanaAgentClient.converse(agentId: 'awhar-match', ...)
///       → LLM reasons over 9 ES|QL tools (geo, rating, workload, etc.)
///       → Parses response for driver IDs
///       → Returns SmartMatchResult with ranked driver user IDs
///
/// Fallback: If the agent fails or returns 0 drivers, callers should
/// fall back to the legacy `NotificationService.notifyAllDrivers()`.

import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'elasticsearch/kibana_agent_client.dart';

/// Singleton reference to Serverpod for creating background sessions.
/// Must be set via [SmartMatchingService.initialize] at server startup.
Serverpod? _serverpod;

/// Result from the smart matching agent
class SmartMatchResult {
  /// Ranked list of matched driver profile IDs (DriverProfile.id, NOT User.id)
  final List<int> matchedDriverProfileIds;

  /// Ranked list of matched driver user IDs (User.id) — for notifications
  final List<int> matchedDriverUserIds;

  /// The raw text explanation from the agent
  final String explanation;

  /// How long the agent took to respond (ms)
  final int processingTimeMs;

  /// Whether the agent call succeeded
  final bool success;

  /// Error message if failed
  final String? errorMessage;

  SmartMatchResult({
    this.matchedDriverProfileIds = const [],
    this.matchedDriverUserIds = const [],
    this.explanation = '',
    this.processingTimeMs = 0,
    this.success = true,
    this.errorMessage,
  });

  /// Number of matched drivers
  int get count => matchedDriverUserIds.length;

  /// Whether any drivers were matched
  bool get hasMatches => matchedDriverUserIds.isNotEmpty;
}

/// Service that calls the Kibana `awhar-match` agent to find best drivers
class SmartMatchingService {
  static const String _agentId = 'awhar-match';

  /// Initialize with a reference to the Serverpod instance.
  /// Must be called at server startup so background matching can create
  /// its own sessions (endpoint sessions close after response).
  static void initialize(Serverpod serverpod) {
    _serverpod = serverpod;
    print('[SmartMatch] ✅ Initialized with Serverpod reference');
  }

  /// Create a new session for background work.
  /// Throws if [initialize] hasn't been called.
  static Future<Session> createBackgroundSession() async {
    if (_serverpod == null) {
      throw StateError(
        'SmartMatchingService not initialized. Call SmartMatchingService.initialize(pod) at startup.',
      );
    }
    return await _serverpod!.createSession();
  }

  /// Find the best matched drivers for a service request.
  ///
  /// Calls the `awhar-match` Kibana Agent Builder agent with a structured
  /// prompt describing the request, then parses driver IDs from the response.
  ///
  /// Returns a [SmartMatchResult] with ranked driver IDs ready for notification.
  /// On failure, returns a result with `success=false` so the caller can
  /// fall back to broadcasting.
  static Future<SmartMatchResult> findMatchedDrivers(
    Session session, {
    required ServiceRequest request,
    int maxDrivers = 5,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final kibanaClient = KibanaAgentClient.fromEnvironment();

      // Build a structured prompt for the matching agent
      final prompt = _buildMatchingPrompt(request, maxDrivers);

      session.log(
        '[SmartMatch] 🤖 Calling awhar-match agent for request ${request.id} '
        '(${request.serviceType.name}, ${maxDrivers} max drivers)',
      );

      // Call the Kibana agent (sync, not streaming — we just need the result)
      final result = await kibanaClient.converse(
        agentId: _agentId,
        input: prompt,
      );

      stopwatch.stop();
      final elapsed = stopwatch.elapsedMilliseconds;

      if (!result.success) {
        session.log(
          '[SmartMatch] ❌ Agent call failed after ${elapsed}ms: ${result.errorMessage}',
          level: LogLevel.warning,
        );
        return SmartMatchResult(
          success: false,
          errorMessage: result.errorMessage,
          processingTimeMs: elapsed,
        );
      }

      session.log(
        '[SmartMatch] ✅ Agent responded in ${elapsed}ms '
        '(${result.message.length} chars, ${result.steps.length} steps)',
      );

      // Parse driver IDs from the response
      final driverIds = _parseDriverIdsFromResponse(result.message, result.steps);

      if (driverIds.isEmpty) {
        session.log(
          '[SmartMatch] ⚠️ No driver IDs parsed from agent response',
          level: LogLevel.warning,
        );
        return SmartMatchResult(
          success: true,
          explanation: result.message,
          processingTimeMs: elapsed,
        );
      }

      session.log(
        '[SmartMatch] 🎯 Parsed ${driverIds.length} driver IDs: $driverIds',
      );

      // Look up driver profiles to get user IDs for notifications
      final profileToUserMap = await _resolveDriverUserIds(session, driverIds);

      final matchedProfileIds = <int>[];
      final matchedUserIds = <int>[];
      for (final profileId in driverIds) {
        final userId = profileToUserMap[profileId];
        if (userId != null) {
          matchedProfileIds.add(profileId);
          matchedUserIds.add(userId);
        }
      }

      session.log(
        '[SmartMatch] 📋 Resolved ${matchedUserIds.length} user IDs for notification: $matchedUserIds',
      );

      return SmartMatchResult(
        matchedDriverProfileIds: matchedProfileIds,
        matchedDriverUserIds: matchedUserIds,
        explanation: result.message,
        processingTimeMs: elapsed,
        success: true,
      );
    } catch (e) {
      stopwatch.stop();
      session.log(
        '[SmartMatch] ❌ Exception: $e',
        level: LogLevel.error,
      );
      return SmartMatchResult(
        success: false,
        errorMessage: e.toString(),
        processingTimeMs: stopwatch.elapsedMilliseconds,
      );
    }
  }

  /// Build a structured prompt describing the request for the matching agent.
  static String _buildMatchingPrompt(ServiceRequest request, int maxDrivers) {
    final parts = <String>[];

    parts.add('Find the top $maxDrivers best available drivers for this request:');
    parts.add('');
    parts.add('Service Type: ${request.serviceType.name}');

    // Location info
    if (request.pickupLocation != null) {
      parts.add('Pickup Location: lat=${request.pickupLocation!.latitude}, lng=${request.pickupLocation!.longitude}');
      if (request.pickupLocation!.address != null) {
        parts.add('Pickup Address: ${request.pickupLocation!.address}');
      }
    }

    parts.add('Destination: lat=${request.destinationLocation.latitude}, lng=${request.destinationLocation.longitude}');
    if (request.destinationLocation.address != null) {
      parts.add('Destination Address: ${request.destinationLocation.address}');
    }

    // Price info
    if (request.clientOfferedPrice != null) {
      parts.add('Client Offered Price: ${request.clientOfferedPrice} MAD');
    }

    // Distance
    if (request.distance != null) {
      parts.add('Trip Distance: ${request.distance!.toStringAsFixed(1)} km');
    }

    // Notes
    if (request.notes != null && request.notes!.isNotEmpty) {
      parts.add('Notes: ${request.notes}');
    }

    // Shopping list for purchase requests
    if (request.isPurchaseRequired && request.shoppingList != null) {
      parts.add('Purchase Required: Yes');
      parts.add('Items: ${request.shoppingList!.map((i) => i.item).join(", ")}');
    }

    // Vehicle type guidance based on service type
    parts.add('');
    parts.add('IMPORTANT: Return each driver with their driver profile ID (the numeric ID from the awhar-drivers index userId field).');
    parts.add('Format each driver clearly with "Driver ID: X" where X is the numeric userId.');

    return parts.join('\n');
  }

  /// Parse driver IDs from the agent's text response and tool step results.
  ///
  /// The agent typically returns something like:
  /// "1. Fouad Driver (ID: 2) - 0.3km away, 4.8/5 rating..."
  /// "2. Fatima Zahra (ID: 7) - 0.7km away, 4.9/5 rating..."
  ///
  /// We also look in tool_result step data for structured driver data.
  static List<int> _parseDriverIdsFromResponse(
    String message,
    List<Map<String, dynamic>> steps,
  ) {
    final driverIds = <int>{};

    // Strategy 1: Parse IDs from the message text
    // Look for patterns like "ID: 2", "Driver ID: 7", "userId: 2", "(id: 2)"
    final idPatterns = [
      RegExp(r'(?:Driver\s+)?(?:Profile\s+)?ID[\s:]+(\d+)', caseSensitive: false),
      RegExp(r'userId[\s:]+(\d+)', caseSensitive: false),
      RegExp(r'\(id[\s:]+(\d+)\)', caseSensitive: false),
      RegExp(r'driver[_\s]?(?:profile[_\s]?)?id[\s:=]+(\d+)', caseSensitive: false),
    ];

    for (final pattern in idPatterns) {
      for (final match in pattern.allMatches(message)) {
        final id = int.tryParse(match.group(1) ?? '');
        if (id != null && id > 0) {
          driverIds.add(id);
        }
      }
    }

    // Strategy 2: Parse from tool results (structured data)
    for (final step in steps) {
      _extractIdsFromStep(step, driverIds);
    }

    return driverIds.toList();
  }

  /// Extract driver IDs from a tool step's results
  static void _extractIdsFromStep(Map<String, dynamic> step, Set<int> driverIds) {
    final results = step['results'];
    if (results is! List) return;

    for (final result in results) {
      if (result is! Map<String, dynamic>) continue;

      final type = result['type']?.toString();
      final data = result['data'];

      if (type == 'tabular_data' && data is Map<String, dynamic>) {
        // Tabular data has columns + values
        final columns = data['columns'] as List?;
        final values = data['values'] as List?;
        if (columns == null || values == null) continue;

        // Find the userId column index
        int userIdIdx = -1;
        for (int i = 0; i < columns.length; i++) {
          final colName = columns[i]?['name']?.toString().toLowerCase() ?? '';
          if (colName == 'userid' || colName == 'user_id' || colName == 'driverid' || colName == 'driver_id' || colName == 'id') {
            userIdIdx = i;
            break;
          }
        }

        if (userIdIdx >= 0) {
          for (final row in values) {
            if (row is List && row.length > userIdIdx) {
              final id = row[userIdIdx];
              final parsed = id is int ? id : int.tryParse(id.toString());
              if (parsed != null && parsed > 0) {
                driverIds.add(parsed);
              }
            }
          }
        }
      } else if (data is String) {
        // Try parsing as JSON
        try {
          final parsed = json.decode(data);
          if (parsed is List) {
            for (final item in parsed) {
              if (item is Map) {
                final id = item['userId'] ?? item['user_id'] ?? item['driverId'] ?? item['driver_id'] ?? item['id'];
                final parsedId = id is int ? id : int.tryParse(id?.toString() ?? '');
                if (parsedId != null && parsedId > 0) {
                  driverIds.add(parsedId);
                }
              }
            }
          }
        } catch (_) {
          // Not JSON — skip
        }
      }
    }
  }

  /// Resolve driver profile IDs to user IDs by querying the database.
  /// Returns a map of profileId → userId.
  static Future<Map<int, int>> _resolveDriverUserIds(
    Session session,
    List<int> driverIds,
  ) async {
    final map = <int, int>{};

    // The IDs from the agent could be either profile IDs or user IDs
    // depending on how the ES index was built. In our awhar-drivers index,
    // the "userId" field IS the DriverProfile.userId (= User.id).
    // So we need to check both interpretations.

    for (final id in driverIds) {
      // First try: id is a userId (User.id) — most likely from ES index
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(id),
      );
      if (driverProfile != null) {
        map[id] = driverProfile.userId;
        continue;
      }

      // Second try: id is a DriverProfile.id
      final profile = await DriverProfile.db.findById(session, id);
      if (profile != null) {
        map[id] = profile.userId;
      }
    }

    return map;
  }
}
