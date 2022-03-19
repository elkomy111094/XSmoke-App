import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:xsmoke/core/services/firestore_user.dart';
import 'package:xsmoke/models/user_model.dart';

import '../../conatants.dart';

class ResultScreen extends StatelessWidget {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

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
              return Scaffold(
                backgroundColor: Colors.black,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    snapShot.data["totalProgressPercentage"]! > .75
                        ? Text(
                            "Congratulations",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              fontFamily: "Cata",
                              color: kSecondaryColor,
                            ),
                          )
                        : Text(
                            "Failed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              fontFamily: "Cata",
                              color: kSecondaryColor,
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.black,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                          child: Container(
                            height: 150,
                            width: 150,
                            child: CircularPercentIndicator(
                                progressColor: Colors.white,
                                radius: 60,
                                backgroundColor: Colors.black,
                                animation: true,
                                percent:
                                    snapShot.data["totalProgressPercentage"] ??
                                        0.0,
                                curve: Curves.easeInQuad,
                                backgroundWidth: 5,
                                lineWidth: 10,
                                center: Text(
                                  snapShot.data["totalProgressPercentage"] ==
                                          null
                                      ? "0.0"
                                      : "${(snapShot.data["totalProgressPercentage"] * 100).toStringAsFixed(2)} "
                                          "%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Eczar",
                                    fontSize: 16,
                                  ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                animateFromLastPercent: true,
                                /*progressColor: Colors.black,*/
                                widgetIndicator: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 40,
                                )),
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(120),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("LungShapeScreen");
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        child: Center(
                          child: Card(
                            color: kSecondaryColor,
                            child: Center(
                              child: Text(
                                "See Your History",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cata",
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    snapShot.data["totalProgressPercentage"]! < .75
                        ? GestureDetector(
                            onTap: () async {
                              Navigator.of(context)
                                  .pushReplacementNamed("CigratesScreen");
                              await FireStoreUser().addUserToFireStore(
                                UserModel(
                                    comment: " ",
                                    userFirstLoginDate: DateTime.now(),
                                    plan: 0,
                                    currentDay: 1,
                                    precentageTotalCigarettes: 0,
                                    cigarettesAvg: 0,
                                    planTotalCigrates: 0,
                                    totalProgressPrecentage: 0.0,
                                    userId: snapShot.data["userId"],
                                    email: snapShot.data["email"],
                                    password: snapShot.data["password"],
                                    img: snapShot.data["image"],
                                    userName: snapShot.data["userName"]),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              child: Center(
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "Restart Plan",
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }
        });
  }
}
