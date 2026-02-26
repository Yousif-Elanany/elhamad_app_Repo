import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheHelper {
  static Box? _box;

  /// Initialize Hive and open the box
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('cache');
  }

  /// Save any type of data
  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await _box?.put(key, value);
  }

  /// Get data
  static dynamic getData(String key) {
    return _box?.get(key);
  }

  /// Remove a specific key
  static Future<void> removeData(String key) async {
    await _box?.delete(key);
  }

  /// Clear all data
  static Future<void> clear() async {
    await _box?.clear();
  }

  // ====== Helper functions for common data ======

  // Token
  static Future<void> saveToken(String token) async {
    await saveData(key: 'token', value: token);
  }

  static String? getToken() {
    return getData('token');
  }

  static Future<void> removeToken() async {
    await removeData('token');
  }

  // Language
  static Future<void> saveLanguage(String lang) async {
    await saveData(key: 'lang', value: lang);
  }

  static String getLanguage() {
    return getData('lang') ?? 'en';
  }

  static Future<void> removeLanguage() async {
    await removeData('lang');
  }
}
