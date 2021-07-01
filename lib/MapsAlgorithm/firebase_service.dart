import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/MapsAlgorithm/google_maps_controller.dart';

class ApplicationState extends ChangeNotifier {
  // Addition to collection
  Future<DocumentReference> addActivitytoDatabase(
      LatLng initialCameraposition) {
    // State here to track either google login or local login
    // Local login = email, name, password
    // When Start button clicked, we add initial latitude ad longitude to Firestore
    return FirebaseFirestore.instance.collection('location').add({
      'name': FirebaseAuth.instance.currentUser?.displayName,
      'latitude': initialCameraposition.latitude,
      'longitude': initialCameraposition.longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser?.uid,
    });
  }
}
