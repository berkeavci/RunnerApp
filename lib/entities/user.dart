class UserInformations {
  String email;
  String name;
  String about;
  String uId;
  int weight;

  UserInformations(this.weight, this.name, this.email, this.about, this.uId);

  Map<String, dynamic> get map {
    return {
      "email": email,
      "name": name,
      "about": about,
      "uId": uId,
      "weight": weight,
    };
  }
}
