import 'package:flutter/material.dart';

class SwitchProvider with ChangeNotifier{
  SetSwitchData(bool isSwitched){
    isSwitched = !isSwitched;
    notifyListeners();
  }
  void toggleSwitch(bool isSwitched){
    isSwitched = !isSwitched;
    notifyListeners();
  }
}
