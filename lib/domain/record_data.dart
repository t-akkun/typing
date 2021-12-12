class RecordData {
  final String id;
  final DateTime recordDate;
  final int score;
  final int missType;
  final double speed;

  RecordData(
      {required this.id,
      required this.recordDate,
      required this.score,
      required this.missType,
      required this.speed});

  factory RecordData.fromMap(Map<String, dynamic> json) {
    return RecordData(
      id: json['id'],
      recordDate: DateTime.fromMillisecondsSinceEpoch(json['recordDate']),
      score: json['score'],
      missType: json['missType'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recordDate': recordDate.millisecondsSinceEpoch,
      'score': score,
      'missType': missType,
      'speed': speed,
    };
  }

  static RecordData createEmpty() {
    return RecordData(
        id: "", recordDate: DateTime.now(), score: 0, missType: 0, speed: 0);
  }
}
