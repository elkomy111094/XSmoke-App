import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/core/view_models/cigrates_screen_controller.dart';

class CigratesScreen extends StatelessWidget {
  _showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 1),
        elevation: 20,
        backgroundColor: kSecondaryColor,
      ),
    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "How Many\nCigrates That You Smoke Per Day ?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Patu",
                                  fontSize: 25,
                                )),
                          ])),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 75,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: kSecondaryColor,
                              autofocus: true,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Patu",
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                Provider.of<CigratesScreenController>(context,
                                        listen: false)
                                    .setavgNumOfCigrates(val);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          color: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: IconButton(
                            onPressed: () {
                              if (Provider.of<CigratesScreenController>(context,
                                          listen: false)
                                      .avgNumOfCigrates ==
                                  -1) {
                                _showToast(context,
                                    "Please Enter An Correct Integer Number");
                              } else if (Provider.of<CigratesScreenController>(
                                              context,
                                              listen: false)
                                          .avgNumOfCigrates <
                                      1 ||
                                  Provider.of<CigratesScreenController>(context,
                                              listen: false)
                                          .avgNumOfCigrates >
                                      288) {
                                _showToast(context, "This Not Actual Number");
                              } else {
                                Navigator.of(context).pushNamed("PrefLevel");
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
