import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xsmoke/models/day_model.dart';
import 'package:xsmoke/models/user_model.dart';

class FireStoreUser {
  double? totalProgressPrecentage;
  int? plan;
  int? planTotalCigrates;
  int? cigarettesAvg;

  int currentDay = 1;

  int total = 0;
  int dayTotalSmoked = 0;
  double totalPrecentage = 0.0;

  DateTime? userFirstLoginDate;

  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Future<void> addDayToFireStore(int docId, DayModel dayModel) async {
    return await _userCollectionRef
        .doc(auth.currentUser!.uid)
        .collection("Days")
        .doc(docId.toString())
        .set(dayModel.toJson());
  }

  Future<void> updateUser(
      {required totalProgressPrecentage,
      required plan,
      required userFirstLoginDate,
      required planTotalCigrates,
      required cigarettesAvg}) async {
    _userCollectionRef.doc(auth.currentUser!.uid).set({
      "totalProgressPercentage": totalProgressPrecentage,
      "plan": plan,
      "planTotalCigrates": planTotalCigrates,
      "cigarettesAvg": cigarettesAvg,
      "userFirstLoginDate": userFirstLoginDate,
    }, SetOptions(merge: true));
  }

  getCurrentUserData() async {
    UserModel currentUser;
    return await _userCollectionRef
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      currentUser = UserModel.fromJson(value.data());
      return currentUser;
    });
  }

  updateTotalPrecentage({totalPrecentage}) {
    _userCollectionRef.doc(auth.currentUser!.uid).set({
      "totalProgressPercentage": totalPrecentage,
    }, SetOptions(merge: true));
  }

  increaseUserTotalSmokedCigrates({total, totalPrecentage}) async {
    _userCollectionRef.doc(auth.currentUser!.uid).set({
      "precentageTotalCigarettes": total,
      "totalProgressPercentage": totalPrecentage,
    }, SetOptions(merge: true));
  }

  Future setComment({comment}) async {
    await _userCollectionRef.doc(auth.currentUser!.uid).set({
      "comment": comment,
    }, SetOptions(merge: true));
  }

  increaseUserTotalSmokedCigratesInThisDay(
      {required currentDay, dayTotalSmoked}) async {
    _userCollectionRef
        .doc(auth.currentUser!.uid)
        .collection("Days")
        .doc(currentDay.toString())
        .set({
      "precentageCigrates": dayTotalSmoked,
    }, SetOptions(merge: true));
  }

  updateUserCurrentDay({currentDay}) async {
    _userCollectionRef.doc(auth.currentUser!.uid).set({
      "currentDay": currentDay,
    }, SetOptions(merge: true));
  }

  Future<void> editUser({
    required userName,
    required password,
    required img,
  }) async {
    _userCollectionRef.doc(auth.currentUser!.uid).set({
      "userName": userName,
      "password": password,
      "image": img,
    }, SetOptions(merge: true));
  }
}
