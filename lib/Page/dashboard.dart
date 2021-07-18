import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:runner/Page/activity_history_page.dart';
import 'package:runner/Page/leaderboard_page.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';
import 'package:runner/components/dashboard_components/profile_page.dart';

// Application DashBoard Page
class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ActivityHistoryPage(),
    GoogleMapsView(),
    LeaderBoardPage(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 18, shadows: [
            Shadow(
              color: Colors.red.shade800,
              offset: Offset.infinite,
            ),
          ]),
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.amber[100]?.withOpacity(0.85),
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.amber[100]?.withOpacity(0.85),
              icon: Icon(
                Icons.run_circle_outlined,
              ),
              label: 'Run!',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.amber[100]?.withOpacity(0.85),
              icon: Icon(MdiIcons.chartBar),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.amber[100]?.withOpacity(0.85),
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red.shade400,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );
}
