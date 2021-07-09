import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationState extends ChangeNotifier {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  StreamSubscription<QuerySnapshot>? _initialPositionSubs;
  CollectionReference locList =
      FirebaseFirestore.instance.collection('location');

  Future<void> addActivitytoDatabase(LatLng initialCameraposition) {
    // State here to track either google login or local login
    // Local login = email, name, password
    // When Start button clicked, we add initial latitude ad longitude to Firestore
    return FirebaseFirestore.instance.collection('location').add({
      'name': FirebaseAuth.instance.currentUser?.displayName,
      'latitude': initialCameraposition.latitude,
      'longitude': initialCameraposition.longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'isActivity': 'yes',
    });
  }

  Future<LatLng?> fetchInitialLocation() async {
    LatLng? firstPos;
    try {
      //   locList.get().then(
      //         (value) => value.docs.forEach(
      //           (element) {
      //             firstPos =
      //                 new LatLng(element["latitude"], element["longitude"]);
      //           },
      //         ),
      //       );
      await locList
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                //print(element.data());
                firstPos =
                    new LatLng(element["latitude"], element["longitude"]);
              },
            ),
          );
      return firstPos;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // getInit() async {
  //   LatLng? userInit = fetchInitialLocation();
  //   return userInit;
  // }
}

// .orderBy("timestamp", descending: true)
//           .limit(1)
//           .docs

// return FirebaseFirestore.instance
//         .collection('Location')
//         .doc(firebaseUser?.uid)
//         .set({
//       'name': FirebaseAuth.instance.currentUser?.displayName,
//       'latitude': initialCameraposition.latitude,
//       'longitude': initialCameraposition.longitude,
//       'timestamp': DateTime.now().millisecondsSinceEpoch,
//       'userId': FirebaseAuth.instance.currentUser?.uid,
//       'isActivity': 'true',
//     }).then((value) => print("Hey"));

// .then(
//             (value) => value.docs.forEach((element) {
//               print(element.data());
//               firstPos = new LatLng(element["latitude"], element["longitude"]);
//             }),
