abstract class BaseSecureStorage {
  Future<void> write<T>(String key, T value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}