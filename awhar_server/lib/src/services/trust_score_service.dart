/// Trust Score Service
///
/// Computes trust scores for clients using a hybrid approach:
/// 1. **Primary**: Calls the Kibana `awhar-fraud` agent (Shield) which runs
///    the `compute_trust_score` ES|QL tool against live Elasticsearch data
/// 2. **Fallback**: Computes directly from PostgreSQL if the agent is unavailable
///
/// The trust score (0-100) is cached on the User model and refreshed:
/// - On-demand when a driver views a client's request
/// - After each completed/cancelled order
/// - In batch during the daily fraud scan
///
/// Trust Score Formula:
///   Base(50) + CompletionBonus + RatingBonus - CancelPenalty
///   - GhostPenalty - ReportPenalty + AgBonus
///
/// Architecture:
///   Driver sees request → TrustScoreEndpoint.getClientTrustScore()
///       → TrustScoreService.computeTrustScore()
///           → KibanaAgentClient.converse(agentId: 'awhar-fraud', ...)
///           → Returns TrustScoreResult with score, level, metrics

import 'dart:convert';
import 'dart:math';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'elasticsearch/kibana_agent_client.dart';

/// Service that computes and caches trust scores for clients
class TrustScoreService {
  /// Kibana Agent Builder agent ID for the fraud/shield agent
  static const String _agentId = 'awhar-fraud';

  /// Cache duration: re-compute if older than this
  static const Duration _cacheDuration = Duration(hours: 6);

  /// Compute the trust score for a client.
  ///
  /// Strategy:
  /// 1. Check if cached score is fresh enough → return cached
  /// 2. Try Kibana fraud agent (compute_trust_score tool)
  /// 3. Fallback: Compute from PostgreSQL directly
  /// 4. Cache result on User model
  static Future<TrustScoreResult> computeTrustScore(
    Session session,
    int clientId, {
    bool forceRefresh = false,
  }) async {
    // Check for cached score on User model
    if (!forceRefresh) {
      final cached = await _getCachedScore(session, clientId);
      if (cached != null) return cached;
    }

    // Try Kibana agent first (uses ES|QL compute_trust_score tool)
    TrustScoreResult? result;
    try {
      result = await _computeViaAgent(session, clientId);
    } catch (e) {
      session.log(
        '[TrustScore] ⚠️ Agent call failed for client $clientId: $e',
        level: LogLevel.warning,
      );
    }

    // Fallback: Compute from PostgreSQL
    result ??= await _computeFromDatabase(session, clientId);

    // Cache on User model
    await _cacheScore(session, clientId, result);

    return result;
  }

  /// Quick trust check — returns cached score or computes fresh.
  /// Used by driver-facing UIs that need fast response.
  static Future<TrustScoreResult?> getQuickTrustScore(
    Session session,
    int clientId,
  ) async {
    // First try cache
    final cached = await _getCachedScore(session, clientId);
    if (cached != null) return cached;

    // Compute in background, return a default for now
    return _computeFromDatabase(session, clientId);
  }

  /// Batch compute trust scores for multiple clients.
  /// Used by the daily fraud scan workflow.
  static Future<Map<int, TrustScoreResult>> batchCompute(
    Session session,
    List<int> clientIds,
  ) async {
    final results = <int, TrustScoreResult>{};
    for (final clientId in clientIds) {
      try {
        results[clientId] = await computeTrustScore(
          session, clientId,
          forceRefresh: true,
        );
      } catch (e) {
        session.log(
          '[TrustScore] ❌ Failed for client $clientId: $e',
          level: LogLevel.error,
        );
      }
    }
    return results;
  }

  // ============================================
  // PRIVATE: Computation Methods
  // ============================================

  /// Compute trust score via the Kibana fraud agent.
  ///
  /// Sends a structured prompt asking for JSON format,
  /// then parses the compute_trust_score tool output.
  static Future<TrustScoreResult?> _computeViaAgent(
    Session session,
    int clientId,
  ) async {
    final kibanaClient = KibanaAgentClient.fromEnvironment();
    final stopwatch = Stopwatch()..start();

    final prompt = 'Compute the trust score for client ID $clientId. '
        'Use the compute_trust_score tool to get the data, then provide '
        'the complete analysis. Return as JSON.';

    session.log(
      '[TrustScore] 🤖 Calling awhar-fraud agent for client $clientId',
    );

    final result = await kibanaClient.converse(
      agentId: _agentId,
      input: prompt,
    );

    stopwatch.stop();
    final elapsed = stopwatch.elapsedMilliseconds;

    if (!result.success) {
      session.log(
        '[TrustScore] ❌ Agent failed after ${elapsed}ms: ${result.errorMessage}',
        level: LogLevel.warning,
      );
      return null;
    }

    session.log(
      '[TrustScore] ✅ Agent responded in ${elapsed}ms',
    );

    // Try to parse JSON from agent response
    return _parseAgentResponse(result.message, result.steps);
  }

  /// Parse the agent's response to extract trust score data.
  ///
  /// The agent may return:
  /// 1. JSON in its message (when we ask for JSON format)
  /// 2. Tool step results with raw ES|QL data
  static TrustScoreResult? _parseAgentResponse(
    String message,
    List<Map<String, dynamic>> steps,
  ) {
    // Try to extract JSON from the message
    final jsonMatch = RegExp(r'\{[\s\S]*?"trustScore"[\s\S]*?\}').firstMatch(message);
    if (jsonMatch != null) {
      try {
        final json = jsonDecode(jsonMatch.group(0)!);
        return TrustScoreResult(
          trustScore: (json['trustScore'] ?? 50.0).toDouble(),
          trustLevel: json['trustLevel'] ?? 'FAIR',
          totalOrders: json['behaviorMetrics']?['totalOrders'] ?? 0,
          completedOrders: json['behaviorMetrics']?['completedOrders'] ?? 0,
          cancelledOrders: json['behaviorMetrics']?['cancelledOrders'] ?? 0,
          ghostOrders: json['behaviorMetrics']?['ghostOrders'] ?? 0,
          completionRate: (json['behaviorMetrics']?['completionRate'] ?? 0.0).toDouble(),
          riskScore: json['riskScore'] ?? 0,
          riskLevel: json['riskLevel'] ?? 'LOW',
          verdict: json['verdict'] ?? 'ALLOW',
          accountAgeDays: json['accountAgeDays'] ?? 0,
          totalValue: (json['behaviorMetrics']?['totalValue'] ?? 0.0).toDouble(),
          computedAt: DateTime.now(),
          source: 'ai_agent',
        );
      } catch (_) {
        // JSON parse failed, try tool steps
      }
    }

    // Try to parse from tool step results (compute_trust_score output)
    for (final step in steps) {
      final toolId = step['tool_id'] ?? step['toolId'] ?? '';
      if (toolId.toString().contains('trust_score') ||
          toolId.toString().contains('analyze_client')) {
        final data = step['result'] ?? step['output'] ?? step['data'];
        if (data is Map) {
          return TrustScoreResult(
            trustScore: _toDouble(data['trust_score'], 50.0),
            trustLevel: data['trust_level']?.toString() ?? 'FAIR',
            totalOrders: _toInt(data['total_orders'], 0),
            completedOrders: _toInt(data['completed'], 0),
            cancelledOrders: _toInt(data['cancelled'], 0),
            ghostOrders: _toInt(data['ghost'], 0),
            completionRate: _toDouble(data['completion_rate'], 0.0),
            riskScore: _toInt(data['risk_score'], 0),
            riskLevel: data['risk_level']?.toString() ?? 'LOW',
            verdict: 'ALLOW',
            accountAgeDays: _toInt(data['age_days'], 0),
            totalValue: _toDouble(data['total_value'], 0.0),
            computedAt: DateTime.now(),
            source: 'ai_agent',
          );
        }
      }
    }

    return null;
  }

  /// Compute trust score directly from PostgreSQL.
  ///
  /// This is the fallback when the Kibana agent is unavailable.
  /// Uses the same formula as the ES|QL tool.
  static Future<TrustScoreResult> _computeFromDatabase(
    Session session,
    int clientId,
  ) async {
    session.log('[TrustScore] 📊 Computing from PostgreSQL for client $clientId');

    // Get user info
    final user = await User.db.findById(session, clientId);
    final createdAt = user?.createdAt ?? DateTime.now();
    final rating = user?.ratingAsClient ?? user?.rating ?? 0.0;
    final reportsReceived = user?.totalReportsReceived ?? 0;

    // Count orders from database
    final allRequests = await ServiceRequest.db.find(
      session,
      where: (t) => t.clientId.equals(clientId),
    );

    final totalOrders = allRequests.length;
    final completed = allRequests.where((r) => r.status == RequestStatus.completed).length;
    final cancelled = allRequests.where((r) => r.status == RequestStatus.cancelled).length;
    final ghost = allRequests.where((r) =>
        r.status == RequestStatus.pending ||
        r.status == RequestStatus.driver_proposed).length;
    final totalValue = allRequests.fold<double>(
      0.0, (sum, r) => sum + (r.totalPrice ?? 0.0),
    );

    // Compute rates
    final completionRate = totalOrders > 0
        ? (completed * 100.0 / totalOrders)
        : 0.0;

    // Account age in days
    final ageDays = DateTime.now().difference(createdAt).inDays;

    // Compute trust score using the same formula
    final completionBonus = min(20.0, completionRate / 5.0);
    final ratingBonus = min(15.0, (rating ?? 0.0) * 3.0);
    final cancelPenalty = min(20.0, cancelled * 5.0);
    final ghostPenalty = min(15.0, ghost * 3.0);
    final reportPenalty = min(10.0, reportsReceived * 5.0);
    final ageBonus = min(10.0, ageDays / 30.0);

    final rawScore = 50.0 + completionBonus + ratingBonus
        - cancelPenalty - ghostPenalty - reportPenalty + ageBonus;
    final trustScore = rawScore.clamp(0.0, 100.0);

    // Determine trust level
    final trustLevel = _getTrustLevel(trustScore);

    // Determine risk
    final riskScore = (100 - trustScore).round();
    final riskLevel = _getRiskLevel(riskScore.toDouble());
    final verdict = _getVerdict(trustScore);

    return TrustScoreResult(
      trustScore: double.parse(trustScore.toStringAsFixed(1)),
      trustLevel: trustLevel,
      totalOrders: totalOrders,
      completedOrders: completed,
      cancelledOrders: cancelled,
      ghostOrders: ghost,
      completionRate: double.parse(completionRate.toStringAsFixed(1)),
      riskScore: riskScore,
      riskLevel: riskLevel,
      verdict: verdict,
      accountAgeDays: ageDays,
      totalValue: double.parse(totalValue.toStringAsFixed(2)),
      computedAt: DateTime.now(),
      source: 'server_computed',
    );
  }

  // ============================================
  // PRIVATE: Cache Methods
  // ============================================

  /// Check if we have a fresh cached trust score.
  static Future<TrustScoreResult?> _getCachedScore(
    Session session,
    int clientId,
  ) async {
    final user = await User.db.findById(session, clientId);
    if (user == null) return null;

    // Check if score exists and is fresh
    if (user.trustScore != null &&
        user.trustScore! > 0 &&
        user.trustScoreUpdatedAt != null) {
      final age = DateTime.now().difference(user.trustScoreUpdatedAt!);
      if (age < _cacheDuration) {
        // Return cached result (minimal data since it's from cache)
        return TrustScoreResult(
          trustScore: user.trustScore!,
          trustLevel: user.trustLevel ?? 'FAIR',
          totalOrders: 0, // Not cached
          completedOrders: 0,
          cancelledOrders: 0,
          ghostOrders: 0,
          completionRate: 0.0,
          riskScore: (100 - user.trustScore!).round(),
          riskLevel: _getRiskLevel(100 - user.trustScore!),
          verdict: _getVerdict(user.trustScore!),
          accountAgeDays: 0,
          totalValue: 0.0,
          computedAt: user.trustScoreUpdatedAt!,
          source: 'cached',
        );
      }
    }
    return null;
  }

  /// Cache the trust score on the User model.
  static Future<void> _cacheScore(
    Session session,
    int clientId,
    TrustScoreResult result,
  ) async {
    try {
      final user = await User.db.findById(session, clientId);
      if (user != null) {
        user.trustScore = result.trustScore;
        user.trustLevel = result.trustLevel;
        user.trustScoreUpdatedAt = DateTime.now();
        await User.db.updateRow(session, user);

        session.log(
          '[TrustScore] 💾 Cached score ${result.trustScore} '
          '(${result.trustLevel}) for client $clientId',
        );
      }
    } catch (e) {
      session.log(
        '[TrustScore] ⚠️ Failed to cache score: $e',
        level: LogLevel.warning,
      );
    }
  }

  // ============================================
  // PRIVATE: Helper Methods
  // ============================================

  static String _getTrustLevel(double score) {
    if (score >= 80) return 'EXCELLENT';
    if (score >= 60) return 'GOOD';
    if (score >= 40) return 'FAIR';
    return 'LOW';
  }

  static String _getRiskLevel(double riskScore) {
    if (riskScore >= 70) return 'CRITICAL';
    if (riskScore >= 50) return 'HIGH';
    if (riskScore >= 30) return 'MODERATE';
    return 'LOW';
  }

  static String _getVerdict(double trustScore) {
    if (trustScore >= 80) return 'ALLOW';
    if (trustScore >= 60) return 'ALLOW';
    if (trustScore >= 40) return 'MONITOR';
    if (trustScore >= 20) return 'VERIFY';
    return 'BLOCK';
  }

  static double _toDouble(dynamic value, double defaultValue) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static int _toInt(dynamic value, int defaultValue) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}
