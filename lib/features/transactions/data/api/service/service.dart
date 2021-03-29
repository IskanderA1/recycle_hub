import 'package:dio/dio.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';

class ApiTransactionsService {

  static const _BASE_URL = 'http://eco.loliallen.com';
  static const _ENDPOINT = '/api/recycle';

  final Dio _dio = Dio(BaseOptions(baseUrl: _BASE_URL));

  Future<Transactions> getTransactions(String id) async {
    try {
      final response =
          await _dio.get(_BASE_URL + _ENDPOINT/* + "?id=" + id + "&type=user"*/);
      if (response.statusCode == 200) {
        var transact = Transactions.fromMap(response.data, "");
        return /*Future.delayed(Duration(seconds: 2),()=> */transact;
      } else
        throw Exception("Не удалось загрузить транзакции");
    } catch (error) {
      rethrow;
    }
  }
}
