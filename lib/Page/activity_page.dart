import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';
import 'package:runner/components/activity_components/map.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            // Swiped right
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrawMap(
                        initialPosition: initialCameraposition ?? LatLng(0, 0),
                      )),
            );
          } else if (details.delta.dx > 0) {
            // Statistic Page

          }
        },
      ),
    );
  }
}
