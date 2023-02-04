import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  void close() {
    _database?.close();
  }

  Future<Database> get database async {
    if (_database == null) {
      await _initDatabase();
    }

    return _database!;
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();

    _database = await openDatabase(
      join(databasePath, 'notebook.db'),
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
      singleInstance: true,
    );
  }

  _onConfigure(Database database) async {
    return await database.execute('PRAGMA foreign_keys = ON;');
  }

  _onCreate(Database database, int version) async {
    await database.execute(_createConsumerTable);
    await database.execute(_createConsumerTransactionTable);
    await database.rawInsert(_populateConsumerTable);
    await database.rawInsert(_populateConsumerTransactionTable);
  }

  String get _createConsumerTable => '''
  CREATE TABLE consumer(
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT    UNIQUE  NOT NULL CHECK(LENGTH(name) >= 1) CHECK(UPPER(name) = name),
    balance INTEGER DEFAULT 0
  );
  ''';

  String get _createConsumerTransactionTable => '''
  CREATE TABLE consumer_transaction(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    consumer_id INTEGER                          ,
    value       INTEGER NOT NULL                 ,

    FOREIGN KEY (consumer_id) REFERENCES consumer(id)
  );
  ''';

  String get _populateConsumerTable => '''
  INSERT INTO consumer (name, balance) VALUES ('FULANO DE TAL', 2835),
  ('CICRANO DA SILVA', 14410),
  ('NOME NOME NOME NOME', 109940),
  ('NOME', 22222),
  ('OUTRO NOME OUTRO NOME', 14141);
  ''';

  String get _populateConsumerTransactionTable => '''
  INSERT INTO consumer_transaction (consumer_id, value) VALUES (1, 10),
  (1, 15),
  (1, 20),
  (1, -30),
  (1, 5);
  ''';
}
