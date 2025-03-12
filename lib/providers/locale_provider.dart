import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('locale');
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
      notifyListeners();
    }
  }

  void setLocale(Locale newLocale) async {
    _locale = newLocale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', newLocale.languageCode);
  }
}
