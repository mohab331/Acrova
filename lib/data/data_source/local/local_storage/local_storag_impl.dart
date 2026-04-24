import 'package:shared_preferences/shared_preferences.dart';
import 'base_local_storage.dart';

class LocalStorageImpl implements BaseLocalStorage {
  final SharedPreferences _prefs;

  const LocalStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> write<T>(String key, T value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      await _prefs.setString(key, value.toString());
    }
  }

  @override
  T? read<T>(String key) {
    final value = _prefs.get(key);
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }
}
