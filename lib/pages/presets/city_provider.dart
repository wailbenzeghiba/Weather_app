import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  String _mycityName = '';
   String _mycityTemp = '';
   String _mycityCondition = '';

  String get cityName => _mycityName;
  String get temperature => _mycityTemp;
  String get condition => _mycityCondition;

  void setCityName(String cityName) {
    _mycityName = cityName;
    notifyListeners();
  }
  void setCityTemp(String temperature) {
    _mycityTemp = temperature;
    notifyListeners();
  }
  void setCityCondition(String condition) {
    _mycityCondition = condition;
    notifyListeners();
  }
}