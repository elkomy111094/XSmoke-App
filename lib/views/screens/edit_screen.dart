import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/conatants.dart';
import 'package:xsmoke/views/widgets/custom_textformfield.dart';

import '../../core/view_models/edit_screen_controller.dart';

class EditScreen extends StatelessWidget {
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
                    Provider.of<EditScreenController>(context, listen: false)
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
                    Provider.of<EditScreenController>(context, listen: false)
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
        Provider.of<EditScreenController>(context, listen: false).userName;
    String password =
        Provider.of<EditScreenController>(context, listen: false).password;
    String confirmPassword =
        Provider.of<EditScreenController>(context, listen: false)
            .confirmPassword;
    var img = Provider.of<EditScreenController>(context, listen: true).image;

/*
    if (Provider.of<SignUpController>(context, listen: false).existEmail) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email Is Already Used"),
      ));
    }
*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                              Provider.of<EditScreenController>(context,
                                      listen: false)
                                  .setUserName(val);
                            },
                            hintText: "Enter Your Name",
                          ),
                          CustomTextFormField(
                            fieldName: "Password",
                            hintText: "********",
                            textObsecure: Provider.of<EditScreenController>(
                                    context,
                                    listen: true)
                                .passwordObsecuring,
                            prefixIcon: Icons.password,
                            keyBoardType: TextInputType.visiblePassword,
                            onChange: (val) {
                              Provider.of<EditScreenController>(context,
                                      listen: false)
                                  .setPassword(val);
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                Provider.of<EditScreenController>(context,
                                            listen: true)
                                        .passwordObsecuring
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.visibility_off,
                                color: kSecondaryColor,
                              ),
                              onPressed: () {
                                Provider.of<EditScreenController>(context,
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
                              Provider.of<EditScreenController>(context,
                                      listen: false)
                                  .conFirmPassword(val);
                            },
                            keyBoardType: TextInputType.visiblePassword,
                            textObsecure: Provider.of<EditScreenController>(
                                    context,
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
                                            Provider.of<EditScreenController>(
                                                    context,
                                                    listen: false)
                                                .resetPassword(password)
                                                .then((value) {
                                              Provider.of<EditScreenController>(
                                                      context,
                                                      listen: false)
                                                  .UploadProfileImage(
                                                img,
                                              )
                                                  .then((valueY) {
                                                Provider.of<EditScreenController>(
                                                        context,
                                                        listen: false)
                                                    .editUserData(userName,
                                                        password, valueY)
                                                    .then((value) {
                                                  Provider.of<EditScreenController>(
                                                          context,
                                                          listen: false)
                                                      .reset();
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          "ControlView");
                                                });
                                              });
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            "Edit",
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
          Provider.of<EditScreenController>(context).processState
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
