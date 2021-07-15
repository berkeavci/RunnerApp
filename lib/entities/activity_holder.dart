class ActivityHolder {
  int uId;
  double lat;
  double long;
  String isActivity;

  ActivityHolder(this.uId, this.lat, this.long, this.isActivity);

  Map<String, dynamic> get map {
    return {
      "uId": uId,
      "lat": lat,
      "long": long,
      "isActivity": isActivity,
    };
  }
}
// TODO: Think of usage
