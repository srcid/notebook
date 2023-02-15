import 'package:flutter/foundation.dart';

import '../database/database_client.dart';
import '../model/operation_model.dart';
import '../repository/interface/operation_repository.dart';
import '../repository/sqlite/operation_repository_sqlite.dart';

class OperationByClientController extends ChangeNotifier {
  OperationByClientController({required this.clientId}) {
    _updateOperations();
  }

  final OperationRepository _operationRepository =
      OperationRepositorySQLite(DatabaseClient.instance.database);
  final int clientId;
  var _operations = [];

  get operations => _operations;

  _updateOperations() async {
    _operationRepository.findByClientIdOrderByDatetime(clientId).then(
      (value) {
        _operations = value;
        notifyListeners();
      },
    );
  }

  save(OperationModel operation) {
    _operationRepository.save(operation);
    _updateOperations();
  }
}
