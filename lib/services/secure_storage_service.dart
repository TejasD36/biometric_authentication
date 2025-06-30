import '../core.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService _instance = SecureStorageService._();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static SecureStorageService get instance => _instance;

  Future<void> write(String key, dynamic value) async {
    String stringValue = value.toString();
    await _storage.write(key: key, value: stringValue);
  }

  Future<T?> read<T>(String key) async {
    String? value = await _storage.read(key: key);
    if (value == null) return null;

    // Convert the value back to the appropriate type
    if (T == int) return int.tryParse(value) as T?;
    if (T == double) return double.tryParse(value) as T?;
    if (T == bool) return (value.toLowerCase() == 'true') as T?;
    if (T == String) return value as T;

    throw UnsupportedError('Type $T is not supported');
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  Future<bool> containsKey(String key) async {
    String? value = await _storage.read(key: key);
    return value != null;
  }
}
