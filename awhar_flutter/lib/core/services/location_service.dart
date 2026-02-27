import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import '../controllers/auth_controller.dart';

/// Service for handling all location-related operations
class LocationService extends GetxService {
  final RxBool isLocationEnabled = false.obs;
  final RxBool hasLocationPermission = false.obs;
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxString currentAddress = ''.obs;
  final RxBool isSavingLocation = false.obs;

  // Test location override (for testing purposes)
  Position? _testLocation;

  Future<LocationService> init() async {
    await checkLocationPermission();
    return this;
  }

  /// Set a test location (for testing purposes)
  void setTestLocation(double latitude, double longitude) {
    _testLocation = Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    print('[LocationService] 🧪 Test location set: $latitude, $longitude');
  }

  /// Clear test location and use actual device location
  void clearTestLocation() {
    _testLocation = null;
    print('[LocationService] ✅ Test location cleared, using actual GPS');
  }

  /// Check and request location permission
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLocationEnabled.value = false;
      Get.snackbar(
        'Location Services Disabled',
        'Please enable location services in your device settings',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    isLocationEnabled.value = true;

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        hasLocationPermission.value = false;
        Get.snackbar(
          'Location Permission Denied',
          'Awhar needs location permission to show nearby drivers',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      hasLocationPermission.value = false;
      Get.snackbar(
        'Location Permission Permanently Denied',
        'Please enable location permission in app settings',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      return false;
    }

    hasLocationPermission.value = true;
    return true;
  }

  /// Get current position with high accuracy
  Future<Position?> getCurrentPosition() async {
    // Return test location if set
    if (_testLocation != null) {
      print(
        '[LocationService] 🧪 Using test location: ${_testLocation!.latitude}, ${_testLocation!.longitude}',
      );
      currentPosition.value = _testLocation;
      return _testLocation;
    }

    try {
      final hasPermission = await checkLocationPermission();
      if (!hasPermission) return null;

      final position =
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
            ),
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              print('[LocationService] getCurrentPosition timed out after 10s');
              throw TimeoutException('Location request timed out');
            },
          );

      currentPosition.value = position;
      return position;
    } catch (e) {
      print('[LocationService] Error getting location: $e');
      return null;
    }
  }

  /// Stream location updates for real-time tracking
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
        timeLimit: Duration(seconds: 5),
      ),
    );
  }

  /// Get address from coordinates (reverse geocoding)
  Future<String?> getAddressFromCoordinates(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.country}';
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  /// Get coordinates from address (geocoding)
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
      return null;
    } catch (e) {
      print('Error getting coordinates: $e');
      return null;
    }
  }

  /// Calculate distance between two points in kilometers
  double calculateDistance(LatLng from, LatLng to) {
    return Geolocator.distanceBetween(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        ) /
        1000; // Convert to kilometers
  }

  /// Calculate bearing between two points
  double calculateBearing(LatLng from, LatLng to) {
    return Geolocator.bearingBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );
  }

  /// Save driver's current location to database
  Future<bool> saveLocationToDatabase() async {
    try {
      isSavingLocation.value = true;

      final position = await getCurrentPosition();
      if (position == null) {
        Get.snackbar(
          'Error',
          'Could not get current location',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      // Get address from coordinates
      String? address;
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          address = '${place.street}, ${place.locality}, ${place.country}';
          currentAddress.value = address;
        }
      } catch (e) {
        print('[LocationService] Error getting address: $e');
      }

      // Save to backend
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;

      if (userId == null) {
        Get.snackbar(
          'Error',
          'User not logged in',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }

      final client = Get.find<Client>();
      await client.location.updateDriverLocation(
        userId,
        position.latitude,
        position.longitude,
      );

      print(
        '[LocationService] ✅ Location saved: ${position.latitude}, ${position.longitude}',
      );
      if (address != null) {
        print('[LocationService] 📍 Address: $address');
      }

      Get.snackbar(
        'Success',
        'Location saved successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );

      return true;
    } catch (e) {
      print('[LocationService] ❌ Error saving location: $e');
      Get.snackbar(
        'Error',
        'Failed to save location: $e',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isSavingLocation.value = false;
    }
  }

  /// Check if saved location differs from current GPS location by more than threshold
  Future<double?> checkLocationMismatch() async {
    try {
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;
      final savedUser = authController.currentUser.value;

      if (userId == null || savedUser == null) return null;
      if (savedUser.currentLatitude == null ||
          savedUser.currentLongitude == null) {
        return null;
      }

      final currentPos = await getCurrentPosition();
      if (currentPos == null) return null;

      final distance =
          Geolocator.distanceBetween(
            savedUser.currentLatitude!,
            savedUser.currentLongitude!,
            currentPos.latitude,
            currentPos.longitude,
          ) /
          1000; // Convert to km

      return distance;
    } catch (e) {
      print('[LocationService] Error checking mismatch: $e');
      return null;
    }
  }
}
