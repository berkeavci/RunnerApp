// ignore: import_of_legacy_library_into_null_safe
import 'package:latlong/latlong.dart' as lt;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:pedometer/pedometer.dart';

class Calculations {
  /// KM Calculation
  getDistance(lt.LatLng initPos, lt.LatLng lastPos) {
    lt.Distance dist = new lt.Distance();
    double m;
    m = dist.as(
        lt.LengthUnit.Meter,
        new lt.LatLng(initPos.latitude, initPos.longitude),
        new lt.LatLng(lastPos.latitude, lastPos.longitude)) as double;

    return m;
  }

  // StopWatch Calculation
  StopWatchTimer getTimer() {
    StopWatchTimer _stopWatchTimer = new StopWatchTimer();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start); // Start
    return _stopWatchTimer;
  }

  // Calorie Calculation using Metabolic Equivalent for Task method (MET)
  double getCalorie(double? speed, int second) {
    // 3.5 Speed = 6min/1km // meter/second
    double totalCalorieBurned = (second / 60) * (4 * 3.5 * 60) / 200;
    print("$speed and $second");
    return totalCalorieBurned;
  }
}
