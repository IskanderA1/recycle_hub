import 'package:recycle_hub/features/transactions/data/transactions_data_repository.dart';
import 'package:recycle_hub/features/transactions/internal/api_module.dart';
import 'package:recycle_hub/features/transactions/internal/local_module.dart';

class RepositoryModule {
  static TransactionsDataRepository _transactionsDataRepository;

  static TransactionsDataRepository getModule() {
    if (_transactionsDataRepository == null) {
      _transactionsDataRepository = TransactionsDataRepository(
          ApiModule.getModule(), LocalModule.getModule());
    }
    return _transactionsDataRepository;
  }
}
