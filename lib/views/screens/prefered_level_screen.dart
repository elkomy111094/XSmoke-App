import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/core/view_models/cigrates_screen_controller.dart';
import 'package:xsmoke/views/screens/choose_level_screen.dart';

import '../../conatants.dart';

class PredferdLevelScreen extends StatefulWidget {
  @override
  _PredferdLevelScreenState createState() => _PredferdLevelScreenState();
}

class _PredferdLevelScreenState extends State<PredferdLevelScreen> {
  String prefLevelText = "";
  int prefLevelNum = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return ChooseLevelScreen();
      }));
    });

    if (Provider.of<CigratesScreenController>(context, listen: false)
            .avgNumOfCigrates <
        20) {
      prefLevelText = "Hard";
      prefLevelNum = 30;
    } else if (Provider.of<CigratesScreenController>(context, listen: false)
                .avgNumOfCigrates >
            20 &&
        Provider.of<CigratesScreenController>(context, listen: false)
                .avgNumOfCigrates <
            50) {
      prefLevelText = "Medium";
      prefLevelNum = 60;
    } else {
      prefLevelText = "Easy";
      prefLevelNum = 90;
    }
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    Container(
                      width: 200,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.75),
                      ),
                      child: Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: prefLevelText,
                                  style: TextStyle(
                                    color: kSecondaryColor,
                                    fontFamily: "Patu",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontSize: 30,
                                  )),
                            ])),
                      ),
                    ),
                    SizedBox(height: 30),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Is Preferd Plan To Treat",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Patu",
                                  fontSize: 25,
                                  letterSpacing: 1)),
                        ])),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Divider(
                        color: Colors.black,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          border: Border.all(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            prefLevelNum.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Patu"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Day \n\nTreatment \n\n Plan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Patu",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2)),
                        ])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
