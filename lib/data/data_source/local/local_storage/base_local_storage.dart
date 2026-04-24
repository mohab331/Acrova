abstract class BaseLocalStorage {
  Future<void> write<T>(String key, T value);
  T? read<T>(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}
