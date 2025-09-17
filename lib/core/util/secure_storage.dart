import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'enum_initialization.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  SecureStorageHelper._();

  static final SecureStorageHelper _instance = SecureStorageHelper._();

  static SecureStorageHelper get instance => _instance;

  writeData({required CachingKey key, required value}) async {
    debugPrint("Saving => $value -- with key => ${key.value}");
    await _storage.write(key: key.value, value: jsonEncode(value));
  }

  // Future<dynamic> read({required CachingKey key}) async {
  //   String? value = await _storage.read(key: key.value);
  //   if (value != null && value.isNotEmpty) {
  //     try {
  //       return jsonDecode(value);
  //     } catch (e) {
  //       debugPrint("Error decoding JSON for key ${key.value}: $e");
  //       return value;
  //     }
  //   }
  //   return null;
  // }

  Future<dynamic> read({required CachingKey key}) async {
    try {
      String? value = await _storage.read(key: key.value);
      if (value!.isNotEmpty) {
        try {
          return jsonDecode(value);
        } catch (e) {
          debugPrint("Error decoding JSON for key ${key.value}: $e");
          return value;
        }
      }
      return null;
    } catch (e) {
      // Handle decryption errors or other platform exceptions
      debugPrint("SecureStorage read error for key ${key.value}: $e");

      // Optional: delete the corrupted key to avoid repeating the error
      await _storage.delete(key: key.value);

      return null;
    }
  }

  clear() async {
    await _storage.deleteAll();
  }

  logout() async {
    await _storage.delete(key: CachingKey.refreshToken.value);
    await _storage.delete(key: CachingKey.token.value);

    clear();
  }

  remove({required CachingKey key}) async {
    await _storage.delete(key: key.value);
  }
}
