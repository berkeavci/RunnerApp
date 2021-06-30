import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

// Initials

// Declarations
GoogleMapController? _controller;
LatLng? initialCameraposition;
Location location = new Location();

// void onGeoChanged(CameraPosition position) {
//   print("position: " + position.target.toString());
//   print("zoom: " + position.zoom.toString());
//   //getZoomLevel(position.zoom);
// }

// // When Map created, either give default value or change CameraPosition according to move.
// Future<void> onMapCreated(GoogleMapController cntr, BuildContext ct) async {
//   await createMarkerImageFromAsset(ct);
//   _controller = cntr; // get mapcontroller
//   location.onLocationChanged.listen((l) {
//     print(" Inside of Conroller: ${l.latitude} and ${l.longitude}");
//     // _controller?.animateCamera(
//     //   CameraUpdate.newCameraPosition(
//     //     CameraPosition(
//     //       target: LatLng(l.latitude ?? 0.59, l.longitude ?? 0.96),
//     //       zoom: 19,
//     //     ),
//     //   ),
//     // );
//   });
// }

// location getter / Location package
serviceReady() async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
}

Future<LocationData> getLoc() async {
  LocationData _locationData = await location.getLocation();
  print("${_locationData.latitude} and ${_locationData.longitude}");
  return _locationData;
}

void messageHandler(int state) {
  if (state == 1) {
    print("Successfully Done on Listening Map!");
  }
}

setLoc() async {
  LocationData loc = await getLoc();
  print("initialv1: $initialCameraposition");
  initialCameraposition = LatLng(loc.latitude ?? 0.56, loc.longitude ?? 0.96);
  print("initialv2: $initialCameraposition");
}

// getMarker() async {

// }

listenMap() async {
  location.onLocationChanged.listen((LocationData currentLocationData) {
    List<double> positions = [];
    positions.add(currentLocationData.longitude ?? 0.0);
    // Display Location
    // print("Latitude ${currentLocationData.latitude} " +
    //    "Longtitude ${currentLocationData.longitude}");

    // Current datetime to store, display etc.
    String _datetime = DateFormat('EEE d MMM kk:mm:ss ').format(DateTime.now());
  }).onDone(() => messageHandler(1));
}

// Stop Requesting location
// Rewrite Here
