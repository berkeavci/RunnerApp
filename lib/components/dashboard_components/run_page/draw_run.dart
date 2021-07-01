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
    return Container(
      child: Column(
        children: [
          GoogleMapsView(),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
