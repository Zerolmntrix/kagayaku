import '../../../utils/database.dart';
import '../models/source.dart';

abstract class SourceMethods {
  static Future<bool> create(Source source) async {
    return await dbCall((db) async {
      await db.insert(SourceFields.tableName, source.toJson());
      return true;
    });
  }

  static Future<Source> readSource(String id) async {
    return await dbCall((db) async {
      final maps = await db.query(
        SourceFields.tableName,
        columns: SourceFields.values,
        where: '${SourceFields.id} = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isNotEmpty) {
        return Source.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    });
  }

  static Future<List<Source>> readAllSources() async {
    return await dbCall((db) async {
      const orderBy = '${SourceFields.name} ASC';

      final result = await db.query(
        SourceFields.tableName,
        orderBy: orderBy,
      );

      return result.map((json) => Source.fromJson(json)).toList();
    });
  }

  static Future<int> update(Source source) async {
    return dbCall((db) {
      return db.update(
        SourceFields.tableName,
        source.toJson(),
        where: '${SourceFields.id} = ?',
        whereArgs: [source.id],
      );
    });
  }

  static Future<int> delete(String id) async {
    return await dbCall((db) async {
      return await db.delete(
        SourceFields.tableName,
        where: '${SourceFields.id} = ?',
        whereArgs: [id],
      );
    });
  }
}
