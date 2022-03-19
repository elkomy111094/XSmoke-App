import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xsmoke/models/activity.dart';

import '../../conatants.dart';

class ActivitiesScreen extends StatelessWidget {
  List<Activity> tips = [];
  final CollectionReference _activitiesCollectionRef =
      FirebaseFirestore.instance.collection("Activities");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _activitiesCollectionRef.snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((ActivityData) {
              tips.add(Activity.fromJson(
                  ActivityData.data() as Map<String, dynamic>));
            });

            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Activities And Tips",
                    style: TextStyle(fontFamily: "Patu", letterSpacing: 1),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  elevation: 0,
                ),
                body: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Card(
                          elevation: 20,
                          shadowColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            width: double.infinity,
                            child: Card(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side:
                                      BorderSide(width: 1, color: kMainColor)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (tips[index].title.toString()),
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 18,
                                          fontFamily: "Eczar"),
                                    ),
                                    Divider(
                                      color: kMainColor,
                                      height: 25,
                                      thickness: 2,
                                    ),
                                    Text(
                                      (tips[index]).desc.toString(),
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: "Eczar"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, int) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Divider(
                          color: kSecondaryColor,
                          thickness: 1,
                        ),
                      );
                    },
                    itemCount: tips.length));
          } else {
            return SizedBox();
          }
        }
      },
    );
  }
}
