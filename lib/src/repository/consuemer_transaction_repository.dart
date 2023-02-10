import 'package:notebook/src/models/consumer_transaction_model.dart';
import 'package:notebook/src/repository/base_repository_interface.dart';

import '../database/database_helper.dart';

import 'dart:developer' as dev;

class ConsumerTransactionRepository
    implements BaseRepository<ConsumerTransactionModel> {
  static const String table = 'consumer_transaction';

  @override
  Future<int> add(newObj) async {
    final database = await DatabaseHelper.instance.database;
    return await database.insert(table, newObj.toJson());
  }

  @override
  Future<List<ConsumerTransactionModel>> findAll() async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(table);

    dev.log(list.toString(), name: 'find');

    return list.map((e) => ConsumerTransactionModel.fromJson(e)).toList();
  }

  @override
  Future<ConsumerTransactionModel> findById(int id) async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return list.map((e) => ConsumerTransactionModel.fromJson(e)).first;
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

  Future<List<ConsumerTransactionModel>> findByConsumerId(
      int consumerId) async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(
      table,
      where: 'consumer_id = ?',
      whereArgs: [consumerId],
    );
    return list.map((e) => ConsumerTransactionModel.fromJson(e)).toList();
  }

  Future<List<ConsumerTransactionModel>> findByConsumerIdOrdered(
      int consumerId) async {
    final database = await DatabaseHelper.instance.database;
    final list = await database.query(
      table,
      where: 'consumer_id = ?',
      whereArgs: [consumerId],
      orderBy: 'datetime DESC',
    );
    return list.map((e) => ConsumerTransactionModel.fromJson(e)).toList();
  }
}
