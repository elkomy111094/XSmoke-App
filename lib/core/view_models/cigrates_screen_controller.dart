import 'package:flutter/material.dart';

class CigratesScreenController extends ChangeNotifier {
  int _avgNumOfCigrates = 0;

  int get avgNumOfCigrates => _avgNumOfCigrates;

  setavgNumOfCigrates(String num) {
    if (num.contains(",") ||
        num.contains(" ") ||
        num.isEmpty ||
        num.contains(".") ||
        num.contains("-")) {
      _avgNumOfCigrates = -1;
      print(_avgNumOfCigrates.toString());
      notifyListeners();
    } else {
      _avgNumOfCigrates = int.parse(num);
      print(_avgNumOfCigrates.toString());
      notifyListeners();
    }
  }
}
