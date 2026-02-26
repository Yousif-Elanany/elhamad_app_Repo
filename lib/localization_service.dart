import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class LocalizationService {
  static Map<String, dynamic> _localizedValues = {};
  static String currentLang = 'ar';
  static late Box box;

  // تحميل اللغة من Hive وفتح JSON
  static Future<void> init() async {
    box = await Hive.openBox('cache');
    currentLang = box.get('lang', defaultValue: 'ar');
    await _loadJson(currentLang);
  }

  static Future<void> _loadJson(String lang) async {
    final data = await rootBundle.loadString('assets/lang/$lang.json');
    _localizedValues = json.decode(data);
    currentLang = lang;
  }

  static Future<void> changeLanguage(String lang) async {
    await _loadJson(lang);
    await box.put('lang', lang);
  }

  static String tr(String key) {
    return _localizedValues[key] ?? key;
  }

  static String getLang() => currentLang;
}
extension LocalizationExtension on String {
  String tr() => LocalizationService.tr(this);
}
