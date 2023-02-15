import 'package:flutter/foundation.dart';
import 'package:notebook/src/database/database_client.dart';
import 'package:notebook/src/model/client_model.dart';
import 'package:notebook/src/repository/interface/client_repository.dart';
import 'package:notebook/src/repository/sqlite/client_repository_sqlite.dart';

class ClientController extends ChangeNotifier {
  ClientController()
      : _clientRepository =
            ClientRepositorySQLite(DatabaseClient.instance.database);

  final ClientRepository _clientRepository;

  Future<List<ClientModel>> get clients async =>
      await _clientRepository.findAll();

  save(ClientModel client) async {
    await _clientRepository.save(client);
    notifyListeners();
  }

  remove(ClientModel client) async {
    await _clientRepository.remove(client);
  }
}
