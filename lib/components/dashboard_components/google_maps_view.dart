import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';

BitmapDescriptor? runnerIcon;

class GoogleMapsView extends StatefulWidget {
  GoogleMapsView({Key? key}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  double? zoomL = 10.0;

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
  Widget build(BuildContext context) => FutureBuilder<LatLng?>(
        // ignore: non_constant_identifier_names
        future: _dynamicLocationLoad,
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(left: 10.0),
                height: 400,
                width: 400,
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
                      await createMarkerImageFromAsset(context);
                      setState(() {});
                      location.onLocationChanged.listen((event) {
                        // according to the event, listen
                      });
                    },
                    //onCameraMove: onGeoChanged,
                    markers: createMarker(),
                  ),
                ),
              ),

              // new Image(
              //   image: new AssetImage('./assets/images/rocket.gif'),
              // ),
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
                icon: Image.asset('./assets/images/start_activity_button.png'),
                label: Text('hello'),
                onPressed: () {},
              ),
            ];
          }

          return Container(
            height: 400,
            width: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
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
  print(bitmap.toString());
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
