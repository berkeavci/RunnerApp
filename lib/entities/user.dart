class User {
  final String email;
  final String name;
  final String image;
  final String about;
  final bool isDarkMode;
  final int id;

  const User(
      {required this.name,
      required this.email,
      required this.image,
      required this.about,
      required this.isDarkMode,
      required this.id});
}
