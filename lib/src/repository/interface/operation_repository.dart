import '../../model/operation_model.dart';

abstract class OperationRepository {
  Future<int> save(OperationModel operation);
  Future<int> update(OperationModel operation);
  Future<int> remove(OperationModel operation);
  Future<List<OperationModel>> findAll();
  Future<OperationModel> findById(int id);
  Future<List<OperationModel>> findByClientId(int clientId);
}
