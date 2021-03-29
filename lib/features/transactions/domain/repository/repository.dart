import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';

abstract class TransactionsRepository{
  Future<Transactions> getTransactions(String id);
  Future<Transactions> filterTransactions(String id, DateTime from, DateTime to);
}