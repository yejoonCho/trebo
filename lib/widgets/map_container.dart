import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MapContainer extends StatefulWidget {
  final double latitude;
  final double longitude;
  MapContainer({required this.latitude, required this.longitude});
  @override
  _MapContainer createState() => _MapContainer();
}

class _MapContainer extends State<MapContainer> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? cameraPosition;

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 17,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
