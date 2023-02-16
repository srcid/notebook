import 'package:sqflite/sqflite.dart';

import '../../database/database_client.dart';
import '../../model/operation_model.dart';
import '../interface/operation_repository.dart';

class OperationRepositorySQLite implements OperationRepository {
  OperationRepositorySQLite() : db = DatabaseClient.instance.database;
  final Database db;
  static const table = 'operation';

  @override
  Future<List<OperationModel>> findAll() async {
    final map = await db.query(table);
    return List.generate(
      map.length,
      (index) => OperationModel.fromMap(map[index]),
    );
  }

  @override
  Future<List<OperationModel>> findByClientId(int clientId) async {
    final map = await db.query(
      table,
      where: 'client_id = ?',
      whereArgs: [clientId],
    );

    return List.generate(
      map.length,
      (index) => OperationModel.fromMap(map[index]),
    );
  }

  @override
  Future<OperationModel> findById(int id) async {
    final map = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return OperationModel.fromMap(map[0]);
  }

  @override
  Future<int> remove(OperationModel operation) async {
    final count = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [operation.id],
    );

    return count; /* number of affected rows */
  }

  @override
  Future<int> save(OperationModel operation) async {
    final values = operation.toMap();
    final id = await db.insert(
      table,
      values,
    );

    return id; /* Id of inserted row */
  }

  @override
  Future<int> update(OperationModel operation) async {
    final values = operation.toMap();
    final count = await db.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [operation.id],
    );

    return count; /* number of rows affected */
  }

  @override
  Future<List<OperationModel>> findByClientIdOrderByDatetime(
      int clientId) async {
    final map = await db.query(table,
        where: 'client_id = ?',
        whereArgs: [clientId],
        orderBy: 'datetime DESC');

    return List.generate(
      map.length,
      (index) => OperationModel.fromMap(map[index]),
    );
  }
}
