import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lt;
import 'package:runner/activity_map_calculation/google_maps_controller.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

class DrawMap extends StatefulWidget {
  final List<LatLng> coordinates;
  const DrawMap({Key? key, required this.coordinates}) : super(key: key);

  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  List<LatLng> pointsLatLng = <LatLng>[];
  Set<Polyline> polyline = {};
  bool isActivityStarted = true;
  bool isPaused = true;
  bool isMapPage = true;
  GoogleMapController? _controller;
  BitmapDescriptor? runnerIcon;

  Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // String googleAPiKey = "AIzaSyD-UTPnkQA4F1OWfq8wFWDneLHdpOs2j3o";

  @override
  void initState() {
    super.initState();
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
                  CameraPosition(target: widget.coordinates[0], zoom: 17),
              onMapCreated: onMapCreated,
              markers:
                  createMarker(runnerIcon ?? BitmapDescriptor.defaultMarker),
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
    runnerIcon = await createMarkerImageFromAsset(context);
    setState(() {
      createMarker(runnerIcon ?? BitmapDescriptor.defaultMarker);
    });
    _controller = controller;
    await location.changeSettings(interval: 1000, distanceFilter: 3);
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
          // if (isDistanceEnough()) { /
          createMarker(runnerIcon ?? BitmapDescriptor.defaultMarker);
          setLoc();
          _getPolyline();
          setState(() {});
        }
      },
    );
  }

  // Polyline addition to map
  _addPolyLine() {
    if (mounted) {
      //print(mounted.toString());
      setState(() {
        PolylineId id = PolylineId("poly");
        Polyline polyline = Polyline(
            width: 3,
            visible: true,
            polylineId: id,
            color: Colors.red.withOpacity(0.5),
            points: widget.coordinates);
        polylines[id] = polyline;
      });
    }
  }

  Future<void> _getPolyline() async {
    if (initialCameraposition == null) return;
    var pos = initialCameraposition!;
    widget.coordinates.add(LatLng(pos.latitude, pos.longitude));

    _addPolyLine();
  }

  // bool isDistanceEnough() {
  //   Calculations method = new Calculations();
  //   if (polylineCoordinates.length > 1) {
  //     print(polylineCoordinates.toString());
  //     double meter = method.getDistance(
  //       new lt.LatLng(
  //           initialCameraposition?.latitude, initialCameraposition?.longitude),
  //       new lt.LatLng(polylineCoordinates.last.latitude,
  //           polylineCoordinates.last.longitude),
  //     );
  //     print(polylineCoordinates[polylineCoordinates.length - 2].toString());
  //     print(polylineCoordinates.last.toString());
  //     if (meter > 5.0) {
  //       print(meter);
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return true;
  //   }
  // }
}
