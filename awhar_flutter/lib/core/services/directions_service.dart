import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

/// Service for Google Directions API integration
class DirectionsService extends GetxService {
  // TODO: Replace with your actual Google Maps API key
  static const String _apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  
  final PolylinePoints _polylinePoints = PolylinePoints();
  
  /// Get route between two locations
  Future<DirectionsResult?> getDirections({
    required LatLng origin,
    required LatLng destination,
    TravelMode travelMode = TravelMode.driving,
  }) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=${_getTravelModeString(travelMode)}'
        '&key=$_apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final leg = route['legs'][0];

          // Extract polyline points
          final polylineString = route['overview_polyline']['points'];
          final decodedPoints = _polylinePoints.decodePolyline(polylineString);
          
          final polylineCoordinates = decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          return DirectionsResult(
            polylinePoints: polylineCoordinates,
            distance: leg['distance']['value'] / 1000, // Convert to km
            distanceText: leg['distance']['text'],
            duration: leg['duration']['value'] / 60, // Convert to minutes
            durationText: leg['duration']['text'],
            startAddress: leg['start_address'],
            endAddress: leg['end_address'],
          );
        } else {
          print('[DirectionsService] API returned status: ${data['status']}');
          return null;
        }
      } else {
        print('[DirectionsService] HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('[DirectionsService] Error getting directions: $e');
      return null;
    }
  }

  /// Create a polyline from directions result
  Polyline createPolyline({
    required String polylineId,
    required List<LatLng> points,
    Color color = Colors.blue,
    double width = 5,
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: width.toInt(),
      geodesic: true,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    );
  }

  /// Get ETA text from minutes
  String getETAText(double minutes) {
    if (minutes < 1) {
      return 'Less than 1 min';
    } else if (minutes < 60) {
      return '${minutes.round()} min';
    } else {
      final hours = (minutes / 60).floor();
      final mins = (minutes % 60).round();
      return '$hours hr ${mins > 0 ? '$mins min' : ''}';
    }
  }

  /// Get distance text from km
  String getDistanceText(double km) {
    if (km < 1) {
      return '${(km * 1000).round()} m';
    } else {
      return '${km.toStringAsFixed(1)} km';
    }
  }

  String _getTravelModeString(TravelMode mode) {
    switch (mode) {
      case TravelMode.driving:
        return 'driving';
      case TravelMode.walking:
        return 'walking';
      case TravelMode.bicycling:
        return 'bicycling';
      case TravelMode.transit:
        return 'transit';
    }
  }
}

/// Travel mode enum
enum TravelMode {
  driving,
  walking,
  bicycling,
  transit,
}

/// Directions result model
class DirectionsResult {
  final List<LatLng> polylinePoints;
  final double distance; // in km
  final String distanceText;
  final double duration; // in minutes
  final String durationText;
  final String startAddress;
  final String endAddress;

  DirectionsResult({
    required this.polylinePoints,
    required this.distance,
    required this.distanceText,
    required this.duration,
    required this.durationText,
    required this.startAddress,
    required this.endAddress,
  });
}
