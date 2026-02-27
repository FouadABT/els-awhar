import 'dart:math';
import 'package:awhar_server/src/generated/protocol.dart';

/// Service for calculating pricing based on distance, service type, and other factors
class PricingService {
  // Base fare configuration (in MAD - Moroccan Dirham)
  static const double _baseFareRide = 10.0;
  static const double _baseFareDelivery = 15.0;
  static const double _baseFarePurchase = 20.0; // Higher base for shopping time
  static const double _baseFareMoving = 50.0;
  static const double _baseFareTask = 25.0;    // Hourly-ish base
  static const double _baseFareOther = 20.0;

  // Per kilometer rates (in MAD) - only relevant if distance known
  static const double _perKmRide = 5.0;
  static const double _perKmDelivery = 3.0;
  static const double _perKmPurchase = 3.0;
  static const double _perKmMoving = 8.0;
  static const double _perKmTask = 0.0;         // Tasks usually locality based
  static const double _perKmOther = 6.0;

  // Service fee percentage (platform commission)
  static const double _serviceFeePercentage = 0.10; // 10%

  // Minimum fare
  static const double _minimumFare = 15.0;

  /// Calculate price estimate based on distance and service type
  static PriceEstimate calculatePrice({
    required double? distanceKm,
    required ServiceType serviceType,
  }) {
    // Get base fare based on service type
    final baseFare = _getBaseFare(serviceType);

    // Get per km rate based on service type
    final perKmRate = _getPerKmRate(serviceType);

    // Calculate distance price (0 if distance unknown)
    final distancePrice = (distanceKm ?? 0.0) * perKmRate;

    // Calculate subtotal
    final subtotal = baseFare + distancePrice;

    // Calculate service fee
    final serviceFee = subtotal * _serviceFeePercentage;

    // Calculate total
    var total = subtotal + serviceFee;

    // Apply minimum fare
    if (total < _minimumFare) {
      total = _minimumFare;
    }

    // Round to 2 decimal places
    total = double.parse(total.toStringAsFixed(2));

    return PriceEstimate(
      basePrice: baseFare,
      distancePrice: double.parse(distancePrice.toStringAsFixed(2)),
      serviceFee: double.parse(serviceFee.toStringAsFixed(2)),
      totalPrice: total,
      distance: double.parse((distanceKm ?? 0.0).toStringAsFixed(2)),
    );
  }

  /// Calculate distance between two coordinates using Haversine formula
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Radius of Earth in kilometers

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadius * c;

    return double.parse(distance.toStringAsFixed(2));
  }

  /// Estimate duration based on distance (simple estimation)
  /// Returns duration in minutes
  static int estimateDuration(double distanceKm) {
    // Average speed: 40 km/h in cities
    const double averageSpeedKmh = 40.0;

    final durationHours = distanceKm / averageSpeedKmh;
    final durationMinutes = (durationHours * 60).ceil();

    // Minimum 5 minutes
    return durationMinutes < 5 ? 5 : durationMinutes;
  }

  /// Get base fare for service type
  static double _getBaseFare(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ride:
        return _baseFareRide;
      case ServiceType.delivery:
        return _baseFareDelivery;
      case ServiceType.purchase:
        return _baseFarePurchase;
      case ServiceType.moving:
        return _baseFareMoving;
      case ServiceType.task:
        return _baseFareTask;
      case ServiceType.other:
        return _baseFareOther;
    }
  }

  /// Get per kilometer rate for service type
  static double _getPerKmRate(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.ride:
        return _perKmRide;
      case ServiceType.delivery:
        return _perKmDelivery;
      case ServiceType.purchase:
        return _perKmPurchase;
      case ServiceType.moving:
        return _perKmMoving;
      case ServiceType.task:
        return _perKmTask;
      case ServiceType.other:
        return _perKmOther;
    }
  }

  /// Convert degrees to radians
  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  /// Get suggested price range for negotiation
  /// Returns minimum, maximum, and recommended prices
  static PriceSuggestion getSuggestedPriceRange({
    required double distanceKm,
    required ServiceType serviceType,
  }) {
    final estimate = calculatePrice(distanceKm: distanceKm, serviceType: serviceType);
    
    // Suggested range: -20% to +30% of calculated price
    final minPrice = max(_minimumFare, estimate.totalPrice * 0.8);
    final maxPrice = estimate.totalPrice * 1.3;
    final recommended = estimate.totalPrice;

    return PriceSuggestion(
      minPrice: double.parse(minPrice.toStringAsFixed(2)),
      maxPrice: double.parse(maxPrice.toStringAsFixed(2)),
      recommended: double.parse(recommended.toStringAsFixed(2)),
      basePrice: estimate.basePrice,
      distancePrice: estimate.distancePrice,
      distance: distanceKm,
    );
  }
}

/// Price estimate result
class PriceEstimate {
  final double basePrice;
  final double distancePrice;
  final double serviceFee;
  final double totalPrice;
  final double distance;

  PriceEstimate({
    required this.basePrice,
    required this.distancePrice,
    required this.serviceFee,
    required this.totalPrice,
    required this.distance,
  });

  Map<String, dynamic> toJson() => {
        'basePrice': basePrice,
        'distancePrice': distancePrice,
        'serviceFee': serviceFee,
        'totalPrice': totalPrice,
        'distance': distance,
      };
}

/// Price suggestion for client/driver negotiation
class PriceSuggestion {
  final double minPrice;
  final double maxPrice;
  final double recommended;
  final double basePrice;
  final double distancePrice;
  final double distance;

  PriceSuggestion({
    required this.minPrice,
    required this.maxPrice,
    required this.recommended,
    required this.basePrice,
    required this.distancePrice,
    required this.distance,
  });

  Map<String, dynamic> toJson() => {
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'recommended': recommended,
        'basePrice': basePrice,
        'distancePrice': distancePrice,
        'distance': distance,
      };
}
