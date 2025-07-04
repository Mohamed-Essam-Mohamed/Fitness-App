import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();
  // Instance of secure storage
  static SecureStorageHelper? _instance;

  static SecureStorageHelper get instance {
    _instance ??= SecureStorageHelper._();
    return _instance!;
  }

  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  final FlutterSecureStorage _storage =
      FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<void> saveSecure({required String key, required String? value}) async =>
      await _storage.write(key: key, value: value);

  Future<String?> getSecure({required String key}) async => await _storage.read(key: key);

  Future<void> deleteSecure({required String key}) async =>
      await _storage.delete(key: key);

  Future<void> clearAll() async => await _storage.deleteAll();
}
