import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runner/Page/details_page.dart';
import 'package:runner/Page/share_test.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';
import 'package:runner/constans.dart';
import 'package:runner/entities/activity_stats.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ActivityHistoryPage extends StatefulWidget {
  ActivityHistoryPage({Key? key}) : super(key: key);

  @override
  _ActivityHistoryPageState createState() => _ActivityHistoryPageState();
}

class _ActivityHistoryPageState extends State<ActivityHistoryPage> {
  List<ActivityStats>? actStats = <ActivityStats>[];
  // initial addition of result to here
  _ActivityHistoryPageState() {
    ApplicationState()
        .fetchActivityInfo()
        .then((value) => setState(
              () {
                value?.forEach(
                  (element) {
                    actStats?.add(element);
                  },
                );
              },
            ))
        .onError((error, stackTrace) =>
            print("Error during fetching activity info"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: actStats?.length == 0
            ? EmptyActivityHistory()
            : ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.blueGrey,
                  endIndent: 10,
                  indent: 5,
                ),
                itemCount: actStats?.length ?? 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ListOfActivities(
                    activityS: actStats?[index],
                    index: index,
                  );
                },
              ),
      ),
    );
  }
}

class EmptyActivityHistory extends StatelessWidget {
  const EmptyActivityHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 500,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Icon(
                  CupertinoIcons.square_list,
                  size: 100,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Activity History is Empty...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: productSans,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ListOfActivities extends StatelessWidget {
  final ActivityStats? activityS;
  final int index;

  const ListOfActivities({
    Key? key,
    this.activityS,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: new ListTile(
          dense: false,
          contentPadding: EdgeInsets.symmetric(vertical: 2),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              CupertinoIcons.graph_circle_fill,
              color: Colors.blueGrey.shade800,
            ),
          ),
          title: Text(
            "${ActivityStats.toDay(activityS?.map["date"])} Run",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              "KM: ${activityS?.map["km"].toStringAsFixed(3)}  TIME: ${activityS?.map["time"]}"),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 50, 15),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      activityStats: activityS,
                    ),
                  ),
                );
              },
              icon: new Icon(
                MdiIcons.shoeSneaker,
                color: Colors.red.shade400,
                size: 60,
              ),
            ),
          )
          // ElevatedButton.icon(
          //   // style: ElevatedButton.styleFrom(
          //   //     primary: Colors.transparent,
          //   //     textStyle: TextStyle(fontWeight: FontWeight.bold)),
          //   style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          //   onPressed: () {},
          //   icon: new Icon(MdiIcons.shoeSneaker),
          //   label: Text('Details'),
          // ),
          ),
    );
  }
}

// arrowshape_turn_up_right_fill
