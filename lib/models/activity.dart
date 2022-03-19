class Activity {
  String? Id;
  String? title;
  String? desc;

  Activity({this.Id, this.title, this.desc});

  Activity.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    Id = map["id"];
    title = map["title"];
    desc = map["desc"];
  }
}
