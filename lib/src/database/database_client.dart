import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  DatabaseClient._internal();

  static DatabaseClient instance = DatabaseClient._internal();

  late Database database;

  close() {
    database.close();
  }

  init() async {
    final databasePath = await getDatabasesPath();

    database = await openDatabase(
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
    await database.execute(_createClientTable);
    await database.execute(_createOperationTable);
    await database.execute(_triggerUpdateClientBalanceAfterInsertOperation);
    await database.execute(_triggerUpdateClientBalanceAfterDeleteOperation);
    await database.execute(_triggerUpdateClientBalanceAfterUpdateOperation);
    await database.execute(_createClientIndex);
    await database.execute(_createOperationIndex);

    await database.rawInsert(_populateClientTable);
    await database.rawInsert(_populateOperationTable);
  }

  String get _createClientTable => '''
  CREATE TABLE client(
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT    UNIQUE  NOT NULL CHECK(LENGTH(name) >= 1) CHECK(UPPER(name) = name),
    balance INTEGER DEFAULT 0
  );
  ''';

  String get _createOperationTable => '''
  CREATE TABLE operation(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id   INTEGER                          ,
    value       INTEGER NOT NULL                 ,
    datetime    INTEGER NOT NULL                 ,

    CONSTRAINT fk_client_id
    FOREIGN KEY (client_id) 
    REFERENCES client(id) 
    ON DELETE CASCADE
  );
  ''';

  String get _populateClientTable => '''
  INSERT INTO client (name) 
  VALUES ('MARIA DA SILVA'), ('FRANCISCO FERREIRA FERRAZ FRANCO'),
  ('JOELMA JANUARIO'), ('CAMILO CAMARGO CORREIA'), ('JOÃO');
  ''';

  String get _populateOperationTable => '''
  INSERT INTO operation (client_id, value, datetime) 
  VALUES (1, 1000, 1675220300), (1, 1500, 1675220400), (1, 2050, 1677639599),
  (1, -3010, 1677639500), (1, 5550, 1677639450);
  ''';

  String get _createClientIndex => '''
  CREATE UNIQUE INDEX client_id_index
  ON client(id);
  ''';

  String get _createOperationIndex => '''
  CREATE INDEX operation_client_id_index
  ON operation(client_id);
  ''';

  String get _triggerUpdateClientBalanceAfterInsertOperation => '''
  CREATE TRIGGER update_client_balance_after_insert
  AFTER INSERT 
  ON operation
  BEGIN 
      UPDATE client 
      SET balance = balance + NEW.value
      WHERE id = NEW.client_id;
  END;
  ''';

  String get _triggerUpdateClientBalanceAfterDeleteOperation => '''
  CREATE TRIGGER update_client_balance_after_delete
  AFTER DELETE 
  ON operation
  BEGIN 
      UPDATE client 
      SET balance = balance - OLD.value
      WHERE id = OLD.client_id;
  END;
  ''';

  String get _triggerUpdateClientBalanceAfterUpdateOperation => '''
  CREATE TRIGGER update_client_balance_after_update
  AFTER UPDATE 
  ON operation
  BEGIN 
      UPDATE client 
      SET balance = balance + NEW.value - OLD.value
      WHERE id = NEW.client_id;
  END;
  ''';
}
