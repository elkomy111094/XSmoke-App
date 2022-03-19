class DayModel {
  int? dayId;
  int? dayAvailableCigarette;
  int? precentageCigrates;
  int? dayRate;

  DayModel(
      {required this.dayId,
      required this.dayAvailableCigarette,
      required this.precentageCigrates,
      required this.dayRate});

  DayModel.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    dayId = map["dayId"];
    dayAvailableCigarette = map["dayAvailableCigarette"];
    precentageCigrates = map["precentageCigrates"];
    dayRate = map["dayRate"];
  }

  Map<String, dynamic> toJson() {
    return {
      "dayId": dayId,
      "dayAvailableCigarette": dayAvailableCigarette,
      "precentageCigrates": precentageCigrates,
      "dayRate": dayRate,
    };
  }
}
