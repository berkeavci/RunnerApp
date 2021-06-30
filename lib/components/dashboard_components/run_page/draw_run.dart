import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';

bool isStarted = false;

class DrawRunPage extends StatefulWidget {
  DrawRunPage({Key? key}) : super(key: key);

  @override
  _DrawRunPageState createState() => _DrawRunPageState();
}

class _DrawRunPageState extends State<DrawRunPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          GoogleMapsView(),
          SizedBox(
            height: 100,
          ),
          activityStartButton(context),
        ],
      ),
    );
  }
}

@override
Widget activityStartButton(BuildContext context) {
  return Column(
    children: [],
  );
}
