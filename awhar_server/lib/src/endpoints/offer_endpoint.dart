import 'package:serverpod/serverpod.dart' hide Order;
import '../generated/protocol.dart';

/// Offer management endpoint
/// Handles driver offers, price negotiation, offer acceptance
class OfferEndpoint extends Endpoint {
  /// Driver sends an offer on an order
  Future<DriverOffer?> sendOffer(
    Session session, {
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
  }) async {
    try {
      // Check if order exists and is open for offers
      final order = await Order.db.findById(session, orderId);

      if (order == null ||
          (order.status != OrderStatus.pending &&
              order.status != OrderStatus.negotiating)) {
        session.log('Order not available for offers: $orderId',
            level: LogLevel.warning);
        return null;
      }

      // Check if driver already has an offer for this order
      final existingOffer = await DriverOffer.db.findFirstRow(
        session,
        where: (t) => t.orderId.equals(orderId) & t.driverId.equals(driverId),
      );

      if (existingOffer != null) {
        // Update existing offer
        existingOffer.offeredPrice = offeredPrice;
        existingOffer.message = message;
        existingOffer.status = OfferStatus.pending;
        existingOffer.createdAt = DateTime.now();

        return await DriverOffer.db.updateRow(session, existingOffer);
      }

      // Create new offer
      final offer = DriverOffer(
        orderId: orderId,
        driverId: driverId,
        offeredPrice: offeredPrice,
        message: message,
        status: OfferStatus.pending,
        createdAt: DateTime.now(),
      );

      final savedOffer = await DriverOffer.db.insertRow(session, offer);

      // Update order status to negotiating
      if (order.status == OrderStatus.pending) {
        order.status = OrderStatus.negotiating;
        order.priceNegotiationStatus = PriceNegotiationStatus.offer_received;
        await Order.db.updateRow(session, order);
      }

      return savedOffer;
    } catch (e) {
      session.log('Error sending offer: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Counter offer (client or driver adjusts price)
  Future<DriverOffer?> counterOffer(
    Session session, {
    required int offerId,
    required double newPrice,
    required bool isClient,
  }) async {
    try {
      final offer = await DriverOffer.db.findById(session, offerId);

      if (offer == null) {
        return null;
      }

      // Update offer with counter price
      offer.offeredPrice = newPrice;
      offer.status = OfferStatus.pending;
      offer.createdAt = DateTime.now(); // Update timestamp for counter

      final updatedOffer = await DriverOffer.db.updateRow(session, offer);

      // Update order negotiation status
      final order = await Order.db.findById(session, offer.orderId);
      if (order != null) {
        if (isClient) {
          order.priceNegotiationStatus = PriceNegotiationStatus.client_countered;
          order.clientProposedPrice = newPrice;
        } else {
          order.priceNegotiationStatus = PriceNegotiationStatus.driver_countered;
          order.driverCounterPrice = newPrice;
        }
        await Order.db.updateRow(session, order);
      }

      return updatedOffer;
    } catch (e) {
      session.log('Error countering offer: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Accept an offer
  Future<Order?> acceptOffer(
    Session session, {
    required int offerId,
  }) async {
    try {
      final offer = await DriverOffer.db.findById(session, offerId);

      if (offer == null) {
        return null;
      }

      // Update offer status
      offer.status = OfferStatus.accepted;
      offer.respondedAt = DateTime.now();
      await DriverOffer.db.updateRow(session, offer);

      // Reject all other offers for this order
      final otherOffers = await DriverOffer.db.find(
        session,
        where: (t) =>
            t.orderId.equals(offer.orderId) & t.id.notEquals(offer.id!),
      );

      for (final otherOffer in otherOffers) {
        otherOffer.status = OfferStatus.rejected;
        otherOffer.respondedAt = DateTime.now();
        await DriverOffer.db.updateRow(session, otherOffer);
      }

      // Update order
      final order = await Order.db.findById(session, offer.orderId);
      if (order != null) {
        order.driverId = offer.driverId;
        order.status = OrderStatus.accepted;
        order.priceNegotiationStatus = PriceNegotiationStatus.price_agreed;
        order.agreedPrice = offer.offeredPrice;
        order.finalPrice = offer.offeredPrice;
        order.acceptedAt = DateTime.now();

        return await Order.db.updateRow(session, order);
      }

      return null;
    } catch (e) {
      session.log('Error accepting offer: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get all offers for an order
  Future<List<DriverOffer>> getOffersForOrder(
    Session session, {
    required int orderId,
  }) async {
    try {
      return await DriverOffer.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting offers: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Withdraw an offer (driver cancels before client accepts)
  Future<DriverOffer?> withdrawOffer(
    Session session, {
    required int offerId,
  }) async {
    try {
      final offer = await DriverOffer.db.findById(session, offerId);

      if (offer == null || offer.status != OfferStatus.pending) {
        return null;
      }

      offer.status = OfferStatus.withdrawn;
      offer.respondedAt = DateTime.now();

      return await DriverOffer.db.updateRow(session, offer);
    } catch (e) {
      session.log('Error withdrawing offer: $e', level: LogLevel.error);
      return null;
    }
  }
}
