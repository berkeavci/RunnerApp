import 'package:runner/MapsAlgorithm/google_maps_controller.dart';
import 'package:flutter/material.dart';
import '../../components/dashboard_components/dashboard_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runner/components/dashboard_components/google_maps_view.dart';
import 'package:runner/components/dashboard_components/profile_page.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';

// var user = FirebaseAuth.instance.currentUser;

// // Constants
// int _selectedIndex = 0;
// // static const TextStyle optionStyle =
// //     TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
// static List<Widget> _widgetOptions = <Widget>[
//   GoogleMapsView(), // GoogleMapsView()
//   GoogleMapsView(),
//   UserProfile(),
// ];

// @override
// Widget build(BuildContext context) => Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         color: Colors.white,
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedLabelStyle: TextStyle(fontSize: 18, shadows: [
//           Shadow(
//             color: Colors.red,
//             offset: Offset.infinite,
//           ),
//         ]),
//         backgroundColor: Colors.amber[50],
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.run_circle_outlined),
//             label: 'Run!',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.red,
//         onTap: (index) {

//             _selectedIndex = index;

//         },
//       ),
//     );
