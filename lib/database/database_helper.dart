// import 'package:sqlite3/sqlite3.dart';
// import 'package:path_provider/path_provider.dart';

// class DBHelper {
//   DBHelper._privateConstructor();
//   static final DBHelper instance = DBHelper._privateConstructor();
//   static Database? db;

//     @override
//     void initState() {
//       super.initState();
//       scheduleMicrotask(() {
//         _initDb();
//       });
//     }

//   Future<void> _initDb() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final dbPath = '${dir.path}/users.db';
//     db = sqlite3.open(dbPath);
//     db.execute(
//       "create table if not exists quizquiestion ( id varchar(64), questinon text, answer varchar(64) )",
//     );

//     final row = selectName(name);
//     if (row != null && mounted) {
//       final user = Provider.of<UserState>(context, listen: false);
//       user.update(row[0], row[1]);
//     }
//   }


//   //Insert
//   Future<int> insertQuiz(String question, String answer) async {
//     final db = await instance.database;
//     return await db.insert('quizquiestion', {'questiin': question, 'answer': answer});
//     //  db.insert() → adds a new row into the blog table
//     // The Map → matches column names with values
//     // await → waits until insert finishes
//     // return → gives back the inserted row ID
//   }
// }
