import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/client_model.dart';
import '../model/operation_model.dart';
import '../repository/interface/operation_repository.dart';
import 'client_controller.dart';

class OperationController extends ChangeNotifier {
  final operationRepository = GetIt.I.get<OperationRepository>();
  final clientController = GetIt.I.get<ClientController>();

  get operations async => await operationRepository.findAll();

  Future<List<OperationModel>> getByClient(ClientModel client) async {
    return await operationRepository.findByClientIdOrderByDatetime(client.id!);
  }

  save(OperationModel operation) async {
    await operationRepository.save(operation);
    clientController.notifyListeners();
    notifyListeners();
  }

  remove(OperationModel operation) async {
    await operationRepository.remove(operation);
    clientController.notifyListeners();
    notifyListeners();
  }

  update(OperationModel operation) async {
    await operationRepository.update(operation);
    clientController.notifyListeners();
    notifyListeners();
  }
}
