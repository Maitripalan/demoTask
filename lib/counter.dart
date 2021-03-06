import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  var _count =0 ;
  int get getCounter {
    return _count;
  }

  set setCounter(int count) {
    _count = count;

  }

  void incrementCounter() {
    _count += 1;
    notifyListeners();
  }
}