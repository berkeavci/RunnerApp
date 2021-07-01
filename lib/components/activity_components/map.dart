import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

class DrawMap extends StatefulWidget {
  final LatLng initialPosition;
  const DrawMap({Key? key, required this.initialPosition}) : super(key: key);

  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: widget.initialPosition, zoom: 20),
            onMapCreated: (map) async {
              await createMarkerImageFromAsset(context);
              setState(() {});
            },
            markers: createMarker(),
            myLocationButtonEnabled: false,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
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
    );
  }
}
