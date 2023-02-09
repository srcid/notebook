class ConsumerTransactionModel {
  int? id;
  int consumerId;
  int value;
  DateTime datetime;

  ConsumerTransactionModel({
    this.id,
    required this.consumerId,
    required this.value,
    required this.datetime,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'consumer_id': consumerId,
      'value': value,
      'datetime': datetime.millisecondsSinceEpoch,
    };
  }

  static ConsumerTransactionModel fromJson(Map<String, Object?> json) {
    return ConsumerTransactionModel(
      id: json['id'] as int?,
      consumerId: json['consumer_id'] as int,
      value: json['value'] as int,
      datetime: DateTime.fromMillisecondsSinceEpoch(json['datetime'] as int),
    );
  }
}
