import 'package:flutter/material.dart';

class Constants {
  static bool isTesting = false;
  static const int passExpCode = 4;
  static const String supirUsername = "Ghifar";
  static const String supirPassword = "hovvir-7kipqe-cubquH";
  static const int passWrongCode = 3;
  static const String passWrong = 'Password Wrong';
  static const String passExpString = 'Password Expired';
  static int dataIntervalTimerInSeconds = 30;
  static DateTimeRange defaultDateTimeRange = DateTimeRange(
    end: DateTime.now().add(Duration(days: 1)),
    start: DateTime.now().subtract(Duration(days: 3)),
  );
}
