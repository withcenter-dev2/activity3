import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:activityn3/models/user_modal.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  late final Database db;

  Future<void> insertUser(UserModel user) async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/quiz.db';
    db = sqlite3.open(dbPath);

     db.execute(
      "create table if not exists users ( id varchar(64), password text, name varchar(32) )",
    );
  }

  // Future<bool> insertUse(String questions, String answers) async {
  //   try {
  //     db.execute( "insert into users (name, id, password) values ('$questions', '$answers')",  );
  //     //db.insertUser(questions, answers);
  //     return true;
  //   } catch (e) {
  //     return false; // questions already exists
  //   }
  // }
}

// class UserRepository {
//   late final Database db;

  

//    Future<List<UserModel>> getUsers() async {
//     final result = db.select('users');
//     return result.map((e) => UserModel.fromMap(e)).toList();
//   }
// }