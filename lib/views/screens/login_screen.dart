import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/core/view_models/login_controller.dart';
import 'package:xsmoke/views/widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 1),
        elevation: 20,
        backgroundColor: Colors.black,
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  late SharedPreferences recorded;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: kSecondaryColor,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * .03,
                            top: MediaQuery.of(context).size.height * .03),
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 50, bottom: 20),
                              child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Welcome,",
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontFamily: "Patu",
                                            fontSize: 25,
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            "\n\nStart To Stop Smoking By Smoking",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: "Patu",
                                          fontSize: 16,
                                        )),
                                  ])),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            CustomTextFormField(
                              fieldName: "Email",
                              hintText: "Enter Your Email Here",
                              prefixIcon: Icons.email_rounded,
                              onChange: (val) {
                                Provider.of<LoginController>(context,
                                        listen: false)
                                    .setEmail(val);
                              },
                            ),
                            CustomTextFormField(
                              fieldName: "Password",
                              textObsecure: Provider.of<LoginController>(
                                      context,
                                      listen: false)
                                  .passwordObsecuring,
                              hintText: "Enter Your Password Here",
                              prefixIcon: Icons.password,
                              keyBoardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Provider.of<LoginController>(context,
                                              listen: true)
                                          .passwordObsecuring
                                      ? Icons.remove_red_eye_sharp
                                      : Icons.visibility_off,
                                  color: kSecondaryColor,
                                ),
                                onPressed: () {
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .changeObsecuringState();
                                },
                              ),
                              onChange: (val) {
                                Provider.of<LoginController>(context,
                                        listen: false)
                                    .setPassword(val);
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: RaisedButton(
                                          color: kSecondaryColor,
                                          elevation: 10,
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            if (Provider.of<LoginController>(
                                                        context,
                                                        listen: false)
                                                    .email ==
                                                "") {
                                              _showToast(context,
                                                  "Please Enter Your Email");
                                            } else if (!Provider.of<
                                                        LoginController>(
                                                    context,
                                                    listen: false)
                                                .email
                                                .contains("@gmail.com")) {
                                              _showToast(context,
                                                  "Please Enter Correct Email");
                                            } else if (Provider.of<
                                                            LoginController>(
                                                        context,
                                                        listen: false)
                                                    .Password ==
                                                "") {
                                              _showToast(context,
                                                  "Please Enter Your Password");
                                            } else {
                                              Provider.of<LoginController>(
                                                      context,
                                                      listen: false)
                                                  .login()
                                                  .then((value) {
                                                if (value == "DONE") {
                                                  bool? reco = prefs.getBool(
                                                      Provider.of<LoginController>(
                                                              context,
                                                              listen: false)
                                                          .currentUid);

                                                  print(
                                                      "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

                                                  print(Provider.of<
                                                              LoginController>(
                                                          context,
                                                          listen: false)
                                                      .currentUid);
                                                  print(reco);

                                                  print(
                                                      "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

                                                  _showToast(context, value);
                                                  Future.delayed(
                                                      Duration(seconds: 2),
                                                      () async {
                                                    reco == true
                                                        ? Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                "ControlView")
                                                        : Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                "CigratesScreen");
                                                  });
                                                } else {
                                                  _showToast(context, value);
                                                }
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "lOGIN",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  letterSpacing: 2,
                                                  fontFamily: "Patu"),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("SignUpScreen");
                              },
                              child: Center(
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "If You Don't Have Account ?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: "Patu")),
                                      TextSpan(
                                          text: " SignUp",
                                          style: TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 16,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Patu")),
                                    ])),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Provider.of<LoginController>(context, listen: false).processState
              ? Center(
                  child: CircularProgressIndicator(
                  color: kSecondaryColor,
                  backgroundColor: Colors.white,
                ))
              : SizedBox(),
        ],
      ),
    );
  }
}
