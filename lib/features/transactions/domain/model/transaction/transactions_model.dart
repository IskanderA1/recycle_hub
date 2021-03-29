import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:recycle_hub/features/transactions/domain/model/transaction/transaction_model.dart';

@HiveType(typeId: 15)
class Transactions {
  @HiveField(0)
  List<Transaction> list;
  @HiveField(1)
  String error;
  Transactions({
    @required this.list,
    @required this.error,
  });

  Transactions.empty(String error)
      : list = List<Transaction>.empty(),
        this.error = error;

  Map<String, dynamic> toMap() {
    return {
      'list': json.encode(List<dynamic>.from(list.map((x) => x.toJson()))),
      'error': error,
    };
  }

  factory Transactions.fromMap(List data, String error) {
    return Transactions(
      list: List<Transaction>.from(
            data.map((x) => Transaction.fromJson(x))),
      error: error,
    );
  }
}
