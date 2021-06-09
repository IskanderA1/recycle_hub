import 'package:recycle_hub/model/transactions/transaction_model.dart';

import '../../../../model/transactions/user_transaction_model.dart';

abstract class TransactionsRepository{
  Future<List<UserTransaction>> getUserTransactions();

  Future<void> createGarbageCollect(String userToken, String filterTypeId, double ammount); 
  Future<List<Transaction>> getTransactions();
  Future<void> getTransactionById(String recycleId);
}