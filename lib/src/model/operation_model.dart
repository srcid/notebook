class OperationModel {
  final int? id;
  final int clientId;
  final int value;
  final DateTime datetime;

  const OperationModel({
    this.id,
    required this.clientId,
    required this.value,
    required this.datetime,
  });

  OperationModel copyWith({
    int? id,
    int? clientId,
    int? value,
    DateTime? datetime,
  }) {
    return OperationModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      value: value ?? this.value,
      datetime: datetime ?? this.datetime,
    );
  }

  toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'value': value,
      'datetime': datetime.millisecondsSinceEpoch,
    };
  }

  factory OperationModel.fromMap(map) {
    return OperationModel(
      id: map['id'],
      clientId: map['client_id'],
      value: map['value'],
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime']),
    );
  }
}
