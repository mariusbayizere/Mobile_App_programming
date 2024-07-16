// ------------------------------------outside

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;

  static const _keyThemeMode = 'themeMode';
  static const _keySortOrder = 'sortOrder';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setThemeMode(String themeMode) async {
    await _preferences.setString(_keyThemeMode, themeMode);
  }

  static String? getThemeMode() {
    return _preferences.getString(_keyThemeMode);
  }

  static Future setSortOrder(String sortOrder) async {
    await _preferences.setString(_keySortOrder, sortOrder);
  }

  static String? getSortOrder() {
    return _preferences.getString(_keySortOrder);
  }
}
