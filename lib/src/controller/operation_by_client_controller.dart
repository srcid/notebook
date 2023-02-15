import 'package:flutter/foundation.dart';

import '../database/database_client.dart';
import '../model/operation_model.dart';
import '../repository/interface/operation_repository.dart';
import '../repository/sqlite/operation_repository_sqlite.dart';

class OperationByClientController extends ChangeNotifier {
  OperationByClientController({required this.clientId})
      : _operationRepository =
            OperationRepositorySQLite(DatabaseClient.instance.database);

  final OperationRepository _operationRepository;
  final int clientId;

  Future<List<OperationModel>> get operations async =>
      await _operationRepository.findByClientIdOrderByDatetime(clientId);

  save(OperationModel operation) {
    _operationRepository.save(operation);
    notifyListeners();
  }
}
