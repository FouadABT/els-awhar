import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';

/// Flutter-side trust score service.
///
/// Fetches and caches trust scores from the server-side TrustScoreEndpoint.
/// Used by driver-facing screens to display client trust badges.
class TrustScoreService extends GetxService {
  final Client _client = Get.find<Client>();

  /// In-memory cache of trust scores: clientId → TrustScoreResult
  final _cache = <int, TrustScoreResult>{};

  /// Loading state per client
  final _loading = <int, bool>{};

  /// Get cached trust score (returns null if not fetched yet).
  TrustScoreResult? getCached(int clientId) => _cache[clientId];

  /// Whether a trust score is currently being fetched for this client.
  bool isLoading(int clientId) => _loading[clientId] ?? false;

  /// Fetch trust score for a client (uses server cache, fast).
  ///
  /// Returns cached result if available, otherwise fetches from server.
  Future<TrustScoreResult?> getTrustScore(int clientId) async {
    // Return cache hit
    if (_cache.containsKey(clientId)) return _cache[clientId];

    // Prevent duplicate fetches
    if (_loading[clientId] == true) return null;

    try {
      _loading[clientId] = true;
      final result = await _client.trustScore.getQuickTrustBadge(clientId);
      _cache[clientId] = result;
      return result;
    } catch (e) {
      // Silently fail — trust badge is non-critical UI
      return null;
    } finally {
      _loading[clientId] = false;
    }
  }

  /// Fetch detailed trust score (calls AI agent, slower).
  Future<TrustScoreResult?> getDetailedTrustScore(int clientId) async {
    try {
      final result = await _client.trustScore.getClientTrustScore(clientId);
      _cache[clientId] = result;
      return result;
    } catch (e) {
      return _cache[clientId]; // Return cached if available
    }
  }

  /// Force refresh trust score.
  Future<TrustScoreResult?> refreshTrustScore(int clientId) async {
    try {
      final result = await _client.trustScore.refreshTrustScore(clientId);
      _cache[clientId] = result;
      return result;
    } catch (e) {
      return _cache[clientId];
    }
  }

  /// Pre-fetch trust scores for multiple clients (e.g., nearby requests).
  Future<void> prefetchScores(List<int> clientIds) async {
    final needed = clientIds.where((id) => !_cache.containsKey(id)).toList();
    await Future.wait(
      needed.map((id) => getTrustScore(id)),
      eagerError: false,
    );
  }

  /// Clear cache
  void clearCache() {
    _cache.clear();
    _loading.clear();
  }
}
