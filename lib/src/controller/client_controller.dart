import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/client_model.dart';
import '../repository/interface/client_repository.dart';

class ClientController extends ChangeNotifier {
  final clientRepository = GetIt.I.get<ClientRepository>();

  Future<List<ClientModel>> get clients async =>
      await clientRepository.findAll();

  save(ClientModel client) async {
    await clientRepository.save(client);
    notifyListeners();
  }

  remove(ClientModel client) async {
    await clientRepository.remove(client);
    notifyListeners();
  }

  update(ClientModel client) async {
    await clientRepository.update(client);
    notifyListeners();
  }
}
