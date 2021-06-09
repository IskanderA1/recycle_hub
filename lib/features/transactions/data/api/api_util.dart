import 'package:recycle_hub/features/transactions/data/api/service/service.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';

class ApiUtil {
  ApiTransactionsService _pokemonService;
  ApiUtil(this._pokemonService);

  Future<List<Transaction>> getTransaction(String id) async {
    try {
      final transactions = await _pokemonService.getTransactions(id);
      return transactions;
    } catch (error) {
      rethrow;
    }
  }
}
