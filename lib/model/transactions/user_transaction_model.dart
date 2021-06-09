// To parse this JSON data, do
//
//     final userTransaction = userTransactionFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'user_transaction_model.g.dart';

@HiveType(typeId: 17)
class UserTransaction {
  UserTransaction({
    this.id,
    this.actionType,
    this.actionId,
    this.ecoCoins,
    this.status,
    this.date,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String actionType;
  @HiveField(2)
  String actionId;
  @HiveField(3)
  int ecoCoins;
  @HiveField(4)
  String status;
  @HiveField(5)
  DateTime date;

  UserTransaction copyWith({
    String id,
    String actionType,
    String actionId,
    int ecoCoins,
    String status,
    DateTime date,
  }) =>
      UserTransaction(
        id: id ?? this.id,
        actionType: actionType ?? this.actionType,
        actionId: actionId ?? this.actionId,
        ecoCoins: ecoCoins ?? this.ecoCoins,
        status: status ?? this.status,
        date: date ?? this.date,
      );

  factory UserTransaction.fromJson(String str) =>
      UserTransaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTransaction.fromMap(Map<String, dynamic> json) => UserTransaction(
        id: json["id"],
        actionType: json["action_type"],
        actionId: json["action_id"],
        ecoCoins: json["eco_coins"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "action_type": actionType,
        "action_id": actionId,
        "eco_coins": ecoCoins,
        "status": status,
        "date": date.toIso8601String(),
      };
}
