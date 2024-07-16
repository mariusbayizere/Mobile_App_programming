import 'package:flutter/material.dart';
import '../utils/preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider()
      : _themeMode = Preferences.getThemeMode() == 'dark'
            ? ThemeMode.dark
            : ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Preferences.setThemeMode(isDarkMode ? 'dark' : 'light');
    print(
        'Theme mode changed: ${_themeMode == ThemeMode.dark ? 'dark' : 'light'}'); // Log theme change
    notifyListeners();
  }
}
