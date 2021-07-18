import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/activity_map_calculation/google_maps_controller.dart';
import 'package:runner/activity_map_calculation/stat_calculations.dart';
import 'package:runner/activity_map_calculation/step_count_handler.dart';
import 'package:runner/components/activity_components/map.dart';
import 'package:latlong/latlong.dart' as lt;
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Stream<StepCount> stepCountStream;
  StreamSubscription? stepStream;
  List<int> stepsHolder = <int>[];
  double km = 0;
  double kcal = 0;
  int second = 0;
  String? time;
  int currentSteps = 0;
  double avgSpeed = 0.0;
  List<LatLng> coordinates = [];

  // Initial Location
  _ActivityPageState() {
    ApplicationState().fetchActivityLocationHolder().then(
          (value) => setState(
            () {
              coordinates.add(value ?? LatLng(0, 0));
              getKm();
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    getStopWatch();
    StepCountHandler().stepCountInitializers();
  }

  @override
  void dispose() {
    super.dispose();
    stepStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Safe Are Size below
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < 0) {
          // Swiped right
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DrawMap(
                coordinates: coordinates,
              ),
            ),
          );
        }
      },
      child: Container(
        width: width,
        height: newheight,
        color: Colors.yellow.shade400,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
              ),
              RunInfo(
                km: km.toStringAsFixed(3),
                stepCount: currentSteps.toString(),
                kcal: kcal.toStringAsFixed(1),
              ), // TODO:  RangeError (index): Invalid value: Only valid value is 0: -1
              DisplayTimer(time: time),
              ElevatedButton(
                onPressed: () async {
                  // Add stats to class
                  ApplicationState().addActivityStatstoDatabase(kcal,
                      currentSteps, km, avgSpeed, time ?? "0", coordinates);
                  ApplicationState().updateLeaderboard(km);
                  await ApplicationState().addActivitytoDatabase(
                      initialCameraposition ?? LatLng(0, 0), "no");

                  stepStream?.cancel();
                  Navigator.pop(context,
                      "Please Navigate History to check your last activity information!");
                },
                child: Icon(
                  Icons.stop,
                  color: Colors.white,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  primary: Colors.black87, // <-- Button color
                  onPrimary: Colors.yellow, // <-- Splash color
                ),
              )
            ],
          ),
        ),
        // KM, Time, Calories, Pedometer
      ),
    );
  }

  ///// Functions Below

  // KM
  getKm() async {
    try {
      List<LatLng> l = <LatLng>[];
      if (mounted) {
        location.onLocationChanged.listen((event) {
          Calculations method = new Calculations();
          // KM below
          l.add(new LatLng(event.latitude ?? 0.0, event.longitude ?? 0.0));
          double meter = method.getDistance(
            new lt.LatLng(l[l.length - 2].latitude, l[l.length - 2].longitude),
            new lt.LatLng(event.latitude, event.longitude),
          );
          avgSpeed += event.speed ?? 0.0;
          getStepCount();
          // Calorie below
          kcal = Calculations().getCalorie(event.speed, second);
          // StepCount below
          if (mounted) {
            setState(() {
              km += meter * 0.001;
            });
          }
        });
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  // Timer
  getStopWatch() {
    StopWatchTimer sw = Calculations().getTimer();
    sw.rawTime.listen((event) {
      if (mounted) {
        setState(() {
          second = sw.secondTime.value;
          time = StopWatchTimer.getDisplayTime(event, milliSecond: false);
        });
      }
    });
  }

// StepCount Function
  getStepCount() {
    int stepCountHolder;
    stepCountStream = Pedometer.stepCountStream;
    stepStream = stepCountStream.listen(StepCountHandler().onStepCount)
      ..onData((data) {
        stepCountHolder = data.steps; // 5500
        if (mounted) {
          setState(() {
            // Track step differences to display instance of activity steps.
            if (stepCountHolder != 0) {
              stepsHolder.add(stepCountHolder);
              currentSteps = StepCountHandler()
                  .getLiveCount(stepsHolder.first, stepsHolder.last);
            }
          });
        }
      });
  }
}

// Timer Widget
class DisplayTimer extends StatelessWidget {
  const DisplayTimer({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String? time;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 5,
      child: Text(
        time ?? "",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: 70, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Stats Area
class RunInfo extends StatelessWidget {
  final String? km;
  final String? stepCount;
  final String? kcal;

  const RunInfo(
      {Key? key, required this.km, required this.stepCount, required this.kcal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.location_on_outlined),
              ),
              Icon(
                FontAwesomeIcons.fire,
                color: Colors.red.shade600,
              ),
              Icon(
                Icons.run_circle_outlined,
                color: Colors.green,
              ),
            ],
          ),
          TableRow(children: <Widget>[
            DataTFs(
              kmText: "$km",
            ),
            DataTFs(
              kmText: "$kcal",
            ),
            DataTFs(
              kmText: "$stepCount",
            ),
          ]),
          TableRow(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'KM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'Kcal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Step',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataTFs extends StatelessWidget {
  const DataTFs({
    Key? key,
    required this.kmText,
  }) : super(key: key);

  final String kmText;

  @override
  Widget build(BuildContext context) {
    return Text(
      kmText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}
// TODO: Extension method
