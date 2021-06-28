// To parse this JSON data, do
//
//     final transaction = transactionFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

///@HiveType(typeId: 7)
class Transaction {
    Transaction({
        this.id,
        this.recPointId,
        this.items,
        this.reward,
        this.status,
        this.date,
    });

    String id;
    String recPointId;
    List<Item> items;
    int reward;
    String status;
    DateTime date;

    Transaction copyWith({
        String id,
        String recPointId,
        List<Item> items,
        int reward,
        String status,
        DateTime date,
    }) => 
        Transaction(
            id: id ?? this.id,
            recPointId: recPointId ?? this.recPointId,
            items: items ?? this.items,
            reward: reward ?? this.reward,
            status: status ?? this.status,
            date: date ?? this.date,
        );

    factory Transaction.fromJson(String str) => Transaction.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["id"] == null ? null : json["id"],
        recPointId: json["rec_point_id"] == null ? null : json["rec_point_id"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        reward: json["reward"] == null ? null : json["reward"],
        status: json["status"] == null ? null : json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "rec_point_id": recPointId == null ? null : recPointId,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
        "reward": reward == null ? null : reward,
        "status": status == null ? null : status,
        "date": date == null ? null : date.toIso8601String(),
    };
}

class Item {
    Item({
        this.filterId,
        this.filterName,
        this.amount,
    });

    String filterId;
    String filterName;
    double amount;

    Item copyWith({
        String filterId,
        String filterName,
        double amount,
    }) => 
        Item(
            filterId: filterId ?? this.filterId,
            filterName: filterName ?? this.filterName,
            amount: amount ?? this.amount,
        );

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        filterId: json["filter_id"] == null ? null : json["filter_id"],
        filterName: json["filter_name"] == null ? null : json["filter_name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "filter_id": filterId == null ? null : filterId,
        "filter_name": filterName == null ? null : filterName,
        "amount": amount == null ? null : amount,
    };
}
