abstract class BaseRepository<T> {
  Future<List<T>> findAll();
  Future<T> findById(int id);
  Future<int> update(T changedObj);
  Future<int> add(T newObj);
}
