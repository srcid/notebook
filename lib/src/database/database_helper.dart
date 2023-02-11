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
    await database.rawQuery(_createTrigger);
    await database.rawQuery(_createConsumerIndex);

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
    datetime    INTEGER NOT NULL                 ,

    CONSTRAINT fk_consumer_id
    FOREIGN KEY (consumer_id) 
    REFERENCES consumer(id) 
    ON DELETE CASCADE
  );
  ''';

  String get _populateConsumerTable => '''
  INSERT INTO consumer (name) 
  VALUES ('MARIA DA SILVA'), ('FRANCISCO FERREIRA FERRAZ FRANCO'),
  ('JOELMA JANUARIO'), ('CAMILO CAMARGO CORREIA'), ('JOÃO');
  ''';

  String get _populateConsumerTransactionTable => '''
  INSERT INTO consumer_transaction (consumer_id, value, datetime) 
  VALUES (1, 1000, 1675220300), (1, 1500, 1675220400), (1, 2050, 1677639599),
  (1, -3010, 1677639500), (1, 5550, 1677639450);
  ''';

  String get _createConsumerIndex => '''
  CREATE UNIQUE INDEX consumer_index
  ON consumer(id);
  ''';

  String get _createTrigger => '''
  CREATE TRIGGER update_consumer_balance
  AFTER INSERT 
  ON consumer_transaction
  BEGIN 
      UPDATE consumer 
      SET balance = balance + NEW.value
      WHERE id = NEW.consumer_id;
  END;

  CREATE TRIGGER update_consumer_balance
  AFTER DELETE 
  ON consumer_transaction
  BEGIN 
      UPDATE consumer 
      SET balance = balance - OLD.value
      WHERE id = NEW.consumer_id;
  END;

  CREATE TRIGGER update_consumer_balance
  AFTER UPDATE 
  ON consumer_transaction
  BEGIN 
      UPDATE consumer 
      SET balance = balance + NEW.value - OLD.value
      WHERE id = NEW.consumer_id;
  END;
  ''';
}
