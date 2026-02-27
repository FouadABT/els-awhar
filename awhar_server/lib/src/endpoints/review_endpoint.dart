import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Review management endpoint
/// Handles driver reviews of clients (two-way rating)
class ReviewEndpoint extends Endpoint {
  /// Driver rates a client after order completion
  Future<ClientReview?> createClientReview(
    Session session, {
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
  }) async {
    try {
      // Validate rating
      if (rating < 1 || rating > 5) {
        session.log('Invalid rating value: $rating', level: LogLevel.warning);
        return null;
      }

      // Check if review already exists
      final existing = await ClientReview.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      if (existing != null) {
        session.log('Review already exists for order: $orderId',
            level: LogLevel.warning);
        return null;
      }

      // Check if order is completed
      final order = await Order.db.findById(session, orderId);
      if (order == null || order.status != OrderStatus.completed) {
        session.log('Order not completed: $orderId', level: LogLevel.warning);
        return null;
      }

      final review = ClientReview(
        orderId: orderId,
        driverId: driverId,
        clientId: clientId,
        rating: rating,
        comment: comment,
        communicationRating: communicationRating,
        respectRating: respectRating,
        paymentPromptness: paymentPromptness,
        createdAt: DateTime.now(),
      );

      final savedReview = await ClientReview.db.insertRow(session, review);

      // Update client's average rating
      await _updateClientRating(session, clientId);

      return savedReview;
    } catch (e) {
      session.log('Error creating client review: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get all reviews for a client
  Future<List<ClientReview>> getClientReviews(
    Session session, {
    required int clientId,
    int? limit,
  }) async {
    try {
      return await ClientReview.db.find(
        session,
        where: (t) => t.clientId.equals(clientId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
      );
    } catch (e) {
      session.log('Error getting client reviews: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get reviews by a driver
  Future<List<ClientReview>> getReviewsByDriver(
    Session session, {
    required int driverId,
  }) async {
    try {
      return await ClientReview.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting reviews by driver: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Create driver review (client rates driver)
  /// This uses the existing Review table
  Future<Review?> createDriverReview(
    Session session, {
    required int orderId,
    required int clientId,
    required int driverId,
    required int rating,
    String? comment,
  }) async {
    try {
      // Validate rating
      if (rating < 1 || rating > 5) {
        session.log('Invalid rating value: $rating', level: LogLevel.warning);
        return null;
      }

      // Check if review already exists
      final existing = await Review.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      if (existing != null) {
        session.log('Review already exists for order: $orderId',
            level: LogLevel.warning);
        return null;
      }

      // Check if order is completed
      final order = await Order.db.findById(session, orderId);
      if (order == null || order.status != OrderStatus.completed) {
        session.log('Order not completed: $orderId', level: LogLevel.warning);
        return null;
      }

      final review = Review(
        orderId: orderId,
        clientId: clientId,
        driverId: driverId,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
      );

      final savedReview = await Review.db.insertRow(session, review);
      
      // Sync to Elasticsearch for sentiment analysis
      await session.esSync.indexReview(savedReview);

      // Update driver's average rating
      await _updateDriverRating(session, driverId);

      // Check if both reviews done, update order to 'rated'
      final clientReview = await ClientReview.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId),
      );

      if (clientReview != null) {
        order.status = OrderStatus.rated;
        await Order.db.updateRow(session, order);
      }

      return savedReview;
    } catch (e) {
      session.log('Error creating driver review: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update driver's average rating
  Future<void> _updateDriverRating(Session session, int driverId) async {
    try {
      final reviews = await Review.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
      );

      if (reviews.isEmpty) return;

      final total = reviews.fold(0, (sum, review) => sum + review.rating);
      final average = total / reviews.length;

      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver != null) {
        driver.ratingAverage = average;
        driver.ratingCount = reviews.length;
        final updated = await DriverProfile.db.updateRow(session, driver);
        // Sync to Elasticsearch
        await session.esSync.sync(updated);
      }
    } catch (e) {
      session.log('Error updating driver rating: $e', level: LogLevel.error);
    }
  }

  /// Update client's average rating (stored in UserClient table)
  Future<void> _updateClientRating(Session session, int clientId) async {
    try {
      final reviews = await ClientReview.db.find(
        session,
        where: (t) => t.clientId.equals(clientId),
      );

      if (reviews.isEmpty) return;

      final total = reviews.fold(0, (sum, review) => sum + review.rating);
      final average = total / reviews.length;

      // Update client's rating (assuming UserClient has rating fields)
      // You may need to add these fields to UserClient schema
      final client = await UserClient.db.findById(session, clientId);
      if (client != null) {
        // Note: Add ratingAverage and ratingCount to UserClient schema
        // client.ratingAverage = average;
        // client.ratingCount = reviews.length;
        // await UserClient.db.updateRow(session, client);
        
        session.log('Client rating calculated: $average for client $clientId');
      }
    } catch (e) {
      session.log('Error updating client rating: $e', level: LogLevel.error);
    }
  }

  /// Get all driver reviews (clients rating drivers)
  Future<List<Review>> getDriverReviews(
    Session session, {
    required int driverId,
    int? limit,
  }) async {
    try {
      return await Review.db.find(
        session,
        where: (t) => t.driverId.equals(driverId) & t.isVisible.equals(true),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
      );
    } catch (e) {
      session.log('Error getting driver reviews: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Recalculate and persist a driver's rating from reviews
  Future<bool> recalcDriverRating(
    Session session, {
    required int driverId,
  }) async {
    try {
      await _updateDriverRating(session, driverId);
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) return false;
      session.log('Recalculated rating for driverId=$driverId: count=${driver.ratingCount}, avg=${driver.ratingAverage.toStringAsFixed(2)}');
      return true;
    } catch (e) {
      session.log('Error recalculating driver rating: $e', level: LogLevel.error);
      return false;
    }
  }
}
