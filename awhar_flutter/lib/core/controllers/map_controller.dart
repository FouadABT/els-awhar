import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

/// Controller for managing Google Maps state and operations
class MapController extends GetxController {
  final LocationService _locationService = Get.find<LocationService>();

  // Map controller
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  // Map state
  final Rx<CameraPosition> currentCameraPosition = Rx<CameraPosition>(
    const CameraPosition(
      target: LatLng(33.5731, -7.5898), // Casablanca, Morocco
      zoom: 12,
    ),
  );

  // Markers
  final RxMap<String, Marker> markers = <String, Marker>{}.obs;

  // Polylines (routes)
  final RxMap<String, Polyline> polylines = <String, Polyline>{}.obs;

  // Circles (areas)
  final RxMap<String, Circle> circles = <String, Circle>{}.obs;

  // UI State
  final RxBool isLoading = false.obs;
  final RxBool isMapReady = false.obs;
  final RxString selectedMarkerId = ''.obs;

  // Pickup and destination
  final Rx<LatLng?> pickupLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);
  final RxString pickupAddress = ''.obs;
  final RxString destinationAddress = ''.obs;

  /// Initialize map when created
  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    isMapReady.value = true;
    _setMapStyle();
  }

  /// Set custom map style
  Future<void> _setMapStyle() async {
    try {
      final isDark = Get.isDarkMode;
      if (isDark) {
        // You can add custom dark mode style JSON here
        // await mapController.value?.setMapStyle(darkMapStyle);
      }
    } catch (e) {
      print('Error setting map style: $e');
    }
  }

  /// Move camera to position with animation
  Future<void> moveCamera(
    LatLng position, {
    double zoom = 15,
    bool animate = true,
  }) async {
    if (mapController.value == null) return;

    final cameraPosition = CameraPosition(
      target: position,
      zoom: zoom,
    );

    if (animate) {
      await mapController.value!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    } else {
      await mapController.value!.moveCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    }

    currentCameraPosition.value = cameraPosition;
  }

  /// Move camera to current location
  Future<void> moveToCurrentLocation() async {
    isLoading.value = true;

    final position = await _locationService.getCurrentPosition();

    if (position != null) {
      await moveCamera(
        LatLng(position.latitude, position.longitude),
        zoom: 16,
      );

      // Add current location marker
      addMarker(
        id: 'current_location',
        position: LatLng(position.latitude, position.longitude),
        title: 'Your Location',
        snippet: 'You are here',
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }

    isLoading.value = false;
  }

  /// Add marker to map
  void addMarker({
    required String id,
    required LatLng position,
    String? title,
    String? snippet,
    BitmapDescriptor? icon,
    VoidCallback? onTap,
    bool draggable = false,
    double? rotation,
  }) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: title ?? '',
        snippet: snippet ?? '',
      ),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      onTap: onTap,
      draggable: draggable,
      rotation: rotation ?? 0,
      onDragEnd: (newPosition) {
        if (id == 'pickup') {
          pickupLocation.value = newPosition;
          _updateAddress(newPosition, isPickup: true);
        } else if (id == 'destination') {
          destinationLocation.value = newPosition;
          _updateAddress(newPosition, isPickup: false);
        }
      },
    );

    markers[id] = marker;
  }

  /// Remove marker from map
  void removeMarker(String id) {
    markers.remove(id);
  }

  /// Clear all markers
  void clearMarkers() {
    markers.clear();
  }

  /// Add polyline (route) to map
  void addPolyline({
    required String id,
    required List<LatLng> points,
    Color? color,
    double width = 5,
  }) {
    final polyline = Polyline(
      polylineId: PolylineId(id),
      points: points,
      color: color ?? Colors.blue,
      width: width.toInt(),
      geodesic: true,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    polylines[id] = polyline;
  }

  /// Remove polyline from map
  void removePolyline(String id) {
    polylines.remove(id);
  }

  /// Clear all polylines
  void clearPolylines() {
    polylines.clear();
  }

  /// Add circle (area) to map
  void addCircle({
    required String id,
    required LatLng center,
    double radius = 1000, // meters
    Color? fillColor,
    Color? strokeColor,
    double strokeWidth = 2,
  }) {
    final circle = Circle(
      circleId: CircleId(id),
      center: center,
      radius: radius,
      fillColor: (fillColor ?? Colors.blue).withOpacity(0.2),
      strokeColor: strokeColor ?? Colors.blue,
      strokeWidth: strokeWidth.toInt(),
    );

    circles[id] = circle;
  }

  /// Remove circle from map
  void removeCircle(String id) {
    circles.remove(id);
  }

  /// Clear all circles
  void clearCircles() {
    circles.clear();
  }

  /// Set pickup location
  Future<void> setPickupLocation(LatLng location) async {
    pickupLocation.value = location;

    addMarker(
      id: 'pickup',
      position: location,
      title: 'Pickup Location',
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      draggable: true,
    );

    await _updateAddress(location, isPickup: true);
    await moveCamera(location);
  }

  /// Set destination location
  Future<void> setDestinationLocation(LatLng location) async {
    destinationLocation.value = location;

    addMarker(
      id: 'destination',
      position: location,
      title: 'Destination',
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
    );

    await _updateAddress(location, isPickup: false);

    // If both pickup and destination are set, show both on map
    if (pickupLocation.value != null) {
      await fitBounds([pickupLocation.value!, location]);
    } else {
      await moveCamera(location);
    }
  }

  /// Update address from coordinates
  Future<void> _updateAddress(LatLng location, {required bool isPickup}) async {
    final address = await _locationService.getAddressFromCoordinates(location);
    if (address != null) {
      if (isPickup) {
        pickupAddress.value = address;
      } else {
        destinationAddress.value = address;
      }
    }
  }

  /// Fit map bounds to show all markers
  Future<void> fitBounds(List<LatLng> points) async {
    if (mapController.value == null || points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    await mapController.value!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100), // 100px padding
    );
  }

  /// Clear pickup location
  void clearPickup() {
    pickupLocation.value = null;
    pickupAddress.value = '';
    removeMarker('pickup');
  }

  /// Clear destination location
  void clearDestination() {
    destinationLocation.value = null;
    destinationAddress.value = '';
    removeMarker('destination');
  }

  /// Clear all trip data
  void clearTrip() {
    clearPickup();
    clearDestination();
    clearPolylines();
    clearCircles();
  }

  @override
  void onClose() {
    mapController.value?.dispose();
    super.onClose();
  }
}
