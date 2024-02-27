import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
class SQLHelper {
  static Future<void>
  createTables(sql.Database database) async
  {
    await database.execute( 'CREATE TABLE bars('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'country TEXT, '
        'tripDays TEXT,'
        ' price TEXT)');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'crud_helper.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String country, String tripDays,String price) async {
    final db = await SQLHelper.db();
    final data = {'country': country, 'tripDays': tripDays,'price':price,};
    final id = await db.insert('bars', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('bars', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('bars', where: "id= ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int? id,String country, String tripDays,String price ) async {
    final db = await SQLHelper.db();
    final data = {

      'country': country,
      'tripDays': tripDays,
      'price':price
    };
    final result = await db.update(
        'bars', data, where: "id= ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("bars", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
