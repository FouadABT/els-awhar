import 'dart:async';
import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import '../generated/protocol.dart';

/// Professional Driver Cleanup Service
/// 
/// Runs every 30 minutes to ensure driver online status is accurate.
/// A driver stays online as long as:
/// - They have heartbeat within the last 30 minutes
/// - OR their database lastSeenAt is within 30 minutes
/// 
/// Logic:
/// - Cleanup runs every 30 minutes
/// - If no activity for 30 min → mark offline
/// - Drivers can stay online indefinitely if app is active with heartbeat
class DriverCleanupService {
  static const Duration _presenceTimeout = Duration(minutes: 30);
  static const String _firebaseDbUrl = 'https://awhar-5afc5-default-rtdb.firebaseio.com';
  
  static Timer? _cleanupTimer;

  /// Initialize the cleanup timer (runs every 30 minutes)
  static void initialize(Serverpod serverpod) {
    // Cancel any existing timer
    _cleanupTimer?.cancel();
    
    // Run cleanup every 30 minutes
    _cleanupTimer = Timer.periodic(const Duration(minutes: 30), (_) async {
      final session = await serverpod.createSession();
      try {
        await _runCleanup(session);
      } finally {
        await session.close();
      }
    });

    print('[DriverCleanupService] ✅ Driver cleanup initialized (runs every 30 minutes)');
    
    // Also run cleanup once on startup (after 5 minutes to let drivers sync)
    Future.delayed(const Duration(minutes: 5), () async {
      final session = await serverpod.createSession();
      try {
        print('[DriverCleanupService] 🧹 Running initial cleanup after server start...');
        await _runCleanup(session);
      } finally {
        await session.close();
      }
    });
  }

  /// Execute cleanup job
  static Future<void> _runCleanup(Session session) async {
    session.log('🧹 Starting driver presence cleanup (30-min timeout)...', level: LogLevel.info);

    try {
      final now = DateTime.now();
      int cleanedCount = 0;
      int activeCount = 0;

      // Get all online drivers
      final onlineDrivers = await User.db.find(
        session,
        where: (t) => t.isOnline.equals(true),
      );

      session.log('📊 Found ${onlineDrivers.length} drivers marked as online', level: LogLevel.info);

      for (final driver in onlineDrivers) {
        try {
          bool isActive = false;

          // Check 1: Database lastSeenAt
          if (driver.lastSeenAt != null) {
            final dbTimeSince = now.difference(driver.lastSeenAt!);
            if (dbTimeSince < _presenceTimeout) {
              session.log(
                '✅ Driver ${driver.id} active via DB (${dbTimeSince.inMinutes}m ago)',
                level: LogLevel.debug,
              );
              isActive = true;
            }
          }

          // Check 2: Firebase presence (only if DB check failed)
          if (!isActive) {
            final url = '$_firebaseDbUrl/presence/users/${driver.id}.json';
            
            try {
              final response = await http.get(Uri.parse(url)).timeout(
                const Duration(seconds: 10),
              );

              if (response.statusCode == 200 && response.body != 'null') {
                final presenceData = jsonDecode(response.body);
                final lastSeenMs = presenceData?['lastSeen'];
                
                if (lastSeenMs != null) {
                  final lastSeenInt = lastSeenMs is int ? lastSeenMs : (lastSeenMs as num).toInt();
                  final lastSeen = DateTime.fromMillisecondsSinceEpoch(lastSeenInt);
                  final timeSince = now.difference(lastSeen);
                  
                  if (timeSince < _presenceTimeout) {
                    session.log(
                      '✅ Driver ${driver.id} active via Firebase (${timeSince.inMinutes}m ago)',
                      level: LogLevel.debug,
                    );
                    isActive = true;
                  }
                }
              }
            } catch (e) {
              session.log(
                '⚠️ Firebase check failed for driver ${driver.id}: $e',
                level: LogLevel.warning,
              );
              // If Firebase check fails, trust DB status
              continue;
            }
          }

          if (isActive) {
            activeCount++;
          } else {
            // Driver is stale - mark offline
            session.log(
              '⏱️ Driver ${driver.id} (${driver.email}) inactive for 30+ min - marking offline',
              level: LogLevel.info,
            );
            await _markDriverOffline(session, driver);
            cleanedCount++;
          }
        } catch (e) {
          session.log(
            '❌ Error checking driver ${driver.id}: $e',
            level: LogLevel.error,
          );
        }
      }

      session.log(
        '🧹 Cleanup complete: active=$activeCount, cleaned=$cleanedCount, total=${onlineDrivers.length}',
        level: LogLevel.info,
      );
    } catch (e) {
      session.log('❌ Error in driver cleanup job: $e', level: LogLevel.error);
    }
  }

  /// Mark a driver as offline and clean up related data
  static Future<void> _markDriverOffline(Session session, User driver) async {
    try {
      // Update user status
      driver.isOnline = false;
      driver.updatedAt = DateTime.now();
      await User.db.updateRow(session, driver);

      // Update driver profile
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driver.id),
      );

      if (driverProfile != null) {
        driverProfile.isOnline = false;
        driverProfile.lastLocationLat = null;
        driverProfile.lastLocationLng = null;
        driverProfile.lastLocationUpdatedAt = null;
        driverProfile.autoOfflineAt = null;
        driverProfile.updatedAt = DateTime.now();
        await DriverProfile.db.updateRow(session, driverProfile);
      }

      // Clear presence in Firebase via REST API
      try {
        await http.delete(
          Uri.parse('$_firebaseDbUrl/presence/users/${driver.id}.json'),
        ).timeout(const Duration(seconds: 5));

        await http.delete(
          Uri.parse('$_firebaseDbUrl/presence/drivers/${driver.id}.json'),
        ).timeout(const Duration(seconds: 5));

        session.log(
          '✅ Cleared presence for driver ${driver.id}',
          level: LogLevel.debug,
        );
      } catch (e) {
        session.log(
          '⚠️ Failed to clear Firebase presence for driver ${driver.id}: $e',
          level: LogLevel.warning,
        );
      }
    } catch (e) {
      session.log('❌ Error marking driver ${driver.id} offline: $e', level: LogLevel.error);
    }
  }
  
  /// Dispose cleanup timer (call on server shutdown)
  static void dispose() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }
}
