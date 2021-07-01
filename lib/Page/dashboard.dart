import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/components/dashboard_components/dashboard_.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';
import 'package:runner/components/dashboard_components/profile_page.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';
import 'package:runner/components/dashboard_components/run_page/draw_run.dart';

// Application DashBoard Page
class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var user = FirebaseAuth.instance.currentUser;

  // Constants
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    GoogleMapsView(), // GoogleMapsView()
    GoogleMapsView(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(20),
          color: Colors.white,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 18, shadows: [
            Shadow(
              color: Colors.red,
              offset: Offset.infinite,
            ),
          ]),
          backgroundColor: Colors.amber[50],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined),
              label: 'Run!',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );
}
