import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/core/view_models/home_screen_controller.dart';
import 'package:xsmoke/views/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMenu = false;
  int? currentDay;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");
  int num = 0;

  _showDialog(BuildContext context,
      {String title = "",
      String content = "",
      void Function()? yes,
      void Function()? no}) {
    var dialog = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "patu",
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: kSecondaryColor,
          fontFamily: "patu",
        ),
      ),
      elevation: 20,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: EdgeInsets.all(10),
      actions: [
        Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: GestureDetector(
            onTap: no,
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green, width: 2)),
              child: Center(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ),
          shadowColor: Colors.green,
        ),
        Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: GestureDetector(
            onTap: yes,
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red)),
              child: Center(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
          shadowColor: Colors.red,
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _userCollectionRef
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(.5),
              child: Center(
                  child: CircularProgressIndicator(
                color: kSecondaryColor,
                backgroundColor: Colors.white,
              )),
            );
          } else {
            currentDay = DateTime.now()
                    .difference((snapShot.data["userFirstLoginDate"]).toDate())
                    .inDays +
                1;

            Provider.of<HomeScreenController>(context, listen: false)
                .setUserCurrentDay(currentDay!);

            return snapShot.hasData
                ? FutureBuilder(
                    future: _userCollectionRef
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("Days")
                        .doc(currentDay.toString())
                        .get(),
                    builder: (context, AsyncSnapshot daySnapShot) {
                      if (daySnapShot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white.withOpacity(.5),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: kSecondaryColor,
                            backgroundColor: Colors.white,
                          )),
                        );
                      } else {
                        if (daySnapShot.hasData) {
                          return currentDay! < 30
                              ? Scaffold(
                                  backgroundColor: Colors.white,
                                  floatingActionButton: FloatingActionButton(
                                    onPressed: () {
                                      if (daySnapShot
                                              .data["dayAvailableCigarette"] >
                                          daySnapShot
                                              .data["precentageCigrates"]) {
                                        Provider.of<HomeScreenController>(
                                                context,
                                                listen: false)
                                            .update(
                                                currentDay: currentDay,
                                                dayTotalSmokedCigrates:
                                                    daySnapShot.data[
                                                            "precentageCigrates"] +
                                                        1,
                                                plantotalSmokeCigareets: (snapShot
                                                            .data[
                                                        "precentageTotalCigarettes"]) +
                                                    1,
                                                totalplanCigarettes: snapShot
                                                    .data["planTotalCigrates"]);
                                      } else if (daySnapShot
                                              .data["precentageCigrates"] >
                                          2 *
                                                  daySnapShot.data[
                                                      "dayAvailableCigarette"] -
                                              2) {
                                      } else {
                                        _showDialog(context,
                                            title: "Notice",
                                            content:
                                                "Smoking More Than ${daySnapShot.data["dayAvailableCigarette"]} Will Decrease Your total Progress Health",
                                            no: () {
                                          Navigator.of(context).pop();
                                        }, yes: () {
                                          Provider.of<HomeScreenController>(
                                                  context,
                                                  listen: false)
                                              .update(
                                                  currentDay: currentDay,
                                                  dayTotalSmokedCigrates:
                                                      daySnapShot.data[
                                                              "precentageCigrates"] +
                                                          1,
                                                  plantotalSmokeCigareets:
                                                      (snapShot.data[
                                                              "precentageTotalCigarettes"]) -
                                                          1,
                                                  totalplanCigarettes:
                                                      snapShot.data[
                                                          "planTotalCigrates"])
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        });
                                      }
                                    },
                                    backgroundColor: kSecondaryColor,
                                    elevation: 20,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "assets/images/fbicon.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  body: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 130.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Hi ${snapShot.data["userName"]},",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Cata",
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0, top: 5),
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  child:
                                                      CircularPercentIndicator(
                                                          radius: 60,
                                                          backgroundColor:
                                                              Colors.black,
                                                          animation: true,
                                                          percent: snapShot
                                                                      .data[
                                                                  "totalProgressPercentage"] ??
                                                              0.0,
                                                          curve:
                                                              Curves.easeInQuad,
                                                          backgroundWidth: 5,
                                                          lineWidth: 10,
                                                          center: Text(
                                                            snapShot.data[
                                                                        "totalProgressPercentage"] ==
                                                                    null
                                                                ? "0.0"
                                                                : "${(snapShot.data["totalProgressPercentage"] * 100).toStringAsFixed(2)} "
                                                                    "%",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Cata",
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          circularStrokeCap:
                                                              CircularStrokeCap
                                                                  .round,
                                                          animateFromLastPercent:
                                                              true,
                                                          /*progressColor: Colors.black,*/
                                                          widgetIndicator: Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 40,
                                                          )),
                                                  foregroundDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      120),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 2)),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Your Total Health Progress",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Cata",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    color: kSecondaryColor,
                                                    height: 1,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 30,
                                                        horizontal: 10),
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                    shadowColor:
                                                        kSecondaryColor,
                                                    color: Colors.black,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Number Of Cigrates For This Day",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Cata",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              (daySnapShot.data[
                                                                      "dayAvailableCigarette"])
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2,
                                                                fontFamily:
                                                                    "Patu",
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(
                                                          color: kMainColor,
                                                        ),
                                                        Text(
                                                          "Total Smoked Cigareetes In This Day",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Cata",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white),
                                                          child: Center(
                                                            child: Text(
                                                              (daySnapShot.data[
                                                                      "precentageCigrates"])
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2,
                                                                fontFamily:
                                                                    "Patu",
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 25),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Text(
                                                    "Day",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      letterSpacing: 3,
                                                      fontFamily: "Cata",
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 70,
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: kSecondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 5)),
                                                child: Center(
                                                  child: Text(
                                                    currentDay
                                                        .toString()
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 2,
                                                      fontFamily: "Patu",
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 35,
                                              left: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Provider.of<HomeScreenController>(
                                                          context,
                                                          listen: false)
                                                      .showMenu();
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/menu.png",
                                                      color: Colors.white,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 25,
                                              right: 10,
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapShot
                                                                .data["image"]),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Provider.of<HomeScreenController>(context)
                                                  .showmenu ==
                                              true
                                          ? Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    color: Colors.transparent,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .4),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(25),
                                                                          bottomRight:
                                                                              Radius.circular(25),
                                                                        )),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(20.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Provider.of<HomeScreenController>(context, listen: false).hideMenu();
                                                                              Navigator.of(context).pushNamed("ActivitiesScreen");
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Center(
                                                                                  child: Text(
                                                                                "Activities",
                                                                                style: TextStyle(
                                                                                  color: kSecondaryColor,
                                                                                  fontFamily: "Patu",
                                                                                  fontSize: 18,
                                                                                ),
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(20.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Provider.of<HomeScreenController>(context, listen: false).hideMenu();
                                                                              Navigator.of(context).pushNamed("LungShapeScreen");
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50,
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Center(
                                                                                  child: Text(
                                                                                "Lung Shape",
                                                                                style: TextStyle(
                                                                                  color: kSecondaryColor,
                                                                                  fontFamily: "Patu",
                                                                                  fontSize: 18,
                                                                                ),
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(20.0),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Provider.of<HomeScreenController>(context, listen: false).hideMenu();
                                                                              Navigator.of(context).pushNamed("ReadMoreScreen");
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 50,
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Center(
                                                                                  child: Text(
                                                                                "Read More...",
                                                                                style: TextStyle(
                                                                                  color: kSecondaryColor,
                                                                                  fontFamily: "Patu",
                                                                                  fontSize: 18,
                                                                                ),
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              200,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                70,
                                                                            width:
                                                                                70,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: kSecondaryColor,
                                                                              borderRadius: BorderRadius.circular(70),
                                                                            ),
                                                                            child:
                                                                                IconButton(
                                                                              icon: Icon(
                                                                                Icons.power_settings_new_outlined,
                                                                                color: Colors.white,
                                                                              ),
                                                                              onPressed: () async {
                                                                                await _showDialog(context, title: "Notice", content: "Are You Sure That You Want To SignOut ?", no: () {
                                                                                  Navigator.pop(context);
                                                                                }, yes: () async {
                                                                                  Provider.of<HomeScreenController>(context, listen: false).hideMenu();
                                                                                  await FirebaseAuth.instance.signOut();
                                                                                  Navigator.of(context).pushReplacementNamed("LoginScreen");
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ))),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1.18,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Provider.of<HomeScreenController>(
                                                                context,
                                                                listen: false)
                                                            .hideMenu();
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 5),
                                                            color: Colors.black,
                                                            shape: BoxShape
                                                                .circle),
                                                        height: 70,
                                                        width: 70,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                )
                              : ResultScreen();
                        } else {
                          return SizedBox();
                        }
                      }
                    })
                : SizedBox();
          }
        },
      ),
    );
  }
}
