import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../core/controllers/map_controller.dart';

/// Reusable Google Maps Widget for Awhar
class AwharMapWidget extends StatelessWidget {
  final MapController? controller;
  final CameraPosition initialPosition;
  final MapType mapType;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool compassEnabled;
  final bool mapToolbarEnabled;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool zoomGesturesEnabled;
  final Function(LatLng)? onTap;
  final Function(LatLng)? onLongPress;
  final EdgeInsets padding;
  final double borderRadius;

  const AwharMapWidget({
    super.key,
    this.controller,
    this.initialPosition = const CameraPosition(
      target: LatLng(33.5731, -7.5898), // Casablanca
      zoom: 12,
    ),
    this.mapType = MapType.normal,
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.zoomControlsEnabled = false,
    this.compassEnabled = true,
    this.mapToolbarEnabled = false,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final mapCtrl = controller ?? Get.find<MapController>();

    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: GoogleMap(
          mapType: mapType,
          initialCameraPosition: initialPosition,
          myLocationEnabled: myLocationEnabled,
          myLocationButtonEnabled: myLocationButtonEnabled,
          zoomControlsEnabled: zoomControlsEnabled,
          compassEnabled: compassEnabled,
          mapToolbarEnabled: mapToolbarEnabled,
          rotateGesturesEnabled: rotateGesturesEnabled,
          scrollGesturesEnabled: scrollGesturesEnabled,
          tiltGesturesEnabled: tiltGesturesEnabled,
          zoomGesturesEnabled: zoomGesturesEnabled,
          padding: padding,
          markers: Set<Marker>.of(mapCtrl.markers.values),
          polylines: Set<Polyline>.of(mapCtrl.polylines.values),
          circles: Set<Circle>.of(mapCtrl.circles.values),
          onMapCreated: mapCtrl.onMapCreated,
          onTap: onTap,
          onLongPress: onLongPress,
          onCameraMove: (position) {
            mapCtrl.currentCameraPosition.value = position;
          },
        ),
      ),
    );
  }
}
