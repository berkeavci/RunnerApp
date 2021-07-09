import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/activity_map_calculation/google_maps_controller.dart';
import 'package:runner/Page/activity_page.dart';

BitmapDescriptor? runnerIcon;

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({Key? key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  double? zoomL = 10.0;
  GoogleMapController? _cont;

  final Future<LatLng?> _dynamicLocationLoad = Future<LatLng?>.delayed(
    const Duration(seconds: 2),
    () => initialCameraposition,
  );

  @override
  void initState() {
    super.initState();
    setLoc();
  }

  @override
  void dispose() {
    super.dispose();
    _cont?.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder<LatLng?>(
              // ignore: non_constant_identifier_names
              future: _dynamicLocationLoad,
              builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 400,
                      width: 450,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: initialCameraposition ?? LatLng(0, 0),
                              zoom: 19.0),
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          onMapCreated: (map) async {
                            _cont = map;
                            await createMarkerImageFromAsset(context);
                            setState(() {});
                            location.onLocationChanged.listen((event) {});
                          },
                          //onCameraMove: onGeoChanged,
                          markers: createMarker(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        onSurface: Colors.white,
                        shape: CircleBorder(),
                        primary: Colors.white,
                      ),
                      icon: Image.asset(
                        './assets/images/start_running.png',
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                      label: Text(''),
                      onPressed: () async {
                        await ApplicationState().addActivitytoDatabase(
                            initialCameraposition ?? LatLng(0, 0));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      // Record the
                    ),
                  ];
                } else {
                  children = <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Wait! We are preparing your map ',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.white,
                        alignment: Alignment(0, 0),
                      ),
                      icon: Image.asset(
                        './assets/images/start_running.png',
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                      label: Text(''),
                      onPressed: () async {
                        await ApplicationState().addActivitytoDatabase(
                            initialCameraposition ?? LatLng(0, 0));
                        ActivityPage();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      // Record the
                    ),
                  ];
                }
                return Container(
                  height: 900,
                  width: 380,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ],
        ),
      );
}

//  Future.delayed(Duration(seconds: 2), () {
//             map.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
// return Container(
//         child: CircularProgressIndicator(
//           color: Colors.black,
//         ),
//       );

Future<void> createMarkerImageFromAsset(BuildContext context) async {
  final ImageConfiguration imageConf = createLocalImageConfiguration(context);
  var bitmap = await BitmapDescriptor.fromAssetImage(
      imageConf, './assets/images/runner_marker.png',
      mipmaps: false);
  runnerIcon = bitmap;
}

Set<Marker> createMarker() {
  return {
    Marker(
      markerId: MarkerId("marker_1"),
      position: initialCameraposition ?? LatLng(0, 0),
      infoWindow: InfoWindow(title: 'Runner'),
      icon: runnerIcon ?? BitmapDescriptor.defaultMarker,
    ),
  }.toSet();
}
