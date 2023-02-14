import 'package:sqflite/sqflite.dart';

import '../../model/client_model.dart';
import '../interface/client_repository.dart';

class ClientRepositorySQLite implements ClientRepository {
  ClientRepositorySQLite(this.db);

  Database db;
  static const table = 'client';

  @override
  findAll() async {
    final map = await db.query(table);
    return List.generate(
      map.length,
      (index) => ClientModel.fromMap(map[index]),
    );
  }

  @override
  findById(int id) async {
    final map = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return ClientModel.fromMap(map[0]);
  }

  @override
  remove(ClientModel client) async {
    final count = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [client.id],
    );

    return count; /* number of affected rows */
  }

  @override
  save(ClientModel client) async {
    final values = client.toMap();
    final id = await db.insert(
      table,
      values,
    );

    return id; /* id of inserted row */
  }

  @override
  update(ClientModel client) async {
    final values = client.toMap();
    final count = await db.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [client.id],
    );

    return count; /* number of rows affected */
  }
}
