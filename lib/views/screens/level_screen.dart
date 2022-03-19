import 'package:flutter/material.dart';

import '../../conatants.dart';

class ChooseLevelScreen extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kSecondaryColor, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Easy",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontFamily: "Patu",
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
                            text: "Is Preferd Level To Treat",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Patu",
                                fontSize: 25,
                                letterSpacing: 2)),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Divider(
                      color: Colors.white,
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "90",
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
                                color: Colors.black,
                                fontFamily: "Patu",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2)),
                      ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
