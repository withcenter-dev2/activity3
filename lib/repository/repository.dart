import 'package:activityn3/models/user_modal.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';

class UserRepository {
  late final Database db;

  Future<void> insertUser(UserModel user) async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/quiz.db';
    db = sqlite3.open(dbPath);

     db.execute(
      "create table if not exists users ( id varchar(64), password text, name varchar(32) )",
    );
  }

   Future<List<UserModel>> getUsers() async {
    final result = db.select('users');
    return result.map((e) => UserModel.fromMap(e)).toList();
  }
}