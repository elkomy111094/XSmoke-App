import 'package:flutter/cupertino.dart';

class LungShapeController extends ChangeNotifier {
  String path = "assets/images/1.png";

  String getLungShape(double percentage) {
    if (percentage < .1) {
      path = "assets/images/1.png";
      notifyListeners();
      return "assets/images/1.png";
    } else if (percentage < .2) {
      path = "assets/images/2.png";
      notifyListeners();
      return "assets/images/2.png";
    } else if (percentage < .3) {
      path = "assets/images/3.png";
      notifyListeners();
      return "assets/images/3.png";
    } else if (percentage < .4) {
      path = "assets/images/4.png";
      notifyListeners();
      return "assets/images/4.png";
    } else if (percentage < .5) {
      path = "assets/images/5.png";
      notifyListeners();
      return "assets/images/5.png";
    } else if (percentage < .6) {
      path = "assets/images/6.png";
      notifyListeners();
      return "assets/images/6.png";
    } else if (percentage < .7) {
      path = "assets/images/7.png";
      notifyListeners();
      return "assets/images/7.png";
    } else if (percentage < .8) {
      path = "assets/images/8.png";
      notifyListeners();
      return "assets/images/8.png";
    } else if (percentage < .9) {
      path = "assets/images/9.png";
      notifyListeners();
      return "assets/images/9.png";
    } else {
      path = "assets/images/10.png";
      notifyListeners();
      return "assets/images/10.png";
    }
  }
}
