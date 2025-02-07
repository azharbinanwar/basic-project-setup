import 'dart:async';

import 'package:basic_project_template/core/services/logger/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// @LazySingleton()
class AppDatabaseService {
  static const String _db = 'app.db';
  final int _version = 1;

  final _tableName = 'any_table';

  String get anTableName => _tableName;

  late Database _database;

  Database get database => _database;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    try {
      _database = await _initDatabase();
    } catch (e, s) {
      Log.e(runtimeType, e.toString(), s);
    }
  }

  /// Initialize the database by copying from assets
  Future<Database> _initDatabase() async {
    Log.i(runtimeType, 'initializing database');

    /// Get the device's documents directory
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _db);

    /// Open and return the newly created database
    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE $_tableName(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         field1 INTEGER,
         field2 INTEGER,
         created_at TEXT DEFAULT CURRENT_TIMESTAMP,
         updated_at TEXT DEFAULT CURRENT_TIMESTAMP
       )
     ''');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    /// write the upgrade query when needed
    if (oldVersion == 1 && newVersion == 2) {
      /// write the upgrade query here
    }
  }
}
