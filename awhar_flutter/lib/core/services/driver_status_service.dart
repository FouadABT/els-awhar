import 'package:awhar_client/awhar_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:get/get.dart';

/// Service for managing driver online/offline status
class DriverStatusService extends GetxService {
  final Client _client = Get.find<Client>();

  /// Set driver online/offline status
  Future<User?> setDriverStatus(int userId, bool isOnline) async {
    try {
      return await _client.driverStatus.setDriverStatus(userId, isOnline);
    } catch (e) {
      print('[DriverStatusService] Error setting status: $e');
      return null;
    }
  }

  /// Get driver's current status
  Future<bool> getDriverStatus(int userId) async {
    try {
      return await _client.driverStatus.getDriverStatus(userId);
    } catch (e) {
      print('[DriverStatusService] Error getting status: $e');
      return false;
    }
  }

  /// Get count of online drivers
  Future<int> getOnlineDriversCount() async {
    try {
      return await _client.driverStatus.getOnlineDriversCount();
    } catch (e) {
      print('[DriverStatusService] Error getting online count: $e');
      return 0;
    }
  }

  /// Update lastSeenAt timestamp (heartbeat)
  Future<bool> updateLastSeen(int userId) async {
    try {
      return await _client.driverStatus.updateLastSeen(userId);
    } catch (e) {
      print('[DriverStatusService] Error updating last seen: $e');
      return false;
    }
  }
}
