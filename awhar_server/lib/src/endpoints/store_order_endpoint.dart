import 'dart:convert';
import 'dart:math';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';
import 'notification_endpoint.dart';

/// Store Order management endpoint
/// Handles order placement, tracking, and management
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
class StoreOrderEndpoint extends Endpoint {
  // ==================== CLIENT ORDER OPERATIONS ====================

  /// Create a new order (client places order)
  Future<StoreOrder?> createOrder(
    Session session, {
    required int clientId,
    required int storeId,
    required List<OrderItem>
    items, // Order items with productId, quantity, notes
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    String? clientNotes,
  }) async {
    try {
      // Validate store exists and is active
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }
      if (!store.isActive) {
        throw Exception('Store is not active');
      }
      if (!store.isOpen) {
        throw Exception('Store is currently closed');
      }

      // Validate delivery is within store's zone
      final distance = _calculateDistance(
        store.latitude,
        store.longitude,
        deliveryLatitude,
        deliveryLongitude,
      );
      if (distance > store.deliveryRadiusKm) {
        throw Exception('Delivery address is outside store\'s delivery zone');
      }

      // Process items and calculate totals
      double subtotal = 0.0;
      final processedItems = <Map<String, dynamic>>[];

      for (final item in items) {
        final productId = item.productId;
        final quantity = item.quantity;
        final notes = item.notes;

        // Validate product
        final product = await StoreProduct.db.findById(session, productId);
        if (product == null) {
          throw Exception('Product not found: $productId');
        }
        if (product.storeId != storeId) {
          throw Exception('Product does not belong to this store');
        }
        if (!product.isAvailable) {
          throw Exception('Product is not available: ${product.name}');
        }

        // Add to processed items with price snapshot
        processedItems.add({
          'productId': productId,
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'quantity': quantity,
          'notes': notes,
          'imageUrl': product.imageUrl,
        });

        subtotal += product.price * quantity;
      }

      // Check minimum order amount
      if (store.minimumOrderAmount != null &&
          subtotal < store.minimumOrderAmount!) {
        throw Exception(
          'Minimum order amount is ${store.minimumOrderAmount} MAD',
        );
      }

      // Calculate delivery fee (base fee + distance-based)
      // Base: 10 MAD + 3 MAD per km
      final deliveryFee = 10.0 + (distance * 3.0);
      final total = subtotal + deliveryFee;

      // Calculate commission (5% of delivery fee)
      final commission = deliveryFee * 0.05;
      final driverEarnings = deliveryFee - commission;

      // Generate order number
      final orderNumber = _generateOrderNumber();

      // Create initial timeline
      final timeline = [
        {
          'status': 'pending',
          'timestamp': DateTime.now().toIso8601String(),
          'note': 'Order placed',
          'actor': 'client',
        },
      ];

      // Create the order
      final order = StoreOrder(
        orderNumber: orderNumber,
        storeId: storeId,
        clientId: clientId,
        driverId: null,
        status: StoreOrderStatus.pending,
        itemsJson: jsonEncode(processedItems),
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: total,
        platformCommission: commission,
        driverEarnings: driverEarnings,
        deliveryAddress: deliveryAddress,
        deliveryLatitude: deliveryLatitude,
        deliveryLongitude: deliveryLongitude,
        deliveryDistance: distance,
        clientNotes: clientNotes,
        storeNotes: null,
        timelineJson: jsonEncode(timeline),
        chatId: null,
        cancelledBy: null,
        cancellationReason: null,
        createdAt: DateTime.now(),
        confirmedAt: null,
        readyAt: null,
        pickedUpAt: null,
        deliveredAt: null,
        cancelledAt: null,
      );

      final createdOrder = await StoreOrder.db.insertRow(session, order);
      await session.esSync.sync(createdOrder);
      session.log(
        'Order created: ${createdOrder.orderNumber} for store $storeId',
      );

      // Send notification to store owner
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: store.userId,
          title: 'New Order Received! 🎉',
          body:
              'Order ${createdOrder.orderNumber} - ${createdOrder.total.toStringAsFixed(2)} MAD',
          type: NotificationType.order,
          relatedEntityId: createdOrder.id,
          relatedEntityType: 'store_order',
          data: {
            'orderId': createdOrder.id.toString(),
            'orderNumber': createdOrder.orderNumber,
            'status': createdOrder.status.name,
            'total': createdOrder.total.toString(),
            'storeId': storeId.toString(),
          },
        );
        session.log('Notification sent to store owner ${store.userId}');
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      return createdOrder;
    } catch (e) {
      session.log('Error creating order: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get order by ID
  Future<StoreOrder?> getOrder(Session session, int orderId) async {
    try {
      return await StoreOrder.db.findById(session, orderId);
    } catch (e) {
      session.log('Error getting order: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get order by order number
  Future<StoreOrder?> getOrderByNumber(
    Session session,
    String orderNumber,
  ) async {
    try {
      return await StoreOrder.db.findFirstRow(
        session,
        where: (t) => t.orderNumber.equals(orderNumber),
      );
    } catch (e) {
      session.log('Error getting order by number: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get client's orders
  Future<List<StoreOrder>> getClientOrders(
    Session session, {
    required int clientId,
    StoreOrderStatus? status,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      if (status != null) {
        return await StoreOrder.db.find(
          session,
          where: (t) => t.clientId.equals(clientId) & t.status.equals(status),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await StoreOrder.db.find(
        session,
        where: (t) => t.clientId.equals(clientId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting client orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get client's active orders (not delivered or cancelled)
  Future<List<StoreOrder>> getClientActiveOrders(
    Session session, {
    required int clientId,
  }) async {
    try {
      final orders = await StoreOrder.db.find(
        session,
        where: (t) => t.clientId.equals(clientId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );

      // Filter out completed orders
      return orders
          .where(
            (o) =>
                o.status != StoreOrderStatus.delivered &&
                o.status != StoreOrderStatus.cancelled &&
                o.status != StoreOrderStatus.rejected,
          )
          .toList();
    } catch (e) {
      session.log('Error getting active orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Cancel order (client can cancel before store confirms)
  Future<StoreOrder?> cancelOrder(
    Session session, {
    required int clientId,
    required int orderId,
    required String reason,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.clientId != clientId) {
        throw Exception('Not authorized');
      }

      // Can only cancel if pending or confirmed
      if (order.status != StoreOrderStatus.pending &&
          order.status != StoreOrderStatus.confirmed) {
        throw Exception('Order cannot be cancelled at this stage');
      }

      // Update timeline
      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'cancelled',
        'timestamp': DateTime.now().toIso8601String(),
        'note': reason,
        'actor': 'client',
      });

      final cancelledOrder = order.copyWith(
        status: StoreOrderStatus.cancelled,
        cancelledBy: 'client',
        cancellationReason: reason,
        cancelledAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(session, cancelledOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error cancelling order: $e', level: LogLevel.error);
      rethrow;
    }
  }

  // ==================== STORE ORDER OPERATIONS ====================

  /// Get store's orders
  Future<List<StoreOrder>> getStoreOrders(
    Session session, {
    required int userId,
    required int storeId,
    StoreOrderStatus? status,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Verify store ownership
      final store = await Store.db.findById(session, storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      if (status != null) {
        return await StoreOrder.db.find(
          session,
          where: (t) => t.storeId.equals(storeId) & t.status.equals(status),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await StoreOrder.db.find(
        session,
        where: (t) => t.storeId.equals(storeId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting store orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get store's pending orders
  Future<List<StoreOrder>> getStorePendingOrders(
    Session session, {
    required int userId,
    required int storeId,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      return await StoreOrder.db.find(
        session,
        where: (t) =>
            t.storeId.equals(storeId) &
            t.status.equals(StoreOrderStatus.pending),
        orderBy: (t) => t.createdAt,
      );
    } catch (e) {
      session.log('Error getting pending orders: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Confirm order (store accepts)
  Future<StoreOrder?> confirmOrder(
    Session session, {
    required int userId,
    required int orderId,
    String? storeNotes,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      // Verify store ownership
      final store = await Store.db.findById(session, order.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      if (order.status != StoreOrderStatus.pending) {
        throw Exception('Order is not pending');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'confirmed',
        'timestamp': DateTime.now().toIso8601String(),
        'note': storeNotes ?? 'Order confirmed by store',
        'actor': 'store',
      });

      final confirmedOrder = order.copyWith(
        status: StoreOrderStatus.confirmed,
        storeNotes: storeNotes ?? order.storeNotes,
        confirmedAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(
        session,
        confirmedOrder,
      );
      await session.esSync.sync(updatedOrder);

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: 'Order Confirmed! ✅',
          body:
              'Your order ${order.orderNumber} has been confirmed by the store.',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'store_order',
          data: {
            'orderId': order.id.toString(),
            'orderNumber': order.orderNumber,
            'status': 'confirmed',
            'storeId': order.storeId.toString(),
          },
        );
        session.log('Notification sent to client ${order.clientId}');
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      return updatedOrder;
    } catch (e) {
      session.log('Error confirming order: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Reject order (store declines)
  Future<StoreOrder?> rejectOrder(
    Session session, {
    required int userId,
    required int orderId,
    required String reason,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      final store = await Store.db.findById(session, order.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      if (order.status != StoreOrderStatus.pending) {
        throw Exception('Order is not pending');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'rejected',
        'timestamp': DateTime.now().toIso8601String(),
        'note': reason,
        'actor': 'store',
      });

      final rejectedOrder = order.copyWith(
        status: StoreOrderStatus.rejected,
        cancelledBy: 'store',
        cancellationReason: reason,
        cancelledAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(
        session,
        rejectedOrder,
      );
      await session.esSync.sync(updatedOrder);

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: 'Order Rejected ❌',
          body: 'Your order ${order.orderNumber} was rejected: $reason',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'store_order',
          data: {
            'orderId': order.id.toString(),
            'orderNumber': order.orderNumber,
            'status': 'rejected',
            'storeId': order.storeId.toString(),
          },
        );
        session.log('Rejection notification sent to client ${order.clientId}');
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      return updatedOrder;
    } catch (e) {
      session.log('Error rejecting order: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Mark order as preparing
  Future<StoreOrder?> markPreparing(
    Session session, {
    required int userId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      final store = await Store.db.findById(session, order.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      if (order.status != StoreOrderStatus.confirmed) {
        throw Exception('Order must be confirmed first');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'preparing',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Store is preparing the order',
        'actor': 'store',
      });

      final preparingOrder = order.copyWith(
        status: StoreOrderStatus.preparing,
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(session, preparingOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error marking preparing: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Mark order as ready for pickup
  Future<StoreOrder?> markReady(
    Session session, {
    required int userId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      final store = await Store.db.findById(session, order.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      if (order.status != StoreOrderStatus.preparing &&
          order.status != StoreOrderStatus.confirmed) {
        throw Exception('Order must be preparing');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'ready',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Order is ready for pickup',
        'actor': 'store',
      });

      final readyOrder = order.copyWith(
        status: StoreOrderStatus.ready,
        readyAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(session, readyOrder);
      await session.esSync.sync(updatedOrder);

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: 'Order Ready! 📦',
          body:
              'Your order ${order.orderNumber} is ready and waiting for pickup.',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'store_order',
          data: {
            'orderId': order.id.toString(),
            'orderNumber': order.orderNumber,
            'status': 'ready',
            'storeId': order.storeId.toString(),
          },
        );
        session.log('Ready notification sent to client ${order.clientId}');
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      // Send notification to driver if assigned
      if (order.driverId != null) {
        try {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: order.driverId!,
            title: 'Order Ready for Pickup! 📦',
            body: 'Order ${order.orderNumber} is ready at the store.',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'store_order',
            data: {
              'orderId': order.id.toString(),
              'orderNumber': order.orderNumber,
              'status': 'ready',
              'storeId': order.storeId.toString(),
            },
          );
          session.log('Ready notification sent to driver ${order.driverId}');
        } catch (e) {
          session.log(
            'Failed to send driver notification: $e',
            level: LogLevel.warning,
          );
        }
      }

      return updatedOrder;
    } catch (e) {
      session.log('Error marking ready: $e', level: LogLevel.error);
      rethrow;
    }
  }

  // ==================== DRIVER ORDER OPERATIONS ====================

  /// Assign driver to order
  Future<StoreOrder?> assignDriver(
    Session session, {
    required int userId,
    required int orderId,
    required int driverId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }

      // Verify store ownership
      final store = await Store.db.findById(session, order.storeId);
      if (store == null || store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Verify driver exists
      final driver = await User.db.findById(session, driverId);
      if (driver == null) {
        throw Exception('Driver not found');
      }

      if (order.driverId != null) {
        throw Exception('Driver already assigned');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'driverAssigned',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver assigned to order',
        'actor': 'store',
      });

      final assignedOrder = order.copyWith(
        driverId: driverId,
        status: StoreOrderStatus.driverAssigned,
        timelineJson: jsonEncode(timeline),
      );

      // TODO: Send notification to driver
      // TODO: Create 3-way chat channel

      final updatedOrder = await StoreOrder.db.updateRow(session, assignedOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error assigning driver: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver marks arrived at store
  Future<StoreOrder?> driverArrivedAtStore(
    Session session, {
    required int driverId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.driverId != driverId) {
        throw Exception('Not authorized');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'arrivedAtStore',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver arrived at store',
        'actor': 'driver',
      });

      final arrivedOrder = order.copyWith(
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(session, arrivedOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error marking arrived at store: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver picks up order
  Future<StoreOrder?> driverPickedUp(
    Session session, {
    required int driverId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.driverId != driverId) {
        throw Exception('Not authorized');
      }

      if (order.status != StoreOrderStatus.ready &&
          order.status != StoreOrderStatus.driverAssigned) {
        throw Exception('Order is not ready for pickup');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'pickedUp',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Order picked up by driver',
        'actor': 'driver',
      });

      final pickedUpOrder = order.copyWith(
        status: StoreOrderStatus.pickedUp,
        pickedUpAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      // TODO: Send notification to client

      final updatedOrder = await StoreOrder.db.updateRow(session, pickedUpOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error marking picked up: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver in delivery
  Future<StoreOrder?> driverInDelivery(
    Session session, {
    required int driverId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.driverId != driverId) {
        throw Exception('Not authorized');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'inDelivery',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Driver is on the way',
        'actor': 'driver',
      });

      final inDeliveryOrder = order.copyWith(
        status: StoreOrderStatus.inDelivery,
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(session, inDeliveryOrder);
      await session.esSync.sync(updatedOrder);
      return updatedOrder;
    } catch (e) {
      session.log('Error marking in delivery: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Driver delivers order
  Future<StoreOrder?> driverDelivered(
    Session session, {
    required int driverId,
    required int orderId,
  }) async {
    try {
      final order = await StoreOrder.db.findById(session, orderId);
      if (order == null) {
        throw Exception('Order not found');
      }
      if (order.driverId != driverId) {
        throw Exception('Not authorized');
      }

      final timeline = _getTimeline(order);
      timeline.add({
        'status': 'delivered',
        'timestamp': DateTime.now().toIso8601String(),
        'note': 'Order delivered successfully',
        'actor': 'driver',
      });

      final deliveredOrder = order.copyWith(
        status: StoreOrderStatus.delivered,
        deliveredAt: DateTime.now(),
        timelineJson: jsonEncode(timeline),
      );

      final updatedOrder = await StoreOrder.db.updateRow(
        session,
        deliveredOrder,
      );
      await session.esSync.sync(updatedOrder);

      // Send notification to client
      try {
        final notificationEndpoint = NotificationEndpoint();
        await notificationEndpoint.createNotification(
          session,
          userId: order.clientId,
          title: 'Order Delivered! 🎉',
          body:
              'Your order ${order.orderNumber} has been delivered successfully.',
          type: NotificationType.order,
          relatedEntityId: order.id,
          relatedEntityType: 'store_order',
          data: {
            'orderId': order.id.toString(),
            'orderNumber': order.orderNumber,
            'status': 'delivered',
            'storeId': order.storeId.toString(),
          },
        );
        session.log('Delivery notification sent to client ${order.clientId}');
      } catch (e) {
        session.log('Failed to send notification: $e', level: LogLevel.warning);
      }

      // Send notification to store
      try {
        final store = await Store.db.findById(session, order.storeId);
        if (store != null) {
          final notificationEndpoint = NotificationEndpoint();
          await notificationEndpoint.createNotification(
            session,
            userId: store.userId,
            title: 'Order Delivered! ✅',
            body: 'Order ${order.orderNumber} was delivered successfully.',
            type: NotificationType.order,
            relatedEntityId: order.id,
            relatedEntityType: 'store_order',
            data: {
              'orderId': order.id.toString(),
              'orderNumber': order.orderNumber,
              'status': 'delivered',
              'storeId': order.storeId.toString(),
            },
          );
          session.log('Delivery notification sent to store ${store.userId}');
        }
      } catch (e) {
        session.log(
          'Failed to send store notification: $e',
          level: LogLevel.warning,
        );
      }

      // TODO: Process earnings/commission

      return updatedOrder;
    } catch (e) {
      session.log('Error marking delivered: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get driver's store delivery orders
  Future<List<StoreOrder>> getDriverStoreOrders(
    Session session, {
    required int driverId,
    bool activeOnly = false,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      if (activeOnly) {
        final orders = await StoreOrder.db.find(
          session,
          where: (t) => t.driverId.equals(driverId),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
        );

        return orders
            .where(
              (o) =>
                  o.status != StoreOrderStatus.delivered &&
                  o.status != StoreOrderStatus.cancelled &&
                  o.status != StoreOrderStatus.rejected,
            )
            .toList();
      }

      return await StoreOrder.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('Error getting driver orders: $e', level: LogLevel.error);
      return [];
    }
  }

  // ==================== HELPER METHODS ====================

  /// Generate order number (ORD-XXXXXX)
  String _generateOrderNumber() {
    final random = Random();
    final number = random.nextInt(900000) + 100000; // 6-digit number
    return 'ORD-$number';
  }

  /// Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371.0; // km

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// Parse timeline from order
  List<Map<String, dynamic>> _getTimeline(StoreOrder order) {
    if (order.timelineJson == null || order.timelineJson!.isEmpty) {
      return [];
    }
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(order.timelineJson!));
    } catch (e) {
      return [];
    }
  }
}
