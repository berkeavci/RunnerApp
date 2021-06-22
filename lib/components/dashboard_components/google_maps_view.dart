import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Constants

final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414);

final CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

// Google Maps View

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({Key? key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 400,
      width: 400,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kLake,
        onMapCreated: (map) {
          Future.delayed(Duration(seconds: 2), () {
            map.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
          });
        },
      ),
    );
  }
}
