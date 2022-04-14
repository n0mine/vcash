class HistoryNotes {
  int? id;
  late String data;

  HistoryNotes(this.id, this.data);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['data'] = data;
    return map;
  }

  HistoryNotes.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    data = map['data'];
  }
}
