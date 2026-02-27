import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for managing ratings and reviews
class RatingEndpoint extends Endpoint {
  
  /// Submit a rating for a service request
  Future<Rating> submitRating(
    Session session,
    int userId,
    int requestId,
    int ratedUserId,
    int ratingValue,
    RatingType ratingType, {
    String? reviewText,
    List<String>? quickTags,
  }) async {

    // Validate rating value (1-5)
    if (ratingValue < 1 || ratingValue > 5) {
      throw Exception('Rating must be between 1 and 5');
    }

    // Get the service request
    final request = await ServiceRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Service request not found');
    }

    // Verify request is completed
    if (request.status != RequestStatus.completed) {
      throw Exception('Can only rate completed requests');
    }

    // Verify user is part of this request
    final isClient = request.clientId == userId;
    final isDriver = request.driverId == userId;
    
    if (!isClient && !isDriver) {
      throw Exception('You are not part of this request');
    }

    // Verify rating type matches user role
    if (isClient && ratingType != RatingType.client_to_driver) {
      throw Exception('Clients can only rate drivers');
    }
    if (isDriver && ratingType != RatingType.driver_to_client) {
      throw Exception('Drivers can only rate clients');
    }

    // Verify rated user is correct
    if (isClient && ratedUserId != request.driverId) {
      throw Exception('Invalid rated user');
    }
    if (isDriver && ratedUserId != request.clientId) {
      throw Exception('Invalid rated user');
    }

    // Check if user already rated this request
    final existingRatings = await Rating.db.find(
      session,
      where: (r) => r.requestId.equals(requestId) & r.raterId.equals(userId),
    );

    if (existingRatings.isNotEmpty) {
      throw Exception('You have already rated this request');
    }

    // Create the rating
    final rating = Rating(
      requestId: requestId,
      raterId: userId,
      ratedUserId: ratedUserId,
      ratingValue: ratingValue,
      ratingType: ratingType,
      reviewText: reviewText,
      quickTags: quickTags,
    );

    final savedRating = await Rating.db.insertRow(session, rating);
    session.log('[Rating] Created rating: ${savedRating.id} - $ratingValue stars');

    // Update the rated user's average rating
    await _updateUserRating(session, ratedUserId, ratingType);

    return savedRating;
  }

  /// Update user's average rating after new rating is submitted
  Future<void> _updateUserRating(
    Session session,
    int userId,
    RatingType ratingType,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return;

    // Get all ratings for this user based on type
    final ratings = await Rating.db.find(
      session,
      where: (r) => r.ratedUserId.equals(userId) & r.ratingType.equals(ratingType),
    );

    if (ratings.isEmpty) return;

    // Calculate average
    final totalRating = ratings.fold<int>(0, (sum, r) => sum + r.ratingValue);
    final averageRating = totalRating / ratings.length;

    // Update user based on rating type
    if (ratingType == RatingType.client_to_driver) {
      // Update driver rating
      user.rating = averageRating;
      user.totalRatings = ratings.length;
    } else {
      // Update client rating
      user.ratingAsClient = averageRating;
      user.totalRatingsAsClient = ratings.length;
    }

    await User.db.updateRow(session, user);
    session.log('[Rating] Updated user $userId rating: $averageRating (${ratings.length} ratings)');
  }

  /// Get ratings received by a user
  Future<List<Rating>> getUserRatings(
    Session session,
    int userId, {
    RatingType? ratingType,
    int? limit,
    int? offset,
  }) async {
    final ratings = await Rating.db.find(
      session,
      where: (r) {
        var condition = r.ratedUserId.equals(userId);
        if (ratingType != null) {
          condition = condition & r.ratingType.equals(ratingType);
        }
        return condition;
      },
      orderBy: (r) => r.createdAt,
      orderDescending: true,
      limit: limit ?? 50,
      offset: offset ?? 0,
    );

    return ratings;
  }

  /// Get rating statistics for a user
  Future<Map<String, dynamic>> getUserRatingStats(
    Session session,
    int userId,
  ) async {
    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }

    // Get rating breakdown (count per star value)
    final allRatings = await Rating.db.find(
      session,
      where: (r) => r.ratedUserId.equals(userId),
    );

    final breakdown = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final rating in allRatings) {
      breakdown[rating.ratingValue] = (breakdown[rating.ratingValue] ?? 0) + 1;
    }

    return {
      'averageRating': user.rating ?? 0.0,
      'totalRatings': user.totalRatings,
      'averageRatingAsClient': user.ratingAsClient ?? 0.0,
      'totalRatingsAsClient': user.totalRatingsAsClient,
      'breakdown': breakdown,
    };
  }

  /// Get rating statistics for ratings given by a user (as rater)
  Future<RatingStats> getRatingsGivenStats(
    Session session,
    int raterId, {
    RatingType? ratingType,
  }) async {
    session.log('[Rating] getRatingsGivenStats called: raterId=$raterId, ratingType=$ratingType');
    
    final ratings = await Rating.db.find(
      session,
      where: (r) {
        var condition = r.raterId.equals(raterId);
        if (ratingType != null) {
          condition = condition & r.ratingType.equals(ratingType);
        }
        return condition;
      },
    );

    session.log('[Rating] Found ${ratings.length} ratings for raterId=$raterId');

    if (ratings.isEmpty) {
      session.log('[Rating] Returning empty stats');
      return RatingStats(
        averageRating: 0.0,
        totalRatings: 0,
      );
    }

    final total = ratings.fold<double>(0, (sum, r) => sum + r.ratingValue);
    final avg = total / ratings.length;

    session.log('[Rating] Returning stats: avg=$avg, total=${ratings.length}');
    return RatingStats(
      averageRating: avg,
      totalRatings: ratings.length,
    );
  }

  /// Check if user has rated a specific request
  Future<Rating?> getRatingForRequest(
    Session session,
    int requestId,
    int raterId,
  ) async {
    final ratings = await Rating.db.find(
      session,
      where: (r) => r.requestId.equals(requestId) & r.raterId.equals(raterId),
      limit: 1,
    );

    return ratings.isNotEmpty ? ratings.first : null;
  }

  /// Check if request has been rated by both parties
  Future<Map<String, bool>> getRequestRatingStatus(
    Session session,
    int requestId,
  ) async {
    final request = await ServiceRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Request not found');
    }

    final ratings = await Rating.db.find(
      session,
      where: (r) => r.requestId.equals(requestId),
    );

    final clientRated = ratings.any((r) => r.raterId == request.clientId);
    final driverRated = ratings.any((r) => r.raterId == request.driverId);

    return {
      'clientRated': clientRated,
      'driverRated': driverRated,
    };
  }
}
