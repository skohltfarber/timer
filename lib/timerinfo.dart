import 'package:flutter/material.dart';

class TimerInfo extends ChangeNotifier {
  int _timeLeft = 60;
  int getTimeLeft() => _timeLeft;

  void setTimeLeft({int time}) {
    _timeLeft = time;
    notifyListeners();
  }

  void updateTimeLeft() {
    if (_timeLeft > 0) {
      _timeLeft--;
      notifyListeners();
    }
  }
}