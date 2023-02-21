class ClientModel {
  final int? id;
  final String name;
  final int balance;

  const ClientModel({
    this.id,
    required this.name,
    this.balance = 0,
  });

  ClientModel copyWith({int? id, String? name, int? balance}) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
    );
  }

  @override
  String toString() {
    return 'Client(id: $id, name: $name, balance: $balance)';
  }
}
