import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  static String getString(String key, {String? defValue}) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static bool getBoolean(String key, {bool? defValue}) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setString(String key, String value) {
    return _prefsInstance?.setString(key, value) ?? Future.value(false);
  }

  static Future<bool> setBoolean(String key, bool value) {
    return _prefsInstance?.setBool(key, value) ?? Future.value(false);
  }
}
