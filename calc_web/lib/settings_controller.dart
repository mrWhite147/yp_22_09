import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  final SharedPreferences _prefs;
  
  SettingsController(this._prefs) {
    _themeMode = _prefs.getString('theme') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    _lastFromCurrency = _prefs.getString('from_currency') ?? 'RUB';
    _lastToCurrency = _prefs.getString('to_currency') ?? 'USD';
  }

  late ThemeMode _themeMode;
  late String _lastFromCurrency;
  late String _lastToCurrency;

  ThemeMode get themeMode => _themeMode;
  String get lastFromCurrency => _lastFromCurrency;
  String get lastToCurrency => _lastToCurrency;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _prefs.setString('theme', _themeMode.name);
    notifyListeners();
  }

  void saveCurrencyPair(String from, String to) {
    _lastFromCurrency = from;
    _lastToCurrency = to;
    _prefs.setString('from_currency', from);
    _prefs.setString('to_currency', to);
  }
}