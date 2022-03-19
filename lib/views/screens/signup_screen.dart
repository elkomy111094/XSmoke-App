import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/models/user_model.dart';
import 'package:xsmoke/views/widgets/custom_textformfield.dart';

import '../../core/view_models/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  void _showToast(BuildContext context, String msg) {
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

  pickImage(BuildContext context) {
    var dialog = AlertDialog(
      backgroundColor: kSecondaryColor,
      title: Text(
        "Pich Image From :",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "patu",
        ),
      ),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Divider(
              color: Colors.white,
              thickness: 3,
              height: 1,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Card(
                elevation: 20,
                shadowColor: Colors.black,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Galary",
                    style: TextStyle(
                      fontSize: 25,
                      color: kSecondaryColor,
                      fontFamily: "patu",
                    ),
                  ),
                  onTap: () {
                    Provider.of<SignUpController>(context, listen: false)
                        .getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(),
              child: Card(
                elevation: 20,
                shadowColor: Colors.black,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 25,
                      color: kSecondaryColor,
                      fontFamily: "patu",
                    ),
                  ),
                  onTap: () {
                    Provider.of<SignUpController>(context, listen: false)
                        .getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    String? userName =
        Provider.of<SignUpController>(context, listen: false).userName;
    String email = Provider.of<SignUpController>(context, listen: false).email;
    String password =
        Provider.of<SignUpController>(context, listen: false).password;
    String confirmPassword =
        Provider.of<SignUpController>(context, listen: false).confirmPassword;

    var img = Provider.of<SignUpController>(context, listen: true).image;

    bool existance =
        Provider.of<SignUpController>(context, listen: false).existEmail;

/*
    if (Provider.of<SignUpController>(context, listen: false).existEmail) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email Is Already Used"),
      ));
    }
*/

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          color: kSecondaryColor,
                          elevation: 10,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("LoginScreen");
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 20,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 30, bottom: 20),
                              child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Create Account,",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Patu",
                                          fontSize: 25,
                                          letterSpacing: 1.5,
                                        )),
                                    TextSpan(
                                        text: "\n\nTo Continue Login . . .",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: "Patu",
                                          fontSize: 16,
                                        )),
                                  ])),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150),
                            ),
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(100)),
                              child: img == null
                                  ? IconButton(
                                      onPressed: () async {
                                        await pickImage(context);
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await pickImage(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: Image.file(img).image,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          CustomTextFormField(
                            fieldName: "UserName",
                            keyBoardType: TextInputType.text,
                            prefixIcon: Icons.person,
                            onChange: (val) {
                              Provider.of<SignUpController>(context,
                                      listen: false)
                                  .setUserName(val);
                            },
                            hintText: "Enter Your Name",
                          ),
                          CustomTextFormField(
                            fieldName: "Email",
                            hintText: "Eslam@gmail.com",
                            prefixIcon: Icons.email_rounded,
                            onChange: (val) {
                              Provider.of<SignUpController>(context,
                                      listen: false)
                                  .setEmail(val);
                            },
                          ),
                          CustomTextFormField(
                            fieldName: "Password",
                            hintText: "********",
                            textObsecure: Provider.of<SignUpController>(context,
                                    listen: true)
                                .passwordObsecuring,
                            prefixIcon: Icons.password,
                            keyBoardType: TextInputType.visiblePassword,
                            onChange: (val) {
                              Provider.of<SignUpController>(context,
                                      listen: false)
                                  .setPassword(val);
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                Provider.of<SignUpController>(context,
                                            listen: true)
                                        .passwordObsecuring
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.visibility_off,
                                color: kSecondaryColor,
                              ),
                              onPressed: () {
                                Provider.of<SignUpController>(context,
                                        listen: false)
                                    .changeObsecuringState();
                              },
                            ),
                          ),
                          CustomTextFormField(
                            fieldName: "Confirm Password",
                            hintText: "********",
                            prefixIcon: Icons.password,
                            onChange: (val) {
                              Provider.of<SignUpController>(context,
                                      listen: false)
                                  .conFirmPassword(val);
                            },
                            keyBoardType: TextInputType.visiblePassword,
                            textObsecure: Provider.of<SignUpController>(context,
                                    listen: true)
                                .passwordObsecuring,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: RaisedButton(
                                        color: Colors.black,
                                        elevation: 10,
                                        onPressed: () async {
                                          if (img == null) {
                                            _showToast(context,
                                                "Please Choose Image For Your Profile");
                                          } else if (userName == null ||
                                              userName == "" ||
                                              userName.startsWith(" ")) {
                                            _showToast(
                                                context, "Name Is Empty");
                                          } else if (userName.length > 25) {
                                            _showToast(context,
                                                "Name should be Less Than 25 Character");
                                          } else if (email == null ||
                                              email == "") {
                                            _showToast(
                                                context, "email Is Empty");
                                          } else if (!email
                                              .contains("@gmail.com")) {
                                            _showToast(
                                                context, "Enetr Correct Email");
                                          } else if (existance) {
                                            _showToast(context,
                                                "Enetr Already Exist Email");
                                          } else if (password == null ||
                                              password == "") {
                                            _showToast(
                                                context, "Password Is Empty");
                                          } else if (password.length < 8 ||
                                              password.length > 15) {
                                            _showToast(context,
                                                "Enter password from 8 to 15 Character");
                                          } else if (confirmPassword == null ||
                                              confirmPassword == "") {
                                            _showToast(context,
                                                "Confirmation Password Is Empty");
                                          } else if (confirmPassword !=
                                              password) {
                                            _showToast(
                                                context, "Confirmation Error");
                                          } else {
                                            Provider.of<SignUpController>(
                                                    context,
                                                    listen: false)
                                                .createEmailAndPassword(
                                                    email, password)
                                                .then((valueX) {
                                              if (valueX == false) {
                                                _showToast(context,
                                                    "Email Is Already Exist");
                                              } else {
                                                Provider.of<SignUpController>(
                                                        context,
                                                        listen: false)
                                                    .UploadProfileImage(
                                                  img,
                                                )
                                                    .then((valueY) {
                                                  Provider.of<SignUpController>(
                                                          context,
                                                          listen: false)
                                                      .saveUser(
                                                    UserModel(
                                                        comment: " ",
                                                        userFirstLoginDate:
                                                            DateTime.now(),
                                                        plan: 0,
                                                        currentDay: 1,
                                                        precentageTotalCigarettes:
                                                            0,
                                                        cigarettesAvg: 0,
                                                        planTotalCigrates: 0,
                                                        totalProgressPrecentage:
                                                            0.0,
                                                        userId: Provider.of<
                                                                    SignUpController>(
                                                                context,
                                                                listen: false)
                                                            .userCredential
                                                            .user!
                                                            .uid,
                                                        email: email,
                                                        password: password,
                                                        img: valueY,
                                                        userName: userName),
                                                  );
                                                }).then((value) {
                                                  _showToast(context,
                                                      "Account Created Successfuly");

                                                  Future.delayed(
                                                      Duration(seconds: 2), () {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            "LoginScreen");
                                                  });
                                                });
                                              }
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            "SignUp",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                fontFamily: "Patu"),
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Provider.of<SignUpController>(context).processState
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
