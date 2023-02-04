class Consumer {
  int? id;
  String name;
  int balance;

  Consumer(this.id, {required this.name, this.balance = 0});

  static Consumer fromJson(Map<String, Object?> consumerMap) {
    return Consumer(
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
