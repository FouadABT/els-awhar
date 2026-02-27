import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';
import 'dart:math' show sqrt, pi, atan2;

/// Order management endpoint
/// Handles order creation, status updates, cancellations
class OrderEndpoint extends Endpoint {
  /// Create a new order with expiry time
  Future<Order?> createOrder(
    Session session, {
    required int clientId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? clientProposedPrice,
    String? notes,
    String? clientInstructions,
    required DateTime expiresAt,
  }) async {
    try {
      final order = Order(
        clientId: clientId,
        serviceId: serviceId,
        pickupAddressId: pickupAddressId,
        dropoffAddressId: dropoffAddressId,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
        pickupAddress: pickupAddress,
        dropoffLatitude: dropoffLatitude,
        dropoffLongitude: dropoffLongitude,
        dropoffAddress: dropoffAddress,
        estimatedDistanceKm: estimatedDistanceKm,
        clientProposedPrice: clientProposedPrice,
        notes: notes,
        clientInstructions: clientInstructions,
        expiresAt: expiresAt,
        status: OrderStatus.pending,
        priceNegotiationStatus: clientProposedPrice != null
            ? PriceNegotiationStatus.waiting_for_offers
            : null,
        createdAt: DateTime.now(),
      );

      return await Order.db.insertRow(session, order);
    } catch (e) {
      session.log('Error creating order: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get active orders for a client
  Future<List<Order>> getActiveOrders(
    Session session, {
    required int clientId,
  }) async {
    try {
      return await Order.db.find(
        session,
        where: (t) =>
            t.clientId.equals(clientId) &
            (t.status.equals(OrderStatus.pending) |
                t.status.equals(OrderStatus.negotiating) |
                t.status.equals(OrderStatus.accepted) |
                t.status.equals(OrderStatus.driver_en_route) |
                t.status.equals(OrderStatus.arrived) |
                t.status.equals(OrderStatus.in_progress)),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting active orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get nearby orders for a driver (broadcast orders)
  Future<List<Order>> getNearbyOrders(
    Session session, {
    required int driverId,
    required double driverLat,
    required double driverLng,
    double radiusKm = 10.0,
  }) async {
    try {
      // Get all pending orders
      final orders = await Order.db.find(
        session,
        where: (t) =>
            t.status.equals(OrderStatus.pending) |
            t.status.equals(OrderStatus.negotiating),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );

      // Filter by distance (simple calculation)
      // In production, use PostGIS for accurate geo queries
      final nearbyOrders = orders.where((order) {
        if (order.pickupLatitude == null || order.pickupLongitude == null) {
          return false;
        }

        final distance = _calculateDistance(
          driverLat,
          driverLng,
          order.pickupLatitude!,
          order.pickupLongitude!,
        );

        return distance <= radiusKm;
      }).toList();

      return nearbyOrders;
    } catch (e) {
      session.log('Error getting nearby orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Cancel an order with reason
  Future<Order?> cancelOrder(
    Session session, {
    required int orderId,
    required int userId,
    required CancellerType cancelledBy,
    required String cancellationReason,
  }) async {
    try {
      final order = await Order.db.findById(session, orderId);

      if (order == null) {
        session.log('Order not found: $orderId', level: LogLevel.warning);
        return null;
      }

      // Determine status based on who cancelled
      OrderStatus newStatus;
      switch (cancelledBy) {
        case CancellerType.client:
          newStatus = OrderStatus.cancelled_by_client;
          break;
        case CancellerType.driver:
          newStatus = OrderStatus.cancelled_by_driver;
          break;
        case CancellerType.admin:
          newStatus = OrderStatus.cancelled_by_admin;
          break;
      }

      order.status = newStatus;
      order.cancellationReason = cancellationReason;
      order.cancelledByUserId = userId;
      order.cancelledBy = cancelledBy;
      order.cancelledAt = DateTime.now();

      return await Order.db.updateRow(session, order);
    } catch (e) {
      session.log('Error cancelling order: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update order status
  Future<Order?> updateOrderStatus(
    Session session, {
    required int orderId,
    required OrderStatus status,
  }) async {
    try {
      final order = await Order.db.findById(session, orderId);

      if (order == null) {
        return null;
      }

      order.status = status;

      // Update timestamps based on status
      switch (status) {
        case OrderStatus.accepted:
          order.acceptedAt = DateTime.now();
          break;
        case OrderStatus.in_progress:
          order.startedAt = DateTime.now();
          break;
        case OrderStatus.completed:
          order.completedAt = DateTime.now();
          break;
        default:
          break;
      }

      return await Order.db.updateRow(session, order);
    } catch (e) {
      session.log('Error updating order status: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Simple distance calculation (Haversine formula)
  /// For production, use PostGIS or similar
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371.0;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = (dLat / 2) * (dLat / 2) +
        _degreesToRadians(lat1) *
            _degreesToRadians(lat2) *
            (dLon / 2) *
            (dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}
