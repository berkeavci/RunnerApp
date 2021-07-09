import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng? initpos;
  double km = 0;
  double calorie = 0;
  int second = 0;
  String? time;
  String? stepCount;
  //bool isGettingLocation = false;

  // Initial Location
  _ActivityPageState() {
    ApplicationState().fetchInitialLocation().then(
          (value) => setState(
            () {
              initpos = value;
              //isGettingLocation = true;
              getKm();
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    getStopWatch();
    StepCountHandler().getStepCount();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Safe Are Size below
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Container(
      width: width,
      height: newheight,
      color: Colors.yellow.shade400,
      child: SafeArea(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              // Swiped right
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DrawMap(
                    initialPosition: initpos ?? LatLng(0, 0),
                  ),
                ),
              );
              print("u swiped");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
              ),
              RunInfo(
                km: km.toStringAsFixed(3),
                time: time,
                calorie: calorie.toStringAsFixed(1),
              ), // TODO:  RangeError (index): Invalid value: Only valid value is 0: -1
              DisplayTimer(time: time)
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
      location.onLocationChanged.listen((event) {
        //print(event.speed);
        Calculations method = new Calculations();
        // KM below
        l.add(new LatLng(event.latitude ?? 0.0, event.longitude ?? 0.0));
        double meter = method.getDistance(
          new lt.LatLng(l[l.length - 2].latitude, l[l.length - 2].longitude),
          new lt.LatLng(event.latitude, event.longitude),
        );
        //isGettingLocation = true;
        // Calorie below
        calorie = Calculations().getCalorie(event.speed, second);
        // StepCount below
        stepCount = StepCountHandler().getStepCount();
        setState(() {
          km += meter * 0.001;
          print(calorie);
        });
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  // Timer
  getStopWatch() {
    StopWatchTimer sw = Calculations().getTimer();
    sw.rawTime.listen((event) {
      setState(() {
        second = sw.secondTime.value;
        time = StopWatchTimer.getDisplayTime(event, milliSecond: false);
      });
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
      heightFactor: 6,
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
  final String? time;
  final String? calorie;

  const RunInfo(
      {Key? key, required this.km, required this.time, required this.calorie})
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
              Icon(Icons.run_circle_outlined),
              Icon(Icons.timelapse_rounded),
            ],
          ),
          TableRow(children: <Widget>[
            KmTF(
              kmText: "$km",
            ),
            KmTF(
              kmText: "$calorie",
            ),
            KmTF(
              kmText: "$time",
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
                'Calorie',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Time',
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

class KmTF extends StatelessWidget {
  const KmTF({
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
