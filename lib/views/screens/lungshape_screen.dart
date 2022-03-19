import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/core/view_models/lungshape_screen_controller.dart';

import '../../conatants.dart';
import '../../models/day_model.dart';

class LungShapeScreen extends StatelessWidget {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  final CollectionReference _daysCollectionRef = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Days");

  List<DayModel> prevDays = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          if (snapShot.hasData) {
            Provider.of<LungShapeController>(context, listen: false)
                .getLungShape(snapShot.data["totalProgressPercentage"]);
            return Scaffold(
              backgroundColor: kMainColor,
              appBar: AppBar(
                title: Text(
                  "You Lung Shape ",
                  style: TextStyle(fontFamily: "Patu", letterSpacing: 1),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Current Lung Shape",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Cata",
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Card(
                          elevation: 20,
                          shadowColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200)),
                          child: Container(
                            height: 220,
                            width: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.asset(
                                    Provider.of<LungShapeController>(context,
                                            listen: true)
                                        .path,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Last Days History",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          fontFamily: "Cata",
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: _daysCollectionRef
                              .orderBy("dayId", descending: false)
                              .get(),
                          builder: (context, AsyncSnapshot daySnapShot) {
                            if (snapShot.connectionState ==
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
                                daySnapShot.data.docs.forEach((day) {
                                  if (day.data()["precentageCigrates"] != 0) {
                                    prevDays.add(DayModel.fromJson(
                                        day.data() as Map<String, dynamic>));
                                  } else {}
                                });
                                return Container(
                                  height: 270,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 250,
                                              color: Colors.red,
                                            ),
                                            Card(
                                                elevation: 20,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                color: (prevDays[index]
                                                            .precentageCigrates! >
                                                        prevDays[index]
                                                            .dayAvailableCigarette!)
                                                    ? Colors.red
                                                    : Colors.green,
                                                child: Container(
                                                  height: 200,
                                                  width: 200,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Avaialabe Cigarettes",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Cata"),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    prevDays[
                                                                            index]
                                                                        .dayAvailableCigarette
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "Eczar",
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Smoked Cigarettes",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Cata"),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                child: Center(
                                                                  child: Text(
                                                                    prevDays[
                                                                            index]
                                                                        .precentageCigrates
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "Eczar",
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Positioned(
                                              top: 0,
                                              left: 65,
                                              child: Card(
                                                elevation: 20,
                                                color: kSecondaryColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            75)),
                                                child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  child: Center(
                                                    child: Text(
                                                      prevDays[index]
                                                          .dayId
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily: "Eczar",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, int) {
                                        return SizedBox(
                                          width: 20,
                                        );
                                      },
                                      itemCount: prevDays.length),
                                );
                              } else {
                                return SizedBox();
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }
      },
    );
  }
}
