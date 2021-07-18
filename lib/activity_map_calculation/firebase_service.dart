import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/entities/activity_stats.dart';
import 'dart:core';

import 'package:runner/entities/user.dart';
import 'package:runner/entities/userLeaderboard.dart';

class ApplicationState extends ChangeNotifier {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference locList =
      FirebaseFirestore.instance.collection('location');
  CollectionReference activityStats =
      FirebaseFirestore.instance.collection('ActivityStats');
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  CollectionReference userLeaderboardCollection =
      FirebaseFirestore.instance.collection('Leaderboard');

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

  Future<void> addActivityStatstoDatabase(double kcal, int step, double km,
      double averagespeed, String time, List<LatLng> totalPos) {
    print("${totalPos.toString()}");
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
        'coordinates': ActivityStats.toList1(totalPos),
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
                    ActivityStats.dateTimeFromTimestamp(
                      element["date"],
                    ),
                    ActivityStats.dynamictoStringList(element["coordinates"]),
                  ),
                );
              },
            ),
          );
      print(ActivityStats.stringtoLatLng(activityS[0].map["coordinate"]));
      return activityS;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UserLeaderboard>?> fetchUserLeaderboard() async {
    List<UserLeaderboard>? userL = <UserLeaderboard>[];
    // UserLeaderboard.intToDouble(element["totalDistancebyKm"])
    try {
      await userLeaderboardCollection
          .orderBy("totalDistancebyKm", descending: true)
          .get()
          .then(
            (value) => value.docs.forEach((element) {
              userL.add(new UserLeaderboard(element["userId"], element["name"],
                  element["totalDistancebyKm"]));
            }),
          )
          .onError((error, stackTrace) => print("${error.toString()}"));
      return userL;
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<void> addUsertoDatabase(String? name) {
    return userCollection.add(
      {
        'userId': firebaseUser?.uid,
        'name': name,
        'email': firebaseUser?.email,
        'about': "",
        'weight': 70,
      },
    );
  }

  Future<void> addUserLeaderboardInfo(String? name) {
    double distance = 0.0;
    return userLeaderboardCollection.add(
      {
        'userId': firebaseUser?.uid,
        'name': name,
        'totalDistancebyKm': distance,
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

  Future<void> updateUserInfo(
      String name, String weight, String aboutMe) async {
    int userWeight = int.tryParse(weight) ?? 70;
    List<QueryDocumentSnapshot<Object?>> userDoc = [];
    await userCollection
        .where("userId", isEqualTo: firebaseUser?.uid)
        .get()
        .then((value) {
      userDoc = value.docs.toList();
    });
    userCollection.doc(userDoc.first.id).update({
      'name': name,
      'weight': userWeight,
      'about': aboutMe,
    }).onError((error, stackTrace) => print("${error.toString()}"));
  }

  Future<void> updateLeaderboard(double dist) async {
    List<QueryDocumentSnapshot<Object?>> userLeaderboardDoc = [];
    await userLeaderboardCollection
        .where("userId", isEqualTo: firebaseUser?.uid)
        .get()
        .then((value) {
      dist += (value.docs.first.data() as Map)["totalDistancebyKm"];
      userLeaderboardDoc = value.docs.toList();
      print(userLeaderboardDoc[0].id);
    });
    userLeaderboardCollection.doc(userLeaderboardDoc[0].id).update({
      'totalDistancebyKm': dist,
    }).onError((error, stackTrace) => print("${error.toString()}"));
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
