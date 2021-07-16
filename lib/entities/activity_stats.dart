import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ActivityStats {
  String userId;
  double kcal;
  int step;
  double km;
  double averagespeed;
  String time;
  DateTime date;

  ActivityStats(this.userId, this.kcal, this.step, this.km, this.averagespeed,
      this.time, this.date);
  Map<String, dynamic> get map {
    return {
      "userId": userId,
      "kcal": kcal,
      "step": step,
      "km": km,
      "averagespeed": averagespeed,
      "time": time,
      "date": date,
    };
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
}
