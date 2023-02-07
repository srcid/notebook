class ConsumerModel {
  int? id;
  String name;
  int balance;

  ConsumerModel(this.id, {required this.name, this.balance = 0});

  static ConsumerModel fromJson(Map<String, Object?> consumerMap) {
    return ConsumerModel(
      consumerMap['id'] as int?,
      name: consumerMap['name'] as String,
      balance: consumerMap['balance'] as int,
    );
  }

  Map<String, Object?> toJson() => {'id': id, 'name': name, 'balance': balance};

  @override
  String toString() {
    return '''Consumer(
      id: ${id}, 
      name: ${name}, 
      balance: ${balance})
    ''';
  }
}
