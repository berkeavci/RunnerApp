import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/entities/activity_stats.dart';
import 'dart:core';

import 'package:runner/entities/user.dart';

class ApplicationState extends ChangeNotifier {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  StreamSubscription<QuerySnapshot>? _initialPositionSubs;
  CollectionReference locList =
      FirebaseFirestore.instance.collection('location');
  CollectionReference activityStats =
      FirebaseFirestore.instance.collection('ActivityStats');
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  Future<void> addActivitytoDatabase(
      LatLng initialCameraposition, String isActivity) {
    // State here to track either google login or local login
    // Local login = email, name, password
    // When Start button clicked, we add initial latitude ad longitude to Firestore
    return locList.add(
      {
        'latitude': initialCameraposition.latitude,
        'longitude': initialCameraposition.longitude,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'userId': firebaseUser?.uid,
        'isActivity': isActivity,
      },
    );
  }

  Future<LatLng?> fetchActivityLocationHolder() async {
    LatLng? firstPos;
    try {
      await locList
          .where("userId", isEqualTo: firebaseUser?.uid)
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

  Future<void> addActivityStatstoDatabase(
      double kcal, int step, double km, double averagespeed, String time) {
    return activityStats.add(
      {
        'userId': firebaseUser?.uid,
        'kcal': kcal,
        'step': step,
        'km': km,
        'averagespeed': averagespeed,
        'time': time,
        'date': DateTime.now(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<List<ActivityStats>?> fetchActivityInfo() async {
    List<ActivityStats>? activityS = <ActivityStats>[];
    try {
      await activityStats
          .where("userId", isEqualTo: firebaseUser?.uid)
          .orderBy("timestamp", descending: true)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                activityS.add(
                  new ActivityStats(
                    element["userId"],
                    element["kcal"],
                    element["step"],
                    element["km"],
                    element["averagespeed"],
                    element["time"],
                    ActivityStats.dateTimeFromTimestamp(element["date"]),
                  ),
                );
              },
            ),
          );
      return activityS;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addUsertoDatabase(String? name) {
    return userCollection.add(
      {
        'userId': firebaseUser?.uid,
        'name': firebaseUser?.displayName ?? name,
        'email': firebaseUser?.email,
        'about': "",
        'weight': 70,
      },
    );
  }

  Future<UserInformations?> fetchUserInformation() async {
    UserInformations? user;
    try {
      await userCollection
          .where("userId", isEqualTo: firebaseUser?.uid)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                user = new UserInformations(
                  element["weight"],
                  element["name"],
                  element["email"],
                  element["about"],
                  element["userId"],
                );
              },
            ),
          );
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
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
