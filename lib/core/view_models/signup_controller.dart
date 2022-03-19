import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:xsmoke/core/services/firestore_user.dart';
import 'package:xsmoke/models/user_model.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  String imgName = "xxx";

  bool passwordObsecuring = true;
  bool processState = false;

  String _userName = "";
  String _email = "";

  String _password = "";
  String _confirmPassword = "";
  var _image;

  bool existEmail = false;

  setUserName(String? name) {
    _userName = name!;
    notifyListeners();
  }

  setEmail(String? myEmail) {
    _email = myEmail!;
    notifyListeners();
  }

  setPassword(String? myPassword) {
    _password = myPassword!;
    notifyListeners();
  }

  conFirmPassword(String? myConfirmation) {
    _confirmPassword = myConfirmation!;
    notifyListeners();
  }

  String get userName => _userName;

  String get email => _email;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  get image => _image; //should import dart.io

  final imgPicker = ImagePicker(); //import image_picker

  changeObsecuringState() {
    passwordObsecuring = !passwordObsecuring;
    notifyListeners();
  }

  reset() {
    _userName = "";
    _email = "";
    _password = "";

    _confirmPassword = "";
    _image = File("");
    notifyListeners();
  }

  Future getImage(ImageSource src) async {
    int random = Random().nextInt(10000000);
    final picked = await imgPicker.getImage(
        source: src); //beacuse it Take aDuration for Picking
    if (picked != null) {
      _image = File(picked.path);
      imgName = basename("$random${picked.path}");
    }
    notifyListeners();
  }

  Future createEmailAndPassword(String email, String password) async {
    bool success = true;

    try {
      processState = true;
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      success = false;
      processState = false;
      if (e.code == "weak-password") {
        print("It Is Sooo Weak PassWord");
      } else if (e.code == "email-already-in-use") {
        processState = false;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return success;
  }

  Future UploadProfileImage(var img) async {
    print("staaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaart");

    var refStorage = /*FirebaseStorage.instance.ref("images/$imgName");*/ FirebaseStorage
        .instance
        .ref()
        .child("myImages")
        .child("$imgName");

    await refStorage.putFile(img);
    var url = await refStorage.getDownloadURL();
    print(
        "2222222222222222222222222222222222222222222222222222222222222222222");
    print(url);

    return url;
  }

  Future saveUser(UserModel user) async {
    await FireStoreUser().addUserToFireStore(user);
    reset();
    processState = false;
    notifyListeners();
  }
}
