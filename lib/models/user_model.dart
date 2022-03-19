class UserModel {
  String? userId, userName, email, password, img;

  int? plan;
  double? totalProgresPrecentage;
  int? planTotalCigrates;

  int? cigarettesAvg;
  int? precentageTotalCigarettes;
  int? currentDay;
  String? comment;

  DateTime? userFirstLoginDate;

  UserModel(
      {required this.userId,
      required this.userFirstLoginDate,
      required this.comment,
      required this.userName,
      required this.currentDay,
      required this.precentageTotalCigarettes,
      required this.email,
      required this.password,
      required this.img,
      required plan,
      required cigarettesAvg,
      required totalProgressPrecentage,
      required planTotalCigrates});

  UserModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    userId = map["userId"];
    userFirstLoginDate = (map["userFirstLoginDate"]).toDate();
    userName = map["userName"];
    currentDay = map["currentDay"];
    email = map["email"];
    password = map["password"];

    img = map["image"];
    plan = map["plan"];
    comment = map["comment"];
    cigarettesAvg = map["cigarettesAvg"];
    totalProgresPrecentage = map["totalProgressPercentage"];
    planTotalCigrates = map["planTotalCigrates"];
    precentageTotalCigarettes = map["precentageTotalCigarette"];
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "email": email,
      "password": password,
      "image": img,
      "currentDay": currentDay,
      "plan": plan,
      "comment": comment,
      "totalProgressPercentage": totalProgresPrecentage,
      "planTotalCigrates": planTotalCigrates,
      "cigarettesAvg": cigarettesAvg,
      "precentageTotalCigarettes": precentageTotalCigarettes,
      "userFirstLoginDate": userFirstLoginDate,
    };
  }
}
