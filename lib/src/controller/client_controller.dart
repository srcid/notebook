import 'package:flutter/foundation.dart';
import 'package:notebook/src/database/database_client.dart';
import 'package:notebook/src/model/client_model.dart';
import 'package:notebook/src/repository/interface/client_repository.dart';
import 'package:notebook/src/repository/sqlite/client_repository_sqlite.dart';

class ClientController extends ChangeNotifier {
  ClientController() {
    _updateClients();
  }

  final ClientRepository _clientRepository =
      ClientRepositorySQLite(DatabaseClient.instance.database);
  final _clients = [];

  get clients => _clients;

  _updateClients() {
    _clientRepository.findAll().then((value) {
      _clients.addAll(value);
      notifyListeners();
    });
  }

  save(ClientModel client) async {
    final newId = await _clientRepository.save(client);
    _clients.add(client.copyWith(id: newId));
    notifyListeners();
  }
}
