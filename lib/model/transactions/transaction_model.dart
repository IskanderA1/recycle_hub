// To parse this JSON data, do
//
//     final transaction = transactionFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 7)
class Transaction {
  Transaction({
    this.id,
    this.recPointId,
    this.filterId,
    this.filterName,
    this.amount,
    this.reward,
    this.status,
    this.date,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String recPointId;
  @HiveField(2)
  String filterId;
  @HiveField(3)
  String filterName;
  @HiveField(4)
  double amount;
  @HiveField(5)
  int reward;
  @HiveField(6)
  String status;
  @HiveField(7)
  DateTime date;

  Transaction copyWith({
    String id,
    String recPointId,
    String filterId,
    String filterName,
    double amount,
    int reward,
    String status,
    DateTime date,
  }) =>
      Transaction(
        id: id ?? this.id,
        recPointId: recPointId ?? this.recPointId,
        filterId: filterId ?? this.filterId,
        filterName: filterName ?? this.filterName,
        amount: amount ?? this.amount,
        reward: reward ?? this.reward,
        status: status ?? this.status,
        date: date ?? this.date,
      );

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        recPointId: json["rec_point_id"],
        filterId: json["filter_id"],
        filterName: json["filter_name"],
        amount: json["amount"],
        reward: json["reward"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rec_point_id": recPointId,
        "filter_id": filterId,
        "filter_name": filterName,
        "amount": amount,
        "reward": reward,
        "status": status,
        "date": date.toIso8601String(),
      };
}
