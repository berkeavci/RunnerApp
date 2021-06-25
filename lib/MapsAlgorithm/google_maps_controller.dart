import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Initials

// Declarations
GoogleMapController? _controller;
late LatLng initialCameraposition = LatLng(0.59, 0.96);
Location location = new Location();

void onGeoChanged(CameraPosition position) {
  print("position: " + position.target.toString());
  print("zoom: " + position.zoom.toString());
  //getZoomLevel(position.zoom);
}

// double getZoomLevel(double zoom) {
//   return zoomL;
// }

// When Map created, either give default value or change CameraPosition according to move.
void onMapCreated(GoogleMapController cntr) {
  _controller = cntr; // get mapcontroller
  location.onLocationChanged.listen((l) {
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(l.latitude ?? 0.59, l.longitude ?? 0.96),
        ),
      ),
    );
    //print("${l.latitude}" + "${l.longitude}");
  });

  //LocationData loc = getLoc();
  //print(loc.toString());
  //print("${loc.latitude} + ${loc.longitude}");
  location.toString();
}

// location getter / Location package
getLoc() async {
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

  LocationData _locationData = await location.getLocation();
  print("Hello?");
  return _locationData;
}

void messageHandler(int state) {
  if (state == 1) {
    print("Successfully Done on Listening Map!");
  }
}

setLoc() async {
  LocationData loc = getLoc();
  initialCameraposition = LatLng(loc.latitude ?? 0.56, loc.longitude ?? 0.96);
  return initialCameraposition;
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
