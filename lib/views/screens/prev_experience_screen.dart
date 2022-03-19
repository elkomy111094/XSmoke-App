import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/models/user_model.dart';

class PrevExperience extends StatelessWidget {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  List<UserModel> users = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userCollectionRef.where("comment", isNotEqualTo: " ").get(),
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
              snapShot.data.docs.forEach((user) {
                users.add(
                    UserModel.fromJson(user.data() as Map<String, dynamic>));
              });

              print(users);

              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Center(
                                child: Text(
                                  "Users Experience",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      fontFamily: "Eczar"),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: kMainColor,
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/winner.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50))),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: Container(
                                    height: 260,
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 20,
                                      shadowColor: kSecondaryColor,
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 70,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                            color: kMainColor,
                                                            width: 1,
                                                          ),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  users[index]
                                                                      .img
                                                                      .toString()),
                                                              fit: BoxFit
                                                                  .contain)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          users[index]
                                                              .userName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing: 1,
                                                              fontFamily:
                                                                  "Patu",
                                                              fontSize: 16),
                                                        ),
                                                        Text(
                                                          "Cigarettes Avg : ${users[index].cigarettesAvg}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing: 1,
                                                              fontFamily:
                                                                  "Patu",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 30,
                                                  backgroundColor: Colors.black,
                                                  progressColor:
                                                      Colors.redAccent,
                                                  animation: true,
                                                  percent: users[index]
                                                          .totalProgresPrecentage ??
                                                      0.0,
                                                  curve: Curves.easeInQuad,
                                                  backgroundWidth: 2,
                                                  lineWidth: 5,
                                                  center: Text(
                                                    users[index].totalProgresPrecentage ==
                                                            null
                                                        ? "0.0"
                                                        : "${(users[index].totalProgresPrecentage! * 100).toStringAsFixed(2)} "
                                                            "%",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Eczar",
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  animateFromLastPercent: true,
                                                  /*progressColor: Colors.black,*/
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  users[index]
                                                      .comment
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Patu",
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, int) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: users.length),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          }
        });
  }
}
