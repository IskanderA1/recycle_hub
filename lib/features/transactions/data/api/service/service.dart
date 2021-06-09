import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';

class ApiTransactionsService {
  static const _BASE_URL = 'https://167.172.105.146:5000/api/';

  final Dio _dio = Dio(BaseOptions(baseUrl: _BASE_URL));

  Future<List<Transaction>> getTransactions(String id) async {
    try {
      final response = await CommonRequest.makeRequest('transactions');
      ;
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        var transacts = List<Transaction>.from(data?.map((e)=>Transaction.fromMap(e)));
        return transacts;
      } else
        throw Exception("Не удалось загрузить транзакции");
    } catch (error) {
      rethrow;
    }
  }

  /*Future<Transaction> createNewGarbageCollect(String tokenFromQr) async {
    try {
      final response = await CommonRequest.makeRequest('recycle', body: {
        {
          "user_token": "string",
          "rec_point_id": "string",
          "filter_type": "string",
          "amount": 0
        }
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var transact = Transaction.fromMap(data);
        return /*Future.delayed(Duration(seconds: 2),()=> */ transact;
      } else
        throw Exception("Не удалось загрузить транзакции");
    } catch (error) {
      rethrow;
    }
  }*/
}
