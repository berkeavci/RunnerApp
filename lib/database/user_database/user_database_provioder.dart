import 'package:sqflite/sqflite.dart';

class UserDatabaseProvider {
  String _userDatabaseName = 'userDatabase';
  String _userTableName = 'user';
  int _version = 1;
  Database? database;

  // Column Names
  //   String email;
  // String name;
  // String about;
  // String uId;
  // int weight;
  String? columnUseremail = "userEmail";
  String? columnUsername = "userName";
  String? columnUserabout = "userAbout";
  String? columnUseruId = "userId";
  String? columnUserweight = "userWeight";

  Future<void> open() async {
    database = await openDatabase(
      _userDatabaseName,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  void createTable(Database db) {
    db.execute(
        '''CREATE TABLE $_userTableName ( $columnUseruId VARCHAR(30) PRIMARY KEY, 
            $columnUseremail VARCHAR(20),
            $columnUsername VARCHAR(20), 
            $columnUserabout VARCHAR(256), 
            $columnUserweight INTEGER)
            ''');
  }

  // void getList(
  //   database.
  // )
}
