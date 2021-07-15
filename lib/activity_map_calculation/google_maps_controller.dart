import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Initials

// Declarations
LatLng? initialCameraposition;
Location location = new Location();

// void onGeoChanged(CameraPosition position) {
//   print("position: " + position.target.toString());
//   print("zoom: " + position.zoom.toString());
//   //getZoomLevel(position.zoom);
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
  //print("${_locationData.latitude} and ${_locationData.longitude}");
  return _locationData;
}

void messageHandler(int state) {
  if (state == 1) {
    print("Successfully Done on Listening Map!");
  }
}

setLoc() async {
  LocationData loc = await getLoc();
  //print("initialv1: $initialCameraposition");
  initialCameraposition = LatLng(loc.latitude ?? 0.56, loc.longitude ?? 0.96);
  //print("initialv2: $initialCameraposition");
}

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
