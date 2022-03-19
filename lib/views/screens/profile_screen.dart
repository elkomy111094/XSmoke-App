import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/core/view_models/profile_screen_controller.dart';

import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  void _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
        elevation: 20,
        backgroundColor: kSecondaryColor,
      ),
    );
  }

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
              backgroundColor: kMainColor,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle),
                    child: FloatingActionButton(
                      isExtended: true,
                      tooltip: "Sign Out",
                      onPressed: () async {
                        await _showDialog(context,
                            title: "Notice",
                            content: "Are You Sure That You Want To SignOut ?",
                            no: () {
                          Navigator.pop(context);
                        }, yes: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context)
                              .pushReplacementNamed("LoginScreen");
                        });
                      },
                      backgroundColor: Colors.black,
                      child: Icon(Icons.power_settings_new_outlined),
                    ),
                  ),
                ),
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 250.0,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10, left: 5, right: 5),
                            child: Card(
                              color: Colors.black87,
                              elevation: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              shadowColor: kSecondaryColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Plan Days",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Eczar",
                                                    fontSize: 14)),
                                          ])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: kMainColor,
                                                    width: 1)),
                                            child: Center(
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: snapShot.data["plan"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Patu")),
                                              ])),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 80,
                                        color: Colors.black,
                                      ),
                                      Column(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Precentage",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Eczar",
                                                    fontSize: 14)),
                                          ])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: kMainColor,
                                                    width: 1)),
                                            child: Center(
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: snapShot.data[
                                                                "totalProgressPercentage"] ==
                                                            null
                                                        ? "0.0"
                                                        : "${(snapShot.data["totalProgressPercentage"] * 100).toStringAsFixed(2)} "
                                                            "%",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Patu")),
                                              ])),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 1,
                                        height: 80,
                                        color: Colors.black,
                                      ),
                                      Column(
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: "Current Day",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Eczar",
                                                    fontSize: 14)),
                                          ])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: kMainColor,
                                                    width: 1)),
                                            child: Center(
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: snapShot
                                                        .data["currentDay"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Patu")),
                                              ])),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 100.0, right: 100),
                          ),
                          Card(
                            elevation: 20,
                            shadowColor: kSecondaryColor,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("EditScreen");
                              },
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontFamily: "Patu",
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 20,
                            shadowColor: kSecondaryColor,
                            child: GestureDetector(
                              onTap: () {
                                if (snapShot.data["currentDay"] < 30) {
                                  _showToast(context,
                                      "you should Finish plan And Your precentage Above 50 %");
                                } else {
                                  if (snapShot.data["totalProgressPercentage"] <
                                      .5) {
                                    _showToast(context,
                                        "Sorry , Your Percentage Is Less Than 50%");
                                  } else {
                                    Navigator.of(context)
                                        .pushNamed("AddCommentScreen");
                                  }
                                }
                              },
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Add Comment",
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontFamily: "Patu",
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 20,
                            shadowColor: kSecondaryColor,
                            child: GestureDetector(
                              onTap: () async {
                                await _showDialog(context,
                                    title: "Notice",
                                    content:
                                        "Are You Sure That You Want To ReStart Plan ?",
                                    no: () {
                                  Navigator.pop(context);
                                }, yes: () {
                                  Navigator.pop(context);
                                  Provider.of<ProfileScreenController>(context,
                                          listen: false)
                                      .saveUser(
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
                                  )
                                      .then((value) {
                                    Navigator.of(context)
                                        .pushReplacementNamed("CigratesScreen");
                                  });
                                });
                              }

                              /*() {
                                Provider.of<ProfileScreenController>(context,
                                        listen: false)
                                    .saveUser(
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
                                      phoneNumber: snapShot.data["phoneNumber"],
                                      userName: snapShot.data["userName"]),
                                )
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushReplacementNamed("CigratesScreen");
                                });
                              }*/
                              ,
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.restart_alt_outlined),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Restart Plan",
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontFamily: "Patu",
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/profilebg.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            snapShot.data["userName"],
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Patu",
                                fontSize: 20),
                          ),
                          padding: EdgeInsets.all(10),
                          color: kSecondaryColor.withOpacity(.5),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kMainColor, width: 1),
                              image: DecorationImage(
                                  image: NetworkImage(snapShot.data["image"]),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                  ),
                  Provider.of<ProfileScreenController>(context).processState
                      ? Center(
                          child: CircularProgressIndicator(
                          color: kSecondaryColor,
                          backgroundColor: Colors.white,
                        ))
                      : SizedBox(),
                ],
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
