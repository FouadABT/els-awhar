import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import '../controllers/auth_controller.dart';
import '../constants/firebase_config.dart';
import 'location_service.dart';

/// Service for tracking and updating driver location in Firebase Realtime Database
class DriverLocationService extends GetxService {
  final LocationService _locationService = Get.find<LocationService>();
  final AuthController _authController = Get.find<AuthController>();
  late final DatabaseReference _database;

  StreamSubscription<Position>? _locationSubscription;
  Timer? _updateTimer;

  final RxBool isTracking = false.obs;
  final Rx<DriverLocation?> lastLocation = Rx<DriverLocation?>(null);

  static const Duration _updateInterval = Duration(seconds: 5);
  static const double _minimumDistanceFilter = 5.0; // meters

  @override
  void onInit() {
    super.onInit();
    // Initialize with Firebase config
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: FirebaseConfig.realtimeDatabaseUrl,
    );
    _database = database.ref();
    print(
      '[DriverLocationService] ✅ Initialized with URL: ${FirebaseConfig.realtimeDatabaseUrl}',
    );
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
  }

  /// Start tracking driver location
  Future<void> startTracking() async {
    if (isTracking.value) {
      print('[DriverLocationService] Already tracking');
      return;
    }

    final user = _authController.currentUser.value;
    if (user == null || !user.roles.contains(UserRole.driver)) {
      print('[DriverLocationService] Not a driver, cannot start tracking');
      return;
    }

    // Check location permissions
    final hasPermission = await _locationService.checkLocationPermission();
    if (!hasPermission) {
      print('[DriverLocationService] No location permission');
      return;
    }

    print('[DriverLocationService] Starting location tracking');
    isTracking.value = true;

    // Start periodic updates
    _updateTimer = Timer.periodic(_updateInterval, (_) async {
      await _updateLocation();
    });

    // Also start continuous location stream for better accuracy
    _startLocationStream();

    // Initial update - run in background, don't block
    print(
      '[DriverLocationService] Triggering initial location update (non-blocking)',
    );
    _updateLocation(); // No await - let it run in background

    print('[DriverLocationService] ✅ Location tracking started');
  }

  /// Stop tracking driver location
  void stopTracking() {
    if (!isTracking.value) return;

    print('[DriverLocationService] Stopping location tracking');

    _updateTimer?.cancel();
    _updateTimer = null;

    _locationSubscription?.cancel();
    _locationSubscription = null;

    isTracking.value = false;

    // Clear location from Firebase
    _clearLocationFromFirebase();
  }

  /// Start continuous location stream
  void _startLocationStream() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Update every 5 meters
    );

    _locationSubscription =
        Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen(
          (Position position) {
            // Update immediately on significant movement
            _handleNewPosition(position);
          },
          onError: (error) {
            print('[DriverLocationService] Location stream error: $error');
          },
        );
  }

  /// Handle new position from stream
  void _handleNewPosition(Position position) {
    final lastLoc = lastLocation.value;

    // Skip if too close to last position (unless first update)
    if (lastLoc != null) {
      final distance = Geolocator.distanceBetween(
        lastLoc.latitude,
        lastLoc.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance < _minimumDistanceFilter) {
        return; // Skip this update
      }
    }

    // Update location
    _updateLocationWithPosition(position);
  }

  /// Update location to Firebase
  Future<void> _updateLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      if (position != null) {
        await _updateLocationWithPosition(position);
      }
    } catch (e) {
      print('[DriverLocationService] Error updating location: $e');
    }
  }

  /// Update location with specific position
  Future<void> _updateLocationWithPosition(Position position) async {
    final user = _authController.currentUser.value;
    if (user == null) return;

    try {
      final driverLocation = DriverLocation(
        driverId: user.id!,
        latitude: position.latitude,
        longitude: position.longitude,
        speed: position.speed,
        heading: position.heading,
        accuracy: position.accuracy,
        altitude: position.altitude,
        timestamp: DateTime.now(),
        isMoving: position.speed > 0.5, // Moving if speed > 0.5 m/s (~1.8 km/h)
      );

      // Update Firebase (for real-time tracking in delivery)
      await _database.child('driver_locations').child(user.id.toString()).set({
        'driverId': driverLocation.driverId,
        'latitude': driverLocation.latitude,
        'longitude': driverLocation.longitude,
        'speed': driverLocation.speed,
        'heading': driverLocation.heading,
        'accuracy': driverLocation.accuracy,
        'altitude': driverLocation.altitude,
        'timestamp': driverLocation.timestamp.millisecondsSinceEpoch,
        'isMoving': driverLocation.isMoving,
      });

      // Also update PostgreSQL via location endpoint (updates by userId)
      final client = Get.find<Client>();
      await client.location.updateDriverLocation(
        user.id!,
        position.latitude,
        position.longitude,
      );

      lastLocation.value = driverLocation;
      print(
        '[DriverLocationService] Location updated: ${position.latitude}, ${position.longitude}',
      );
    } catch (e) {
      print('[DriverLocationService] Error sending location: $e');
    }
  }

  /// Clear location from Firebase
  Future<void> _clearLocationFromFirebase() async {
    final user = _authController.currentUser.value;
    if (user == null) return;

    try {
      await _database
          .child('driver_locations')
          .child(user.id.toString())
          .remove();

      lastLocation.value = null;
      print('[DriverLocationService] Location cleared from Firebase');
    } catch (e) {
      print('[DriverLocationService] Error clearing location: $e');
    }
  }

  /// Listen to another driver's location
  Stream<DriverLocation?> watchDriverLocation(int driverId) {
    return _database
        .child('driver_locations')
        .child(driverId.toString())
        .onValue
        .map((event) {
          if (!event.snapshot.exists) return null;

          final data = event.snapshot.value as Map<dynamic, dynamic>;

          return DriverLocation(
            driverId: data['driverId'] as int,
            latitude: (data['latitude'] as num).toDouble(),
            longitude: (data['longitude'] as num).toDouble(),
            speed: data['speed'] != null
                ? (data['speed'] as num).toDouble()
                : null,
            heading: data['heading'] != null
                ? (data['heading'] as num).toDouble()
                : null,
            accuracy: data['accuracy'] != null
                ? (data['accuracy'] as num).toDouble()
                : null,
            altitude: data['altitude'] != null
                ? (data['altitude'] as num).toDouble()
                : null,
            timestamp: DateTime.fromMillisecondsSinceEpoch(
              data['timestamp'] as int,
            ),
            isMoving: data['isMoving'] as bool? ?? false,
          );
        });
  }

  /// Get driver's last known location (one-time fetch)
  Future<DriverLocation?> getDriverLocation(int driverId) async {
    try {
      final snapshot = await _database
          .child('driver_locations')
          .child(driverId.toString())
          .get();

      if (!snapshot.exists) return null;

      final data = snapshot.value as Map<dynamic, dynamic>;

      return DriverLocation(
        driverId: data['driverId'] as int,
        latitude: (data['latitude'] as num).toDouble(),
        longitude: (data['longitude'] as num).toDouble(),
        speed: data['speed'] != null ? (data['speed'] as num).toDouble() : null,
        heading: data['heading'] != null
            ? (data['heading'] as num).toDouble()
            : null,
        accuracy: data['accuracy'] != null
            ? (data['accuracy'] as num).toDouble()
            : null,
        altitude: data['altitude'] != null
            ? (data['altitude'] as num).toDouble()
            : null,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          data['timestamp'] as int,
        ),
        isMoving: data['isMoving'] as bool? ?? false,
      );
    } catch (e) {
      print('[DriverLocationService] Error fetching driver location: $e');
      return null;
    }
  }
}
