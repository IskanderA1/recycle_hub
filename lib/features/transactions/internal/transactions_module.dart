import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/features/transactions/internal/repository_module.dart';

class TransactionsModule {
  static getModule() {
    return TransactionsState(RepositoryModule.getModule());
  }
}
