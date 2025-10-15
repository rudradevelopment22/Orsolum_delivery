import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final Function(GoogleMapController)? onMapCreated;
  final CameraPositionCallback? onCameraMove;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final double? zoom;

  const MapWidget({
    super.key,
    required this.initialPosition,
    this.onMapCreated,
    this.onCameraMove,
    this.markers,
    this.polylines,
    this.zoom,
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initialPosition,
          zoom: widget.zoom ?? 15.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        // trafficEnabled: true,
        markers: widget.markers ?? {},
        polylines: widget.polylines ?? {},
        onMapCreated: (controller) {
          _mapController = controller;
          widget.onMapCreated?.call(controller);
        },
        onCameraMove: widget.onCameraMove,
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
