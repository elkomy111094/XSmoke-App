import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/core/view_models/choose_level_controller.dart';

import '../../conatants.dart';

class ChooseLevelScreen extends StatelessWidget {
  _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 1),
        elevation: 20,
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/levelbg.jpg",
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: kMainColor.withOpacity(.75),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Choose\n Level Of Treatment ?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Patu",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 2)),
                        ])),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //------------------------------------------
                    Container(
                      height: 50,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.white),
                        child: RadioListTile(
                            value: "Easy Plan",
                            activeColor: kSecondaryColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Easy",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontFamily: "Patu",
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: kSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "90",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Patu"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Day  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                          fontFamily: "Patu",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            groupValue:
                                Provider.of<ChooseLevelController>(context)
                                    .gValue,
                            onChanged: (val) {
                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setGroupValue(val.toString());

                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setplan_Total_days();
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.white),
                        child: RadioListTile(
                            value: "Medium Plan",
                            activeColor: kSecondaryColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Medium",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontFamily: "Patu",
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: kSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "60",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Patu"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Day  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                          fontFamily: "Patu",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            groupValue:
                                Provider.of<ChooseLevelController>(context)
                                    .gValue,
                            onChanged: (val) {
                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setGroupValue(val.toString());
                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setplan_Total_days();
                              ;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.white),
                        child: RadioListTile(
                            value: "Hard Plan",
                            activeColor: kSecondaryColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontFamily: "Patu",
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: kSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "30",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Patu"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Day  ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 18,
                                          fontFamily: "Patu",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            groupValue:
                                Provider.of<ChooseLevelController>(context)
                                    .gValue,
                            onChanged: (val) {
                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setGroupValue(val.toString());
                              Provider.of<ChooseLevelController>(context,
                                      listen: false)
                                  .setplan_Total_days();
                              ;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: RaisedButton(
                                  color: Colors.black,
                                  elevation: 10,
                                  onPressed: () async {
                                    Provider.of<ChooseLevelController>(context,
                                            listen: false)
                                        .calculatplan_Total_daysNumberOfCigrates(
                                            context);
                                    Provider.of<ChooseLevelController>(context,
                                            listen: false)
                                        .setPlanDays(context);
                                    Provider.of<ChooseLevelController>(context,
                                            listen: false)
                                        .updateUserData(context)
                                        .then((value) {
                                      if (value == "done") {
                                        Provider.of<ChooseLevelController>(
                                                context,
                                                listen: false)
                                            .setPlanDays(context);
                                        Provider.of<ChooseLevelController>(
                                                context,
                                                listen: false)
                                            .setRecorded()
                                            .then((value) {
                                          if (value == "Recorded") {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    "ControlView");
                                          } else {
                                            _showToast(context,
                                                "Your Plan Not Res=corded Yet");
                                          }
                                        });
                                      } else {
                                        _showToast(context, value);
                                      }
                                    });
                                    /*Navigator.of(context)
                                        .pushNamed("ControlView");*/
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      "START",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          fontFamily: "Patu"),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Provider.of<ChooseLevelController>(context, listen: false)
                  .processState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                  backgroundColor: Colors.white,
                ))
              : SizedBox(),
        ],
      ),
    );
  }
}
