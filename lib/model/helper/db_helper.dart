//databas lokal

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../favorite_model.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static late Database _database;
  final String _tableName = 'favoriteData';

  DbHelper._internal() {
    _dbHelper = this;
  }
  factory DbHelper() => _dbHelper ?? DbHelper._internal();

  Future<Database> get database async {
    sqfliteFfiInit(); // Inisialisasi sqflite_ffi
    databaseFactory = databaseFactoryFfi;

    _database = await _initializeDB();
    return _database;
  }

  Future<Database> _initializeDB() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'favorite_planet.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName(
            planetImg TEXT, name TEXT, id INTEGER PRIMARY KEY, idPlanet INTEGER)''',
        );
      },
      version: 1,
    );
    return db;
  }

  //method untuk Insert data
  Future<void> insertFavorite(FavoriteModel favModel) async {
    final Database db = await database;
    await db.insert(_tableName, favModel.toMap());
  }

  //method untuk Read data
  Future<List<FavoriteModel>> getFavorite() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((e) => FavoriteModel.fromMap(e)).toList();
  }

  //method untuk menghapus data
  Future<void> deleteFavorite(int idPlanet) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'idPlanet = ?',
      whereArgs: [idPlanet],
    );
  }
}
