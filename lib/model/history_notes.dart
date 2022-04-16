class HistoryNotes {
  late int id;
  late int datetime;
  late int spendAmount;
  String spendNote = '';

  HistoryNotes(this.id, this.datetime, this.spendAmount, this.spendNote);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['datetime'] = datetime;
    map['spendAmount'] = spendAmount;
    map['spendNote'] = spendNote;
    return map;
  }

  HistoryNotes.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    datetime = map['datetime'];
    spendAmount = map['spendAmount'];
    spendNote = map['spendNote'];
  }
}
