/// Smart Driver Matching Agent
/// 
/// AI-powered agent that finds the best drivers for a service request.
/// Uses Elasticsearch for intelligent matching based on:
/// - Geographic proximity
/// - Service capability
/// - Driver rating and history
/// - Current availability
/// - Premium status
/// 
/// This is the flagship agent for the Elasticsearch Agent Builder Hackathon.

import 'package:serverpod/serverpod.dart';
import '../elasticsearch/elasticsearch.dart';
import 'agent_types.dart';
import 'agent_models.dart';

/// Input for the driver matching agent
class DriverMatchingInput {
  final int? serviceId;
  final int? categoryId;
  final double latitude;
  final double longitude;
  final double? radiusKm;
  final String? vehicleTypeRequired;
  final bool preferVerified;
  final bool preferPremium;
  final double? minRating;
  final int maxResults;
  final String? specialRequirements;

  DriverMatchingInput({
    this.serviceId,
    this.categoryId,
    required this.latitude,
    required this.longitude,
    this.radiusKm,
    this.vehicleTypeRequired,
    this.preferVerified = true,
    this.preferPremium = false,
    this.minRating,
    this.maxResults = 5,
    this.specialRequirements,
  });
}

/// Smart Driver Matching Agent
/// 
/// Workflow:
/// 1. Search nearby available drivers using geo-distance
/// 2. Filter by service capability (if service/category specified)
/// 3. Score and rank drivers based on multiple factors
/// 4. Generate natural language explanation
/// 5. Return top recommendations with reasoning
class DriverMatchingAgent {
  final ElasticsearchSearchService _searchService;

  DriverMatchingAgent(this._searchService);

  /// Find the best drivers for a service request
  Future<DriverMatchingResponse> findBestDrivers(
    Session session,
    DriverMatchingInput input,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      // Step 1: Search for nearby drivers
      final searchRadius = input.radiusKm ?? 15.0;
      final candidateResult = await _searchService.searchDriversNearby(
        session,
        lat: input.latitude,
        lon: input.longitude,
        radiusKm: searchRadius,
        isOnline: true, // Only online drivers
        categoryId: input.categoryId,
        minRating: input.minRating,
        size: 50, // Get more candidates for ranking
      );

      if (candidateResult.total == 0) {
        // No drivers found, try expanding radius
        final expandedResult = await _searchService.searchDriversNearby(
          session,
          lat: input.latitude,
          lon: input.longitude,
          radiusKm: searchRadius * 2,
          isOnline: true,
          categoryId: input.categoryId,
          size: 50,
        );

        if (expandedResult.total == 0) {
          stopwatch.stop();
          return DriverMatchingResponse(
            status: AgentResponseStatus.partial,
            processingTimeMs: stopwatch.elapsedMilliseconds,
            recommendations: [],
            explanation: 'No available drivers found within ${searchRadius * 2}km of your location. Try again later or expand your search area.',
            totalCandidatesEvaluated: 0,
            searchCriteria: _buildSearchCriteria(input),
          );
        }
        
        // Continue with expanded results
        return _processAndRankDrivers(
          session,
          input,
          expandedResult.hits,
          expandedResult.total,
          stopwatch,
          expandedSearch: true,
        );
      }

      // Step 2: Process and rank the drivers
      return _processAndRankDrivers(
        session,
        input,
        candidateResult.hits,
        candidateResult.total,
        stopwatch,
      );
    } catch (e) {
      stopwatch.stop();
      return DriverMatchingResponse(
        status: AgentResponseStatus.failed,
        errorMessage: 'Failed to find drivers: $e',
        processingTimeMs: stopwatch.elapsedMilliseconds,
        recommendations: [],
        explanation: 'An error occurred while searching for drivers.',
        totalCandidatesEvaluated: 0,
      );
    }
  }

  Future<DriverMatchingResponse> _processAndRankDrivers(
    Session session,
    DriverMatchingInput input,
    List<DriverSearchHit> candidates,
    int totalCandidates,
    Stopwatch stopwatch, {
    bool expandedSearch = false,
  }) async {
    // Step 2: Score each driver using multi-factor ranking
    final scoredDrivers = <_ScoredDriver>[];
    
    for (final driver in candidates) {
      final score = _calculateMatchScore(driver, input);
      final reasons = _generateMatchReasons(driver, input, score);
      
      scoredDrivers.add(_ScoredDriver(
        driver: driver,
        score: score,
        reasons: reasons,
      ));
    }

    // Step 3: Sort by score and take top results
    scoredDrivers.sort((a, b) => b.score.compareTo(a.score));
    final topDrivers = scoredDrivers.take(input.maxResults).toList();

    // Step 4: Convert to recommendations
    final recommendations = topDrivers.map((scored) {
      final confidence = _getConfidenceLevel(scored.score);
      
      return DriverRecommendation(
        driverId: scored.driver.userId, // In our system, driverId = userId for driver
        userId: scored.driver.userId,
        displayName: scored.driver.displayName,
        profilePhotoUrl: scored.driver.profilePhotoUrl,
        ratingAverage: scored.driver.ratingAverage,
        ratingCount: scored.driver.ratingCount,
        distanceKm: scored.driver.distance ?? 0.0,
        isOnline: scored.driver.isOnline,
        isVerified: scored.driver.isVerified,
        isPremium: scored.driver.isPremium,
        totalCompletedOrders: scored.driver.totalCompletedOrders,
        matchScore: scored.score,
        confidence: confidence,
        matchReasons: scored.reasons,
        metadata: {
          'vehicleType': scored.driver.vehicleType,
          'serviceCategories': scored.driver.serviceCategories,
        },
      );
    }).toList();

    // Step 5: Generate explanation
    final explanation = _generateExplanation(
      recommendations,
      totalCandidates,
      input,
      expandedSearch,
    );

    stopwatch.stop();
    return DriverMatchingResponse(
      status: recommendations.isNotEmpty 
          ? AgentResponseStatus.success 
          : AgentResponseStatus.partial,
      processingTimeMs: stopwatch.elapsedMilliseconds,
      recommendations: recommendations,
      explanation: explanation,
      totalCandidatesEvaluated: totalCandidates,
      searchCriteria: _buildSearchCriteria(input),
    );
  }

  /// Calculate a match score for a driver (0.0 to 1.0)
  double _calculateMatchScore(DriverSearchHit driver, DriverMatchingInput input) {
    double score = 0.0;
    
    // Distance factor (closer is better) - 30% weight
    final distance = driver.distance ?? 20.0;
    final maxDistance = input.radiusKm ?? 15.0;
    final distanceScore = 1.0 - (distance / (maxDistance * 2)).clamp(0.0, 1.0);
    score += distanceScore * 0.30;

    // Rating factor - 25% weight
    final rating = driver.ratingAverage ?? 3.0;
    final ratingScore = (rating / 5.0).clamp(0.0, 1.0);
    score += ratingScore * 0.25;

    // Experience factor (completed orders) - 15% weight
    final orders = driver.totalCompletedOrders ?? 0;
    final experienceScore = (orders / 100.0).clamp(0.0, 1.0); // 100+ orders = max
    score += experienceScore * 0.15;

    // Verified bonus - 10% weight
    if (driver.isVerified) {
      score += 0.10;
    }

    // Premium bonus - 10% weight (if preference set)
    if (input.preferPremium && driver.isPremium) {
      score += 0.10;
    } else if (driver.isPremium) {
      score += 0.05; // Small bonus even without preference
    }

    // Online status - 10% weight
    if (driver.isOnline) {
      score += 0.10;
    }

    // Vehicle type match bonus
    if (input.vehicleTypeRequired != null && 
        driver.vehicleType == input.vehicleTypeRequired) {
      score += 0.05;
    }

    return score.clamp(0.0, 1.0);
  }

  /// Generate human-readable reasons for the match
  List<String> _generateMatchReasons(
    DriverSearchHit driver, 
    DriverMatchingInput input,
    double score,
  ) {
    final reasons = <String>[];

    // Distance reason
    final distance = driver.distance ?? 0.0;
    if (distance < 2.0) {
      reasons.add('🎯 Very close - only ${distance.toStringAsFixed(1)}km away');
    } else if (distance < 5.0) {
      reasons.add('📍 Nearby - ${distance.toStringAsFixed(1)}km away');
    } else {
      reasons.add('📍 ${distance.toStringAsFixed(1)}km away');
    }

    // Rating reason
    final rating = driver.ratingAverage ?? 0.0;
    if (rating >= 4.8) {
      reasons.add('⭐ Top rated driver (${rating.toStringAsFixed(1)}/5)');
    } else if (rating >= 4.5) {
      reasons.add('⭐ Highly rated (${rating.toStringAsFixed(1)}/5)');
    } else if (rating >= 4.0) {
      reasons.add('⭐ Good rating (${rating.toStringAsFixed(1)}/5)');
    }

    // Experience reason
    final orders = driver.totalCompletedOrders ?? 0;
    if (orders >= 500) {
      reasons.add('🏆 Very experienced ($orders+ completed orders)');
    } else if (orders >= 100) {
      reasons.add('✅ Experienced ($orders completed orders)');
    } else if (orders >= 20) {
      reasons.add('👍 Reliable ($orders completed orders)');
    }

    // Verification reason
    if (driver.isVerified) {
      reasons.add('✓ Verified driver');
    }

    // Premium reason
    if (driver.isPremium) {
      reasons.add('💎 Premium driver');
    }

    // Featured reason
    if (driver.isFeatured) {
      reasons.add('🌟 Featured driver');
    }

    // Online status
    if (driver.isOnline) {
      reasons.add('🟢 Currently online and available');
    }

    return reasons;
  }

  /// Determine confidence level from score
  ConfidenceLevel _getConfidenceLevel(double score) {
    if (score >= 0.75) return ConfidenceLevel.high;
    if (score >= 0.50) return ConfidenceLevel.medium;
    return ConfidenceLevel.low;
  }

  /// Generate a natural language explanation of the matching results
  String _generateExplanation(
    List<DriverRecommendation> recommendations,
    int totalCandidates,
    DriverMatchingInput input,
    bool expandedSearch,
  ) {
    if (recommendations.isEmpty) {
      return 'No suitable drivers found matching your criteria. '
             'Try expanding your search radius or adjusting requirements.';
    }

    final buffer = StringBuffer();
    
    // Summary
    buffer.write('Found ${recommendations.length} excellent match');
    if (recommendations.length > 1) buffer.write('es');
    buffer.write(' from $totalCandidates available drivers');
    if (expandedSearch) {
      buffer.write(' (expanded search radius)');
    }
    buffer.write('. ');

    // Top recommendation highlight
    final top = recommendations.first;
    buffer.write('\n\n**Top Recommendation: ${top.displayName ?? "Driver #${top.driverId}"}**\n');
    
    if (top.ratingAverage != null) {
      buffer.write('• Rating: ${top.ratingAverage!.toStringAsFixed(1)}/5');
      if (top.ratingCount != null) {
        buffer.write(' (${top.ratingCount} reviews)');
      }
      buffer.write('\n');
    }
    
    buffer.write('• Distance: ${top.distanceKm.toStringAsFixed(1)}km\n');
    buffer.write('• Match Score: ${(top.matchScore * 100).toStringAsFixed(0)}%\n');
    
    if (top.matchReasons.isNotEmpty) {
      buffer.write('• Why: ${top.matchReasons.take(3).join(", ")}\n');
    }

    // Additional options
    if (recommendations.length > 1) {
      buffer.write('\n**Other Great Options:**\n');
      for (int i = 1; i < recommendations.length && i < 4; i++) {
        final rec = recommendations[i];
        buffer.write('${i + 1}. ${rec.displayName ?? "Driver"} - ');
        buffer.write('${rec.distanceKm.toStringAsFixed(1)}km, ');
        buffer.write('${rec.ratingAverage?.toStringAsFixed(1) ?? "N/A"}/5, ');
        buffer.write('${(rec.matchScore * 100).toStringAsFixed(0)}% match\n');
      }
    }

    return buffer.toString();
  }

  Map<String, dynamic> _buildSearchCriteria(DriverMatchingInput input) => {
    'serviceId': input.serviceId,
    'categoryId': input.categoryId,
    'latitude': input.latitude,
    'longitude': input.longitude,
    'radiusKm': input.radiusKm,
    'vehicleTypeRequired': input.vehicleTypeRequired,
    'preferVerified': input.preferVerified,
    'preferPremium': input.preferPremium,
    'minRating': input.minRating,
    'maxResults': input.maxResults,
  };
}

/// Internal class for scoring drivers
class _ScoredDriver {
  final DriverSearchHit driver;
  final double score;
  final List<String> reasons;

  _ScoredDriver({
    required this.driver,
    required this.score,
    required this.reasons,
  });
}
