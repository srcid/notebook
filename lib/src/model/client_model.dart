import 'package:flutter/foundation.dart';

class ClientModel {
  final int? id;
  final String name;
  final int balance;

  const ClientModel({
    this.id,
    required this.name,
    this.balance = 0,
  });

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
}
