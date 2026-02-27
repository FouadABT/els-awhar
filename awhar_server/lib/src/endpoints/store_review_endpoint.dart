import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Store Review Endpoint
/// Handles reviews for store orders (clients review stores and drivers)
class StoreReviewEndpoint extends Endpoint {
  /// Create a review for a store order
  /// [revieweeType] should be 'store' or 'driver'
  Future<StoreReview?> createStoreReview(
    Session session, {
    required int orderId,
    required int storeId,
    required int clientId,
    required int rating,
    String? comment,
    int? foodQualityRating,
    int? packagingRating,
  }) async {
    try {
      // Validate rating
      if (rating < 1 || rating > 5) {
        session.log('Invalid rating value: $rating', level: LogLevel.warning);
        return null;
      }

      // Check if review already exists for this order (store review)
      final existing = await StoreReview.db.findFirstRow(
        session,
        where: (t) =>
            t.storeOrderId.equals(orderId) &
            t.reviewerId.equals(clientId) &
            t.revieweeType.equals('store'),
      );

      if (existing != null) {
        session.log('Store review already exists for order: $orderId',
            level: LogLevel.warning);
        return null;
      }

      // Check if order exists and is delivered
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        session.log('Order not found: $orderId', level: LogLevel.warning);
        return null;
      }
      if (order.status != StoreOrderStatus.delivered) {
        session.log('Order not delivered: $orderId', level: LogLevel.warning);
        return null;
      }

      // Build comment with ratings if provided
      String? fullComment = comment;
      if (foodQualityRating != null || packagingRating != null) {
        final parts = <String>[];
        if (comment != null && comment.isNotEmpty) parts.add(comment);
        if (foodQualityRating != null) {
          parts.add('Food Quality: $foodQualityRating/5');
        }
        if (packagingRating != null) {
          parts.add('Packaging: $packagingRating/5');
        }
        fullComment = parts.join('\n');
      }

      final review = StoreReview(
        storeOrderId: orderId,
        reviewerId: clientId,
        revieweeType: 'store',
        revieweeId: storeId,
        rating: rating,
        comment: fullComment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final savedReview = await StoreReview.db.insertRow(session, review);

      // Update store's average rating
      await _updateStoreRating(session, storeId);

      return savedReview;
    } catch (e) {
      session.log('Error creating store review: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Create a driver review for a store order
  Future<StoreReview?> createDriverReviewForStoreOrder(
    Session session, {
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
  }) async {
    try {
      if (rating < 1 || rating > 5) {
        session.log('Invalid rating: $rating', level: LogLevel.warning);
        return null;
      }

      final existing = await StoreReview.db.findFirstRow(
        session,
        where: (t) =>
            t.storeOrderId.equals(orderId) &
            t.reviewerId.equals(clientId) &
            t.revieweeType.equals('driver'),
      );

      if (existing != null) {
        session.log('Driver review exists for order: $orderId',
            level: LogLevel.warning);
        return null;
      }

      final review = StoreReview(
        storeOrderId: orderId,
        reviewerId: clientId,
        revieweeType: 'driver',
        revieweeId: driverId,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final savedReview = await StoreReview.db.insertRow(session, review);

      // Update driver's rating
      await _updateDriverRating(session, driverId);

      return savedReview;
    } catch (e) {
      session.log('Error creating driver review: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get reviews for a store
  Future<List<StoreReview>> getStoreReviews(
    Session session, {
    required int storeId,
    int? limit,
    int offset = 0,
  }) async {
    try {
      return await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals('store') & t.revieweeId.equals(storeId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting store reviews: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get reviews for a driver on store orders
  Future<List<StoreReview>> getDriverStoreReviews(
    Session session, {
    required int driverId,
    int? limit,
    int offset = 0,
  }) async {
    try {
      return await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals('driver') & t.revieweeId.equals(driverId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting driver reviews: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get reviews for any reviewee (store, driver, or client) with reviewer info
  Future<List<ReviewWithReviewer>> getReviewsForReviewee(
    Session session, {
    required String revieweeType,
    required int revieweeId,
    int? limit,
    int offset = 0,
  }) async {
    try {
      final reviews = await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals(revieweeType) &
            t.revieweeId.equals(revieweeId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
      
      // Get reviewer info for all reviews
      final reviewerIds = reviews.map((r) => r.reviewerId).toSet().toList();
      final users = await User.db.find(
        session,
        where: (t) => t.id.inSet(reviewerIds.toSet()),
      );
      final userMap = {for (var u in users) u.id: u};
      
      // Map to ReviewWithReviewer
      return reviews.map((review) {
        final reviewer = userMap[review.reviewerId];
        return ReviewWithReviewer(
          reviewId: review.id!,
          storeOrderId: review.storeOrderId,
          reviewerId: review.reviewerId,
          revieweeType: review.revieweeType,
          revieweeId: review.revieweeId,
          rating: review.rating,
          comment: review.comment,
          response: review.response,
          responseAt: review.responseAt,
          createdAt: review.createdAt,
          reviewerName: reviewer?.fullName ?? 'Anonymous',
          reviewerPhotoUrl: reviewer?.profilePhotoUrl,
        );
      }).toList();
    } catch (e) {
      session.log('Error getting reviews for $revieweeType $revieweeId: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Get all reviews by a client
  Future<List<StoreReview>> getReviewsByClient(
    Session session, {
    required int clientId,
    int? limit,
  }) async {
    try {
      return await StoreReview.db.find(
        session,
        where: (t) => t.reviewerId.equals(clientId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
      );
    } catch (e) {
      session.log('Error getting client reviews: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Store owner responds to a review
  Future<StoreReview?> respondToReview(
    Session session, {
    required int reviewId,
    required int storeId,
    required String response,
  }) async {
    try {
      final review = await StoreReview.db.findById(session, reviewId);
      if (review == null) {
        session.log('Review not found: $reviewId', level: LogLevel.warning);
        return null;
      }

      if (review.revieweeType != 'store' || review.revieweeId != storeId) {
        session.log('Not authorized to respond', level: LogLevel.warning);
        return null;
      }

      review.response = response;
      review.responseAt = DateTime.now();
      review.updatedAt = DateTime.now();

      return await StoreReview.db.updateRow(session, review);
    } catch (e) {
      session.log('Error responding to review: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Calculate and update store rating
  Future<void> _updateStoreRating(Session session, int storeId) async {
    try {
      final reviews = await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals('store') & t.revieweeId.equals(storeId),
      );

      if (reviews.isEmpty) return;

      final avgRating =
          reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

      final store = await Store.db.findById(session, storeId);
      if (store != null) {
        store.rating = avgRating;
        store.totalRatings = reviews.length;
        store.updatedAt = DateTime.now();
        final updated = await Store.db.updateRow(session, store);
        // Sync to Elasticsearch
        await session.esSync.sync(updated);
      }
    } catch (e) {
      session.log('Error updating store rating: $e', level: LogLevel.error);
    }
  }

  /// Calculate and update driver rating for store orders
  Future<void> _updateDriverRating(Session session, int driverId) async {
    try {
      final reviews = await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals('driver') & t.revieweeId.equals(driverId),
      );

      if (reviews.isEmpty) return;

      final avgRating =
          reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

      // Update driver's rating in DriverProfile if applicable
      final driver = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );

      if (driver != null) {
        driver.ratingAverage = avgRating;
        driver.ratingCount = reviews.length;
        driver.updatedAt = DateTime.now();
        final updated = await DriverProfile.db.updateRow(session, driver);
        // Sync to Elasticsearch
        await session.esSync.sync(updated);
      }
    } catch (e) {
      session.log('Error updating driver rating: $e', level: LogLevel.error);
    }
  }

  /// Get average rating for a store
  Future<Map<String, dynamic>> getStoreRatingStats(
    Session session, {
    required int storeId,
  }) async {
    try {
      final reviews = await StoreReview.db.find(
        session,
        where: (t) =>
            t.revieweeType.equals('store') & t.revieweeId.equals(storeId),
      );

      if (reviews.isEmpty) {
        return {'average': 0.0, 'count': 0, 'distribution': {}};
      }

      final avgRating =
          reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

      // Distribution of ratings
      final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
      for (final review in reviews) {
        distribution[review.rating] = (distribution[review.rating] ?? 0) + 1;
      }

      return {
        'average': avgRating,
        'count': reviews.length,
        'distribution': distribution,
      };
    } catch (e) {
      session.log('Error getting store stats: $e', level: LogLevel.error);
      return {'average': 0.0, 'count': 0, 'distribution': {}};
    }
  }
}
