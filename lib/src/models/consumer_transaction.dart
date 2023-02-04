class ConsumerTransaction {
  int? id;
  int consumerId;
  int value;
  DateTime datetime;

  ConsumerTransaction({
    this.id,
    required this.consumerId,
    required this.value,
    required this.datetime,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'consumerId': consumerId,
      'value': value,
      'datetime': datetime.millisecondsSinceEpoch,
    };
  }

  static ConsumerTransaction fromJson(Map<String, Object?> json) {
    return ConsumerTransaction(
      id: json['id'] as int?,
      consumerId: json['consumerId'] as int,
      value: json['value'] as int,
      datetime: DateTime.fromMillisecondsSinceEpoch(json['datetime'] as int),
    );
  }
}
