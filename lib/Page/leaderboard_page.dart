import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runner/constans.dart';
import 'package:runner/entities/userLeaderboard.dart';
import 'package:runner/activity_map_calculation/firebase_service.dart';

class LeaderBoardPage extends StatefulWidget {
  LeaderBoardPage({
    Key? key,
  }) : super(key: key);

  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  List<UserLeaderboard>? userLeader = <UserLeaderboard>[];

  _LeaderBoardPageState() {
    ApplicationState()
        .fetchUserLeaderboard()
        .then(
          (value) => setState(
            () {
              value?.forEach((element) {
                userLeader?.add(element);
              });
            },
          ),
        )
        .onError(
          (error, stackTrace) => print("${error.toString()}"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "LEADERBOARD",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontFamily: productSans,
            fontSize: 20,
          ),
        ),
        actions: [],
      ),
      body: ListView.builder(
          itemCount: userLeader?.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return LeaderboardList(
              index: index,
              userL: userLeader?[index],
            );
          }),
    );
  }
}

class LeaderboardList extends StatelessWidget {
  final UserLeaderboard? userL;
  final int index;

  const LeaderboardList({
    Key? key,
    this.userL,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${index + 1}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 30,
          ),
          Card(
            color: index == 0 ? Colors.red.shade200 : Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Container(
              width: 300,
              child: ListTile(
                dense: false,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                title: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text("${userL?.map["name"]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                trailing: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                  child: Text(
                    "${userL?.map["totalDistance"].toStringAsFixed(3)}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
