class UserLeaderboard {
  String name;
  String uId;
  double totalDistance;

  UserLeaderboard(this.uId, this.name, this.totalDistance);

  Map<String, dynamic> get map {
    return {
      "name": name,
      "uId": uId,
      "totalDistance": totalDistance,
    };
  }

  static double intToDouble(int dist) {
    return dist.toDouble();
  }
}
