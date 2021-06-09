import 'dart:convert';

import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/features/transactions/data/api/service/service.dart';
import '../../../../model/transactions/user_transaction_model.dart';

class ApiUtil {
  ApiTransactionsService _pokemonService;
  ApiUtil(this._pokemonService);

  Future<List<UserTransaction>> getUserTrensactions() async {
    try {
      final response = await CommonRequest.makeRequest('transactions');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return List<UserTransaction>.from(data.map((e) {
          return UserTransaction.fromMap(e);
        }));
      } else {
        throw Exception("Не удалось загрузить историю транзакций");
      }
    } catch (error) {
      print("ERROR: ${error.toString()}");
      rethrow;
    }
  }
}
