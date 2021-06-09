import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';

abstract class TransactionsRepository{
  Future<List<Transaction>> getTransactions(String id);
  Future<List<Transaction>> filterTransactions(String id, DateTime from, DateTime to);

  Future<void> createGarbageCollect(String userToken, String filterTypeId, double ammount); 
  Future<void> getGarbageCollects(String userToken, String filterTypeId, double ammount);
  Future<void> getGargagecCollectById(String recycleId);
}