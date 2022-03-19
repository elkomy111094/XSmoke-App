import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:xsmoke/core/services/firestore_user.dart';

class EditScreenController extends ChangeNotifier {
  String imgName = "xxx";
  var _image;
  bool passwordObsecuring = true;
  String _userName = "";
  String _password = "";
  String _confirmPassword = "";
  final imgPicker = ImagePicker();
  bool processState = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  setUserName(String? name) {
    _userName = name!;
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

  changeObsecuringState() {
    passwordObsecuring = !passwordObsecuring;
    notifyListeners();
  }

  reset() {
    _userName = "";

    _password = "";

    _confirmPassword = "";
    _image = null;
    notifyListeners();
  }

  get image => _image; //should import dart.io

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

  Future resetPassword(String password) async {
    try {
      processState = true;
      notifyListeners();

      await FirebaseAuth.instance.currentUser!
          .updatePassword(password)
          .then((value) async {
        AuthCredential credential = EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email.toString(),
            password: password);
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
// show the snackbar here
    }
  }

  Future editUserData(String userName, String password, String img) async {
    await FireStoreUser()
        .editUser(userName: userName, password: password, img: img);
    processState = false;
    notifyListeners();
  }
}
