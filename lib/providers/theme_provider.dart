import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Optional for saving theme preference

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _themeMode = isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
