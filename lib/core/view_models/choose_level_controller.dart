import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xsmoke/core/services/firestore_user.dart';
import 'package:xsmoke/core/view_models/cigrates_screen_controller.dart';
import 'package:xsmoke/models/day_model.dart';

class ChooseLevelController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  String _gValue = "Easy Plan";

  bool processState = false;

  int plan_Total_Number_Of_Cigrates = 0;
  int plan_Total_days = 30;

  String get gValue => _gValue;

  setGroupValue(String gVal) {
    _gValue = gVal;
    notifyListeners();
  }

  Future setRecorded() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(auth.currentUser!.uid.toString(), true);
    notifyListeners();
    return "Recorded";
  }

  setplan_Total_days() {
    switch (gValue) {
      case "Easy Plan":
        plan_Total_days = 90;
        break;
      case "Medium Plan":
        plan_Total_days = 60;
        break;
      case "Hard Plan":
        plan_Total_days = 30;
        break;
    }
    notifyListeners();
  }

  calculatplan_Total_daysNumberOfCigrates(BuildContext ctx) {
    plan_Total_Number_Of_Cigrates = 0;
    print(
        "/////////////////////////////////${plan_Total_days}/////////////////////////////");
    for (int i = 1; i <= plan_Total_days; i++) {
      print(
          "/////////////////////////////////${((Provider.of<CigratesScreenController>(ctx, listen: false).avgNumOfCigrates) - (i * ((Provider.of<CigratesScreenController>(ctx, listen: false).avgNumOfCigrates) / plan_Total_days)).floor())}/////////////////////////////");

      plan_Total_Number_Of_Cigrates = plan_Total_Number_Of_Cigrates +
          ((Provider.of<CigratesScreenController>(ctx, listen: false)
                  .avgNumOfCigrates) -
              (i *
                      ((Provider.of<CigratesScreenController>(ctx,
                                  listen: false)
                              .avgNumOfCigrates) /
                          plan_Total_days))
                  .floor());
      print(plan_Total_Number_Of_Cigrates);
    }
  }

  Future updateUserData(BuildContext context) async {
    try {
      processState = true;
      notifyListeners();
      await FireStoreUser().updateUser(
          userFirstLoginDate: DateTime.now(),
          cigarettesAvg:
              Provider.of<CigratesScreenController>(context, listen: false)
                  .avgNumOfCigrates,
          plan: plan_Total_days,
          planTotalCigrates: plan_Total_Number_Of_Cigrates,
          totalProgressPrecentage: 0.0);

      processState = false;

      notifyListeners();
      return "done";
    } catch (e) {
      processState = false;
      notifyListeners();
      return e.toString();
    }
  }

  setPlanDays(BuildContext ctx) {
    for (int i = 1; i <= plan_Total_days; i++) {
      FireStoreUser().addDayToFireStore(
          i,
          DayModel(
              dayId: i,
              dayAvailableCigarette:
                  Provider.of<CigratesScreenController>(ctx, listen: false)
                          .avgNumOfCigrates -
                      ((i *
                              (Provider.of<CigratesScreenController>(ctx,
                                          listen: false)
                                      .avgNumOfCigrates /
                                  plan_Total_days))
                          .floor()),
              precentageCigrates: 0,
              dayRate: 1));
    }
  }
}
