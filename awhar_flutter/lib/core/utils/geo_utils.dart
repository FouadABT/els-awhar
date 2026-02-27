import 'dart:math' as math;

/// Utility class for geolocation calculations
class GeoUtils {
  /// Calculate distance between two coordinates using Haversine formula
  /// Returns distance in kilometers
  static double calculateDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    // Convert degrees to radians
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  /// Convert degrees to radians
  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  /// Format distance for display
  /// Returns string like "2.5 km" or "500 m"
  static String formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toStringAsFixed(0)} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  /// Calculate estimated time based on distance
  /// Assumes average speed of 40 km/h in city
  static int estimatedMinutes(double distanceKm, {double speedKmh = 40}) {
    return (distanceKm / speedKmh * 60).ceil();
  }
}
