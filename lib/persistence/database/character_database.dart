// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDatabaseContext {
  final int version = 1;
  final String databaseName = 'superhero.db';
  final String tableName = 'characters';
  late Database _database;

  Future<Database> openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (database, version) {
        String initialQuery = 'create table $tableName ('
            'id integer primary key,'
            'name varchar(255),'
            'gender varchar(255),'
            'intelligence varchar(255),'
            'image varchar(255)'
            ')';
        database.execute(initialQuery);
      },
    );
    return _database;
  }
}
