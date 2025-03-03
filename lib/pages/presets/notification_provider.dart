import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  bool _isNotifOn = false;

  bool get isNotifOn=> _isNotifOn;

  void initNotification() {
    // Initialization code if needed
  }

  void setNotifications() {
    _isNotifOn = !_isNotifOn;
    notifyListeners();
  }

  void toggleNotif() {
    if (_isNotifOn == false) {
      _isNotifOn = true;
    } else {
      _isNotifOn = false;
    }
    notifyListeners();
  }
}