import 'package:recycle_hub/features/transactions/data/api/api_util.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';
import 'package:recycle_hub/features/transactions/domain/repository/repository.dart';

import 'local/service/local_service.dart';

class TransactionsDataRepository extends TransactionsRepository {
  final ApiUtil apiUtil;
  final LocalService localService;
  TransactionsDataRepository(this.apiUtil, this.localService);

  @override
  Future<Transactions> getTransactions(String id) async {
    try {
      var transacts = await localService.getTransactions();
      if (transacts != null) return transacts;
      transacts = await apiUtil.getTransaction(id);
      //localService.putTransactions(transacts);
      return transacts;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Transactions> filterTransactions(
      String id, DateTime from, DateTime to) async {
    try {
      var transacts = await localService.getTransactions();
      if (transacts == null){
        transacts = await apiUtil.getTransaction(id);
      }
      //transacts.list = transacts.
      return transacts;
    } catch (error) {
      rethrow;
    }
  }
}
