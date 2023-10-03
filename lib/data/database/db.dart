import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/source.dart';

class KagayakuDB {
  KagayakuDB._init();

  static final KagayakuDB instance = KagayakuDB._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDB();
  }

  _initDB() async {
    final path = join(await getDatabasesPath(), 'kagayaku.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  _createDB(Database db, int version) async {
    await db.execute(tableSources);
  }
}
