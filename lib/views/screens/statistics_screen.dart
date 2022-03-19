import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../conatants.dart';
import '../../models/day_model.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  List<charts.Series<DayModel, String>> _seriesBarData = [];
  List<DayModel>? daysList;
  _generateData(daysList) {
    _seriesBarData.add(charts.Series(
      domainFn: (DayModel day, _) => day.dayId.toString(),
      measureFn: (DayModel day, _) => day.precentageCigrates,
      colorFn: (DayModel day, _) =>
          charts.ColorUtil.fromDartColor(kSecondaryColor),
      id: "chart",
      data: daysList,
      labelAccessorFn: (DayModel day, _) => day.dayId.toString(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Your Records"),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return StreamBuilder(
        stream: _userCollectionRef
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Days")
            .orderBy("dayId", descending: true)
            .snapshots(),
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
              List<DayModel> days = [];
              snapshot.data.docs.forEach((day) {
                days.add(DayModel.fromJson(day.data() as Map<String, dynamic>));
              });

              print(days);
              return Scaffold(
                backgroundColor: kMainColor,
                body: BuildChart(context, days),
              );
            } else {
              return LinearProgressIndicator();
            }
          }
        });
  }

  BuildChart(BuildContext context, List<DayModel> days) {
    daysList = days;
    _generateData(daysList);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Days Number / Smoked Cigarettes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cata"),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  vertical: false,
                  animationDuration: Duration(seconds: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
