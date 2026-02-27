import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for managing driver online/offline status
class DriverStatusEndpoint extends Endpoint {
  /// Set driver online/offline status
  Future<User?> setDriverStatus(
    Session session,
    int userId,
    bool isOnline,
  ) async {
    try {
      session.log('Setting driver status', level: LogLevel.info);
      session.log('User ID: $userId, isOnline: $isOnline', level: LogLevel.info);

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        session.log('User not found: $userId', level: LogLevel.error);
        return null;
      }

      // Verify user is a driver
      if (!user.roles.contains(UserRole.driver)) {
        session.log('User is not a driver: $userId', level: LogLevel.error);
        return null;
      }

      // Update status
      user.isOnline = isOnline;
      user.lastSeenAt = DateTime.now();
      user.updatedAt = DateTime.now();

      final updatedUser = await User.db.updateRow(session, user);

      // Mirror status on DriverProfile (authoritative for catalog/search)
      try {
        final driver = await DriverProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
        );

        if (driver != null) {
          driver.isOnline = isOnline;
          if (!isOnline) {
            // Clear location when going offline
            driver.lastLocationLat = null;
            driver.lastLocationLng = null;
            driver.lastLocationUpdatedAt = null;
            driver.autoOfflineAt = null;
          } else {
            // Set/extend auto-offline time (5 minutes from now)
            driver.autoOfflineAt = DateTime.now().add(const Duration(minutes: 5));
          }

          driver.updatedAt = DateTime.now();
          await DriverProfile.db.updateRow(session, driver);
        } else {
          session.log('No DriverProfile found for userId=$userId to mirror online status', level: LogLevel.warning);
        }
      } catch (e) {
        session.log('Error mirroring status to DriverProfile: $e', level: LogLevel.error);
      }

      session.log(
        'Driver status updated: ${updatedUser.isOnline ? "ONLINE" : "OFFLINE"}',
        level: LogLevel.info,
      );

      return updatedUser;
    } catch (e) {
      session.log('Error updating driver status: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get driver's current status
  Future<bool> getDriverStatus(
    Session session,
    int userId,
  ) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;
      
      // Verify user is a driver
      if (!user.roles.contains(UserRole.driver)) return false;
      
      return user.isOnline;
    } catch (e) {
      session.log('Error getting driver status: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get count of online drivers
  Future<int> getOnlineDriversCount(Session session) async {
    try {
      // Prefer DriverProfile as source of truth for availability in catalog/search
      final drivers = await DriverProfile.db.find(
        session,
        where: (t) => t.isOnline.equals(true),
      );
      return drivers.length;
    } catch (e) {
      session.log('Error getting online drivers count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Update lastSeenAt timestamp (for heartbeat/ping)
  Future<bool> updateLastSeen(Session session, int userId) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;

      user.lastSeenAt = DateTime.now();
      await User.db.updateRow(session, user);

      return true;
    } catch (e) {
      session.log('Error updating last seen: $e', level: LogLevel.error);
      return false;
    }
  }
}
