import 'package:recycle_hub/model/garbage.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';
import 'package:recycle_hub/model/transactions/user_transaction_model.dart';

abstract class TransactionsRepository {
  Future<List<UserTransaction>> getUserTransactions();

  Future<void> createGarbageCollect(
      String userToken, List<GarbageTupple> items);
  Future<List<Transaction>> getTransactions();
  Future<void> getTransactionById(String recycleId);
}
