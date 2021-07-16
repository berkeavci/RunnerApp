import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/activity_map_calculation/google_maps_controller.dart';
import 'package:runner/Page/activity_page.dart';

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({Key? key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  double? zoomL = 10.0;
  GoogleMapController? _cont;
  BitmapDescriptor? runnerIcon;

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
                      margin: EdgeInsets.only(left: 15),
                      height: 400,
                      width: 470,
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
                            setState(() {
                              createMarkerImageFromAsset(context).then((value) {
                                runnerIcon = value;
                              });
                            });
                            location.onLocationChanged.listen((event) {});
                          },
                          //onCameraMove: onGeoChanged,
                          markers: createMarker(
                              runnerIcon ?? BitmapDescriptor.defaultMarker),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ActivityStartButton(),
                  ];
                } else {
                  children = <Widget>[
                    SizedBox(
                      width: 15,
                    ),
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
                      height: 50,
                    ),
                    ActivityStartButton(),
                  ];
                }
                return Container(
                  height: 700,
                  width: 400,
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

class ActivityStartButton extends StatelessWidget {
  const ActivityStartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Colors.white,
        alignment: Alignment(0, 0),
      ),
      icon: Image.asset(
        './assets/images/start_running.png',
        height: 100,
        width: 100,
        color: Colors.red.shade400,
      ),
      label: Text(''),
      onPressed: () async {
        await ApplicationState().addActivitytoDatabase(
            initialCameraposition ?? LatLng(0, 0), "true");
        _navigateAndDisplaySelection(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ActivityPage(),
        //     fullscreenDialog: true,
        //   ),
        // );
      },
    );
  }
}

// Navigation Area
void _navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ActivityPage()),
  );
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$result')));
}

// Custom Market
Future<BitmapDescriptor> createMarkerImageFromAsset(BuildContext context) {
  final ImageConfiguration imageConf = createLocalImageConfiguration(context);
  return BitmapDescriptor.fromAssetImage(
    imageConf,
    'assets/images/runner_marker.bmp',
    mipmaps: false,
  );
}

// Marker Creation
Set<Marker> createMarker(BitmapDescriptor bitmap) {
  return {
    Marker(
      markerId: MarkerId("marker_1"),
      position: initialCameraposition ?? LatLng(0, 0),
      infoWindow: InfoWindow(title: 'Runner'),
      icon: bitmap,
    ),
  }.toSet();
}
