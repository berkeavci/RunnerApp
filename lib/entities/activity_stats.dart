import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class ActivityStats {
  String userId;
  double kcal;
  int step;
  double km;
  double averagespeed;
  String time;
  DateTime date;
  List<String> coordinates;

  ActivityStats(this.userId, this.kcal, this.step, this.km, this.averagespeed,
      this.time, this.date, this.coordinates);

  Map<String, dynamic> get map {
    return {
      "userId": userId,
      "kcal": kcal,
      "step": step,
      "km": km,
      "averagespeed": averagespeed,
      "time": time,
      "date": date,
      "coordinate": coordinates,
    };
  }

  static List<String> toList1(List<LatLng> coords) {
    List<String> points1 = [];
    coords.forEach((item) {
      points1.add("${item.latitude},${item.longitude}");
    });
    return points1.toList();
  }

  static DateTime dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  static String toDay(DateTime dt) {
    return DateFormat('EEEE').format(dt).toString();
  }

  static String toDate(DateTime dt) {
    return DateFormat('M/d/y').format(dt).toString();
  }

  static List<LatLng> stringtoLatLng(List<String> list) {
    List<String> latlong = [];
    List<LatLng> listLatLong = [];

    list.forEach((element) {
      latlong = element.split(",");
      listLatLong
          .add(new LatLng(double.parse(latlong[0]), double.parse(latlong[1])));
    });
    return listLatLong;
  }

  static List<String> dynamictoStringList(List<dynamic> l) {
    return l.map((e) => e as String).toList();
  }
}
