import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/rating_service.dart';

/// Controller for managing ratings and reviews
class RatingController extends GetxController {
  final RatingService _ratingService = Get.find<RatingService>();

  // Observable state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasSubmittedRating = false.obs;
  
  // Current rating being submitted
  final RxInt currentRating = 0.obs;
  final RxString currentReviewText = ''.obs;
  final RxList<String> selectedQuickTags = <String>[].obs;
  
  // User ratings
  final RxList<Rating> userRatings = <Rating>[].obs;
  final RxDouble averageRating = 0.0.obs;
  final RxInt totalRatings = 0.obs;
  final RxMap<int, int> ratingBreakdown = <int, int>{}.obs;

  /// Reset rating state for new submission
  void resetRatingState() {
    currentRating.value = 0;
    currentReviewText.value = '';
    selectedQuickTags.clear();
    hasSubmittedRating.value = false;
    errorMessage.value = '';
  }

  /// Set rating value (1-5)
  void setRating(int value) {
    if (value >= 1 && value <= 5) {
      currentRating.value = value;
    }
  }

  /// Set review text
  void setReviewText(String text) {
    currentReviewText.value = text;
  }

  /// Toggle quick tag selection
  void toggleQuickTag(String tag) {
    if (selectedQuickTags.contains(tag)) {
      selectedQuickTags.remove(tag);
    } else {
      selectedQuickTags.add(tag);
    }
  }

  /// Submit rating for a completed request
  Future<bool> submitRating({
    required int userId,
    required int requestId,
    required int ratedUserId,
    required RatingType ratingType,
  }) async {
    if (currentRating.value == 0) {
      errorMessage.value = 'rating.error.select_rating'.tr;
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final rating = await _ratingService.submitRating(
        userId: userId,
        requestId: requestId,
        ratedUserId: ratedUserId,
        ratingValue: currentRating.value,
        ratingType: ratingType,
        reviewText: currentReviewText.value.isNotEmpty ? currentReviewText.value : null,
        quickTags: selectedQuickTags.isNotEmpty ? selectedQuickTags.toList() : null,
      );

      if (rating != null) {
        hasSubmittedRating.value = true;
        Get.snackbar(
          'rating.success.title'.tr,
          'rating.success.message'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        errorMessage.value = 'rating.error.submit_failed'.tr;
        return false;
      }
    } catch (e) {
      debugPrint('[RatingController] Error: $e');
      errorMessage.value = 'rating.error.submit_failed'.tr;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load user ratings
  Future<void> loadUserRatings({
    required int userId,
    RatingType? ratingType,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final ratings = await _ratingService.getUserRatings(
        userId: userId,
        ratingType: ratingType,
      );
      
      userRatings.value = ratings;
    } catch (e) {
      debugPrint('[RatingController] Error loading ratings: $e');
      errorMessage.value = 'rating.error.load_failed'.tr;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load rating statistics
  Future<void> loadRatingStats({required int userId}) async {
    try {
      isLoading.value = true;

      final stats = await _ratingService.getUserRatingStats(userId: userId);
      
      if (stats != null) {
        averageRating.value = (stats['averageRating'] as num?)?.toDouble() ?? 0.0;
        totalRatings.value = (stats['totalRatings'] as int?) ?? 0;
        
        final breakdown = stats['breakdown'] as Map<dynamic, dynamic>?;
        if (breakdown != null) {
          ratingBreakdown.value = breakdown.map(
            (key, value) => MapEntry(int.parse(key.toString()), value as int),
          );
        }
      }
    } catch (e) {
      debugPrint('[RatingController] Error loading stats: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user has already rated a request
  Future<bool> hasRatedRequest({
    required int requestId,
    required int raterId,
  }) async {
    try {
      final rating = await _ratingService.getRatingForRequest(
        requestId: requestId,
        raterId: raterId,
      );
      return rating != null;
    } catch (e) {
      debugPrint('[RatingController] Error checking rating: $e');
      return false;
    }
  }

  /// Check request rating status
  Future<Map<String, bool>?> getRequestRatingStatus({
    required int requestId,
  }) async {
    try {
      return await _ratingService.getRequestRatingStatus(requestId: requestId);
    } catch (e) {
      debugPrint('[RatingController] Error getting status: $e');
      return null;
    }
  }

  /// Get quick tags for rating dialog
  List<String> getQuickTags({required bool isRatingDriver}) {
    return _ratingService.getQuickTags(isRatingDriver: isRatingDriver);
  }
}
