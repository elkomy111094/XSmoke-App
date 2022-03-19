import 'package:flutter/cupertino.dart';
import 'package:xsmoke/core/services/firestore_user.dart';

class HomeScreenController extends ChangeNotifier {
  String? currentDay;
  int? num;

  bool showmenu = false;

  int plantotalSmokeCigareets = 0;
  int dayTotalSmokedCigrates = 0;
  int totalplanCigarettes = 0;

  showMenu() {
    showmenu = true;
    notifyListeners();
  }

  hideMenu() {
    showmenu = false;
    notifyListeners();
  }

  Future increaseTotalSmokedCigarettes({num, totalplanCigarettes}) async {
    double totalPrecentage = num * (1 / totalplanCigarettes);
    await FireStoreUser().increaseUserTotalSmokedCigrates(
        total: num, totalPrecentage: totalPrecentage);
  }

  Future icreaseCigarettesSmokedInThisDay({currentDay, num}) async {
    await FireStoreUser().increaseUserTotalSmokedCigratesInThisDay(
        currentDay: currentDay, dayTotalSmoked: num);
  }

  Future update(
      {currentDay,
      plantotalSmokeCigareets,
      dayTotalSmokedCigrates,
      totalplanCigarettes}) async {
    await icreaseCigarettesSmokedInThisDay(
            currentDay: currentDay, num: dayTotalSmokedCigrates)
        .then((value) async {
      await increaseTotalSmokedCigarettes(
          num: plantotalSmokeCigareets,
          totalplanCigarettes: totalplanCigarettes);
    });
  }

  setUserCurrentDay(int currentday) async {
    await FireStoreUser().updateUserCurrentDay(currentDay: currentday);
  }
}
