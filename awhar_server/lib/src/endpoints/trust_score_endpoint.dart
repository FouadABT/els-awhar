import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/trust_score_service.dart';

/// Trust Score Endpoint
///
/// Provides API access to the Trust Score system which combines:
/// - Kibana `awhar-fraud` agent (AI-powered analysis)
/// - Server-side computation (PostgreSQL fallback)
///
/// Used by:
/// - Drivers viewing incoming requests (quick badge display)
/// - Client profile screens (detailed trust breakdown)
/// - Admin dashboard (platform-wide trust overview)
class TrustScoreEndpoint extends Endpoint {

  /// Get the trust score for a client.
  ///
  /// Returns a full [TrustScoreResult] with score, level, metrics.
  /// Uses cached score if fresh (< 6 hours), otherwise recomputes.
  ///
  /// Called by drivers when viewing a request to see client trust badge.
  Future<TrustScoreResult> getClientTrustScore(
    Session session,
    int clientId,
  ) async {
    return await TrustScoreService.computeTrustScore(session, clientId);
  }

  /// Get a quick trust badge for display purposes.
  ///
  /// Returns minimal data (score + level) optimized for fast display.
  /// Never calls the Kibana agent — uses cache or PostgreSQL only.
  Future<TrustScoreResult> getQuickTrustBadge(
    Session session,
    int clientId,
  ) async {
    final result = await TrustScoreService.getQuickTrustScore(session, clientId);
    return result ?? TrustScoreResult(
      trustScore: 50.0,
      trustLevel: 'FAIR',
      totalOrders: 0,
      completedOrders: 0,
      cancelledOrders: 0,
      ghostOrders: 0,
      completionRate: 0.0,
      riskScore: 50,
      riskLevel: 'MODERATE',
      verdict: 'MONITOR',
      accountAgeDays: 0,
      totalValue: 0.0,
      computedAt: DateTime.now(),
      source: 'default',
    );
  }

  /// Force refresh the trust score for a client.
  ///
  /// Calls the Kibana fraud agent for a fresh computation.
  /// Used by admins or after significant events (order completion, cancellation).
  Future<TrustScoreResult> refreshTrustScore(
    Session session,
    int clientId,
  ) async {
    return await TrustScoreService.computeTrustScore(
      session, clientId,
      forceRefresh: true,
    );
  }

  /// Batch compute trust scores for multiple clients.
  ///
  /// Used by the admin dashboard and daily fraud scan workflow.
  /// Returns a map of clientId → TrustScoreResult.
  Future<List<TrustScoreResult>> batchComputeTrustScores(
    Session session,
    List<int> clientIds,
  ) async {
    final results = await TrustScoreService.batchCompute(session, clientIds);
    return results.values.toList();
  }

  /// Get platform-wide trust statistics.
  ///
  /// Returns aggregated trust data for the admin dashboard.
  Future<Map<String, dynamic>> getPlatformTrustStats(
    Session session,
  ) async {
    // Get all users with trust scores
    final users = await User.db.find(
      session,
      where: (t) => t.trustScore.notEquals(null),
    );

    final scores = users
        .where((u) => u.trustScore != null && u.trustScore! > 0)
        .map((u) => u.trustScore!)
        .toList();

    if (scores.isEmpty) {
      return {
        'totalScored': 0,
        'averageScore': 0.0,
        'excellent': 0,
        'good': 0,
        'fair': 0,
        'low': 0,
      };
    }

    final avg = scores.reduce((a, b) => a + b) / scores.length;
    final excellent = scores.where((s) => s >= 80).length;
    final good = scores.where((s) => s >= 60 && s < 80).length;
    final fair = scores.where((s) => s >= 40 && s < 60).length;
    final low = scores.where((s) => s < 40).length;

    return {
      'totalScored': scores.length,
      'averageScore': double.parse(avg.toStringAsFixed(1)),
      'excellent': excellent,
      'good': good,
      'fair': fair,
      'low': low,
    };
  }
}
