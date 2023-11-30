import 'package:flutter_app/persistence/database/character_database.dart';
import 'package:flutter_app/provider/model/character.dart';
import 'package:sqflite/sqflite.dart';

class CharacterRepository {
  CharacterDatabaseContext databaseContext = CharacterDatabaseContext();

  Future insert(Character character) async {
    Database db = await databaseContext.openDb();
    db.insert(databaseContext.tableName, character.toMap());
  }

  Future delete(Character character) async {
    Database db = await databaseContext.openDb();
    db.delete(databaseContext.tableName,
        where: "id=?", whereArgs: [character.id]);
  }

  Future<bool> existById(int id) async {
    Database db = await databaseContext.openDb();

    final characters = await db
        .query(databaseContext.tableName, where: "id=?", whereArgs: [id]);

    return characters.isNotEmpty;
  }

  Future<List<Character>> getAll() async {
    Database db = await databaseContext.openDb();

    final characters = await db.query(databaseContext.tableName);

    return characters.map((e) => Character.fromDatabaseMap(e)).toList();
  }

  Future<void> deleteAll() async {
    Database db = await databaseContext.openDb();
    await db.delete(databaseContext.tableName);
  }
}
