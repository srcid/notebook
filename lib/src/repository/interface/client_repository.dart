import '../../model/client_model.dart';

abstract class ClientRepository {
  Future<int> save(ClientModel client);
  Future<int> update(ClientModel client);
  Future<int> remove(ClientModel client);
  Future<List<ClientModel>> findAll();
  Future<ClientModel> findById(int id);
}
