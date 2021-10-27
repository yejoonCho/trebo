import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double screenWidth;
  final double screenHeight;
  DetailMap(
      {required this.latitude,
      required this.longitude,
      required this.screenWidth,
      required this.screenHeight});
  @override
  _DetailMapState createState() => _DetailMapState();
}

class _DetailMapState extends State<DetailMap> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? cameraPosition;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 17,
    );
    _markers.add(Marker(
      markerId: MarkerId("1"),
      draggable: true,
      position: LatLng(widget.latitude, widget.longitude),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: widget.screenWidth,
        height: widget.screenWidth,
        child: GoogleMap(
          mapType: MapType.normal,
          markers: Set.from(_markers),
          initialCameraPosition: cameraPosition!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
