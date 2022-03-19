import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xsmoke/conatants.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 100), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "X",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 50,
                        fontFamily: "Patu",
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: "Smoke",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Patu",
                        fontWeight: FontWeight.bold,
                      )),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(child: Image.asset("assets/images/logo.png")),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
