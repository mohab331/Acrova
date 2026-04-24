import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'base_secure_storage.dart';

class SecureStorageImpl implements BaseSecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> write<T>(String key, T? value) async {
    if(value == null) {
      await delete(key);
    } else {
      await _secureStorage.write(key: key, value: value.toString());
    }
  }

  @override
  Future<String?> read(String key) => _secureStorage.read(key: key);


  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null;
  }
}
