import 'base_repository_interface.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/consumer_model.dart';

class ConsumerRepository implements BaseRepository<ConsumerModel> {
  static const table = 'consumer';

  @override
  Future<List<ConsumerModel>> findAll() async {
    var database = await DatabaseHelper.instance.database;
    var list = await database.query(table);
    return list.map((e) => ConsumerModel.fromJson(e)).toList();
  }

  @override
  Future<ConsumerModel> findById(int id) async {
    var database = await DatabaseHelper.instance.database;
    var list = await database.query(table, where: 'id = ?', whereArgs: [id]);
    return list.map((e) => ConsumerModel.fromJson(e)).toList()[0];
  }

  @override
  Future<int> add(ConsumerModel newObj) async {
    var database = await DatabaseHelper.instance.database;
    return await database.insert(table, newObj.toJson(),
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  @override
  Future<int> update(ConsumerModel changedObj) async {
    var database = await DatabaseHelper.instance.database;
    return await database.update(table, changedObj.toJson(),
        where: 'id = ?',
        whereArgs: [changedObj.id],
        conflictAlgorithm: ConflictAlgorithm.fail);
  }
}
