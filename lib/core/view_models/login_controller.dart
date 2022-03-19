import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool passwordObsecuring = true;
  String _email = "";
  String _Password = "";
  bool processState = false;

  String currentUid = "";

  setCurrentUid(String uid) {
    currentUid = uid;
    notifyListeners();
  }

  setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  setPassword(String value) {
    _Password = value;
    notifyListeners();
  }

  reset() {
    setEmail("");
    setPassword("");
  }

  String get Password => _Password;

  String get email => _email;

  changeObsecuringState() {
    passwordObsecuring = !passwordObsecuring;
    notifyListeners();
  }

  Future login() async {
    print(email);
    print(Password);

    try {
      processState = true;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: email, password: Password)
          .then((value) {
        setCurrentUid(value.user!.uid);
      });
      processState = false;
      notifyListeners();
      reset();
      return "DONE";
    } on FirebaseAuthException catch (e) {
      processState = true;
      if (e.code == 'user-not-found') {
        processState = false;
        notifyListeners();
        return "This User Not Found , please Sign Up Now";
      } else if (e.code == 'wrong-password') {
        processState = false;
        notifyListeners();
        return "You Entered InCorrect Password";
      }
    } catch (e) {
      processState = false;
      notifyListeners();
      return e.toString();
    }
  }
}
