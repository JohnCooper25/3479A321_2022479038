import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  String _userName = 'Usuario';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }

  bool _canResetCounter = true;
  bool get canResetCounter => _canResetCounter;
  set canResetCounter(bool value) {
    _canResetCounter = value;
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  void resetCounter() {
    if (_canResetCounter) {
      _counter = 0;
      notifyListeners();
    }
  }
}
