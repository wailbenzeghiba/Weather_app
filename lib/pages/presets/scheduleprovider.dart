import 'package:flutter/material.dart';

class Scheduleprovider with ChangeNotifier
{
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
 TimeOfDay get time => _time;

 void setscheduleTime(TimeOfDay newTime)
 {
   _time = newTime;
   notifyListeners();
 }
 
}