import 'package:sqflite/sqflite.dart';

import '../data/database/db.dart';

typedef Callback<T> = T Function(Database db);

Future<T> dbCall<T>(Callback callback) async {
  Database db = await KagayakuDB.instance.database;
  return callback(db);
}

closeDB() async {
  Database db = await KagayakuDB.instance.database;
  await db.close();
}
