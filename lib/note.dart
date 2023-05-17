class Note {
  int? id;
  late String title;
  late String description;

  Note(this.title, [this.description = '']);

  int? get getid => id;

  String get getname => title;

  set setname(String value) {
    title = value;
  }

  String get getdescription => description;

  set setdescription(String value) {
    if (value.length <= 255) {
      description = value;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['name'] = title;
    map['desc'] = description;

    return map;
  }

  Note.toNote(Map<String, dynamic> map) {
    id = map['id'];
    description = map['desc'];
    title = map['name'];
  }
}
