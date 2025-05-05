import 'dart:convert';

import 'package:basic_project_template/core/services/storage/storage/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageService<T> extends StorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<T?> read(String key) async {
    try {
      final encodedValue = await _storage.read(key: key);
      if (encodedValue == null) return null;
      return jsonDecode(encodedValue) as T?;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> write(String key, dynamic value) async {
    final encodedValue = jsonEncode(value);
    return _storage.write(key: key, value: encodedValue);
  }

  @override
  Future<void> clear() => _storage.deleteAll();

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}
