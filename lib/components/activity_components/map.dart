import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lt;
import 'package:runner/activity_map_calculation/google_maps_controller.dart';
import 'package:runner/activity_map_calculation/stat_calculations.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

class DrawMap extends StatefulWidget {
  final LatLng initialPosition;
  const DrawMap({Key? key, required this.initialPosition}) : super(key: key);

  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  Set<Polyline> polyline = {};
  bool isActivityStarted = true;
  bool isPaused = true;
  bool isMapPage = true;
  GoogleMapController? _controller;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  String googleAPiKey = "AIzaSyD-UTPnkQA4F1OWfq8wFWDneLHdpOs2j3o";

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _getPolyline();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: widget.initialPosition, zoom: 17),
              onMapCreated: onMapCreated,
              markers: createMarker(),
              myLocationButtonEnabled: false,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      polylineCoordinates.clear();
                      setState(() {
                        location.onLocationChanged.listen((event) {}).cancel();
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: const Icon(CupertinoIcons.back, size: 50.0),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    await createMarkerImageFromAsset(context);
    _controller = controller;
    await location.changeSettings(interval: 3000, distanceFilter: 10);
    location.onLocationChanged.listen(
      (event) {
        if (mounted) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(event.latitude ?? 0.59, event.longitude ?? 0.96),
                zoom: 17,
              ),
            ),
          );
          if (isDistanceEnough()) {
            createMarker();
          }
          setLoc();

          //print(mounted.toString());
          _getPolyline();
        }
      },
    );
  }

  // Polyline addition to map
  _addPolyLine() {
    if (mounted && isDistanceEnough()) {
      //print(mounted.toString());
      setState(() {
        PolylineId id = PolylineId("poly");
        Polyline polyline = Polyline(
            polylineId: id, color: Colors.black, points: polylineCoordinates);
        polylines[id] = polyline;
      });
    }
  }

  // getLoc().then((value) => widget.initialPosition.latitude = value.latitude)

  Future<void> _getPolyline() async {
    if (isActivityStarted && isPaused) {
      PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(
            widget.initialPosition.latitude, widget.initialPosition.longitude),
        PointLatLng(initialCameraposition?.latitude ?? 1,
            initialCameraposition?.longitude ?? 1),
      );
      //print(result.points.map((e) => LatLng(e.latitude, e.longitude)).toList());
      // print(
      //     "${widget.initialPosition.latitude} ALSO MY FRIEND ${widget.initialPosition.longitude}");
      // print(
      //     "${initialCameraposition?.latitude} DYNAIOC? ${initialCameraposition?.longitude}");
      if (result.status == 'OK') {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.status);
      }
      _addPolyLine();
    }
  }

  bool isDistanceEnough() {
    Calculations method = new Calculations();
    if (polylineCoordinates.length > 1) {
      print(polylineCoordinates.toString());
      double meter = method.getDistance(
        new lt.LatLng(
            initialCameraposition?.latitude, initialCameraposition?.longitude),
        new lt.LatLng(polylineCoordinates.last.latitude,
            polylineCoordinates.last.longitude),
      );
      print(polylineCoordinates[polylineCoordinates.length - 2].toString());
      print(polylineCoordinates.last.toString());
      if (meter > 5.0) {
        print(meter);
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
