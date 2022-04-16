class HistoryNotes {
  late int datetime;
  late int spendAmount;
  String spendNote = '';

  HistoryNotes(this.datetime, this.spendAmount, this.spendNote);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['datetime'] = datetime;
    map['spendAmount'] = spendAmount;
    map['spendNote'] = spendNote;
    return map;
  }

  HistoryNotes.fromMap(Map<String, dynamic> map) {
    datetime = map['datetime'];
    spendAmount = map['spendAmount'];
    spendNote = map['spendNote'];
  }
}
