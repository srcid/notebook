import 'package:notebook/src/models/consumer_transaction.dart';
import 'package:notebook/src/repository/base_repository_interface.dart';

import '../database/database_helper.dart';

class ConsumerTransactionRepository
    implements BaseRepository<ConsumerTransaction> {
  static const String table = 'consumer_transaction';

  @override
  Future<int> add(newObj) async {
    final database = await DatabaseHelper.instance.database;
    return await database.insert(table, newObj.toJson());
  }

  @override
  Future<List<ConsumerTransaction>> findAll() async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(table);
    return list.map((e) => ConsumerTransaction.fromJson(e)).toList();
  }

  @override
  Future<ConsumerTransaction> findById(int id) async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return list.map((e) => ConsumerTransaction.fromJson(e)).first;
  }

  @override
  Future<int> update(changedObj) async {
    final database = await DatabaseHelper.instance.database;
    return await database.update(
      table,
      changedObj.toJson(),
      where: 'id = ?',
      whereArgs: [changedObj.id],
    );
  }

  Future<List<ConsumerTransaction>> findByConsumerId(int consumerId) async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(
      table,
      where: 'consumer_id = ?',
      whereArgs: [consumerId],
    );
    return list.map((e) => ConsumerTransaction.fromJson(e)).toList();
  }
}
