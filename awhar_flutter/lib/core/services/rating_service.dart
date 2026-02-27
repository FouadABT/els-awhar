import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Service for managing ratings and reviews
class RatingService extends GetxService {
  final Client _client = Get.find<Client>();

  /// Submit a rating for a completed service request
  Future<Rating?> submitRating({
    required int userId,
    required int requestId,
    required int ratedUserId,
    required int ratingValue,
    required RatingType ratingType,
    String? reviewText,
    List<String>? quickTags,
  }) async {
    try {
      debugPrint('[RatingService] Submitting rating for request: $requestId');
      debugPrint('[RatingService] Rating: $ratingValue stars, type: $ratingType');
      
      final rating = await _client.rating.submitRating(
        userId,
        requestId,
        ratedUserId,
        ratingValue,
        ratingType,
        reviewText: reviewText,
        quickTags: quickTags,
      );
      
      debugPrint('[RatingService] ✅ Rating submitted successfully');
      return rating;
    } catch (e) {
      debugPrint('[RatingService] ❌ Error submitting rating: $e');
      return null;
    }
  }

  /// Get ratings received by a user
  Future<List<Rating>> getUserRatings({
    required int userId,
    RatingType? ratingType,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      debugPrint('[RatingService] Fetching ratings for user: $userId');
      
      final ratings = await _client.rating.getUserRatings(
        userId,
        ratingType: ratingType,
        limit: limit,
        offset: offset,
      );
      
      debugPrint('[RatingService] ✅ Found ${ratings.length} ratings');
      return ratings;
    } catch (e) {
      debugPrint('[RatingService] ❌ Error fetching ratings: $e');
      return [];
    }
  }

  /// Get rating statistics for a user
  Future<Map<String, dynamic>?> getUserRatingStats({
    required int userId,
  }) async {
    try {
      debugPrint('[RatingService] Fetching rating stats for user: $userId');
      
      final stats = await _client.rating.getUserRatingStats(userId);
      
      debugPrint('[RatingService] ✅ Stats: ${stats['averageRating']} avg (${stats['totalRatings']} ratings)');
      return stats;
    } catch (e) {
      debugPrint('[RatingService] ❌ Error fetching stats: $e');
      return null;
    }
  }

  /// Check if user has rated a specific request
  Future<Rating?> getRatingForRequest({
    required int requestId,
    required int raterId,
  }) async {
    try {
      debugPrint('[RatingService] Checking rating for request: $requestId');
      
      final rating = await _client.rating.getRatingForRequest(requestId, raterId);
      
      if (rating != null) {
        debugPrint('[RatingService] ✅ Found existing rating');
      } else {
        debugPrint('[RatingService] No rating found');
      }
      return rating;
    } catch (e) {
      debugPrint('[RatingService] ❌ Error checking rating: $e');
      return null;
    }
  }

  /// Check if request has been rated by both parties
  Future<Map<String, bool>?> getRequestRatingStatus({
    required int requestId,
  }) async {
    try {
      debugPrint('[RatingService] Getting rating status for request: $requestId');
      
      final status = await _client.rating.getRequestRatingStatus(requestId);
      
      debugPrint('[RatingService] ✅ Client rated: ${status['clientRated']}, Driver rated: ${status['driverRated']}');
      return status;
    } catch (e) {
      debugPrint('[RatingService] ❌ Error getting rating status: $e');
      return null;
    }
  }

  /// Get quick tag options for rating (localized)
  List<String> getQuickTags({required bool isRatingDriver}) {
    if (isRatingDriver) {
      return [
        'rating.tags.professional'.tr,
        'rating.tags.friendly'.tr,
        'rating.tags.punctual'.tr,
        'rating.tags.clean_vehicle'.tr,
        'rating.tags.safe_driving'.tr,
        'rating.tags.helpful'.tr,
        'rating.tags.great_communication'.tr,
        'rating.tags.excellent_service'.tr,
      ];
    } else {
      return [
        'rating.tags.respectful'.tr,
        'rating.tags.friendly'.tr,
        'rating.tags.punctual'.tr,
        'rating.tags.clear_instructions'.tr,
        'rating.tags.polite'.tr,
        'rating.tags.great_communication'.tr,
      ];
    }
  }
}
