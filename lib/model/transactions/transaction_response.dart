import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'transaction_model.dart';

class TransactionsResponse {
  List<TransactionModel> transactions;
  String error;
  TransactionsResponse({
    @required this.transactions,
    @required this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactions': transactions.map((x) => x.toMap()).toList(),
      'error': error,
    };
  }

  TransactionsResponse.fromJson(var source) {
    Map<String, dynamic> map = json.decode(source);
    this.transactions = List<TransactionModel>.from(
        map['transactions']?.map((x) => TransactionModel.fromMap(x)));
    this.error = map['error'];
  }

  TransactionsResponse.withError(String err)
      : this.transactions = null,
        this.error = err;

  @override
  String toString() =>
      'TransactionResponse(transactions: $transactions, error: $error)';
}

class TransactionsResponseOk extends TransactionsResponse {
  TransactionsResponseOk(var data) : super.fromJson(data);
}

class TransactionsResponseError extends TransactionsResponse {
  TransactionsResponseError(String err) : super.withError(err);
}
