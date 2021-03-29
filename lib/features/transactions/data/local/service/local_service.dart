import 'package:hive/hive.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';

class LocalService{
  static const _BOX_NAME = 'transactions';
  static const _KEY_NAME = 'transactions';

  Box _box;
  LocalService() {
    _openBox();
  }

  _openBox() async {
    _box = await Hive.openBox(_BOX_NAME);
  }

  Future<Transactions> getTransactions() async {
    if (!_box.isOpen) {
      _box = await Hive.openBox(_BOX_NAME);
    }
    var transacts = _box.get(_KEY_NAME, defaultValue: null);
    return transacts;
  }

  Future<void> putTransactions(Transactions transactions) async {
    if (!_box.isOpen) {
      _box = await Hive.openBox(_BOX_NAME);
    }
    await _box.put(_KEY_NAME, transactions);
  }
}