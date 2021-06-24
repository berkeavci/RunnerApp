import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';

// Constants

final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414);

Set<Marker> _createMarker() {
  return {
    // Marker(
    //     markerId: MarkerId("marker_1"),
    //     position: _kMapCenter,
    //     infoWindow: InfoWindow(title: 'Marker 1'),
    //     rotation: 90),
  };
}

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({Key? key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  double? zoomL = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.only(left: 10.0),
      height: 450,
      width: 380,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition:
              CameraPosition(target: initialCameraposition, zoom: 10.0),
          zoomGesturesEnabled: true,
          onMapCreated: onMapCreated,
          myLocationEnabled: true,
          onCameraMove: onGeoChanged,
        ),
      ),
    );
  }
}

//  Future.delayed(Duration(seconds: 2), () {
//             map.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
