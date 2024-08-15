import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode _appTheme = ThemeMode.light;
  ThemeMode get appTheme => _appTheme;

  MyProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('appTheme');
    if (theme != null) {
      _appTheme = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    _appTheme = themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'appTheme', themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }
}
