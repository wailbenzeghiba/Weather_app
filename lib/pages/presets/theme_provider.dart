import 'package:flutter/material.dart';
 
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();
  bool isSwitched = false;
 
  ThemeData get themeData => _themeData;
 
  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    isSwitched = !isSwitched;
    notifyListeners();
  }
  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      setThemeData(ThemeData.dark());
    } else {
      setThemeData(ThemeData.light());
    }
  }
} 