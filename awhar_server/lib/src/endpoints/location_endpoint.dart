import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for managing driver location and address
class LocationEndpoint extends Endpoint {
  /// Update driver's current location and address
  /// Also syncs to DriverProfile table for nearby driver searches
  Future<User?> updateDriverLocation(
    Session session,
    int userId,
    double latitude,
    double longitude,
  ) async {
    try {
      // Get the user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        throw Exception('User not found');
      }

      // Update location fields in User table
      final updatedUser = user.copyWith(
        currentLatitude: latitude,
        currentLongitude: longitude,
        lastLocationUpdate: DateTime.now(),
      );

      // Save to database
      final saved = await User.db.updateRow(session, updatedUser);

      // Also update DriverProfile if this user is a driver
      try {
        final driverProfiles = await DriverProfile.db.find(
          session,
          where: (t) => t.userId.equals(userId),
          limit: 1,
        );

        if (driverProfiles.isNotEmpty) {
          final driverProfile = driverProfiles.first;
          driverProfile.lastLocationLat = latitude;
          driverProfile.lastLocationLng = longitude;
          driverProfile.lastLocationUpdatedAt = DateTime.now();

          // Keep driver online (extend auto-offline time)
          if (driverProfile.isOnline) {
            driverProfile.autoOfflineAt = DateTime.now().add(
              const Duration(seconds: 60),
            );
          }

          await DriverProfile.db.updateRow(session, driverProfile);
          session.log(
            '[LocationEndpoint] Updated driver location for user $userId',
          );
        }
      } catch (e) {
        // Driver profile update failed, but that's ok - user location is still updated
        session.log(
          '[LocationEndpoint] Warning: Could not update driver profile: $e',
        );
      }

      return saved;
    } catch (e) {
      session.log('[LocationEndpoint] Error: $e', level: LogLevel.error);
      rethrow;
    }
  }
}
