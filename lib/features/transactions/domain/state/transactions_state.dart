import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:recycle_hub/features/transactions/domain/model/statistic_model.dart';
import '../../../../model/transactions/user_transaction_model.dart';
import 'package:recycle_hub/features/transactions/domain/repository/repository.dart';
import 'package:recycle_hub/helpers/filter_types.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';

part 'transactions_state.g.dart';

enum StoreState { INIT, LOADING, LOADED }

class TransactionsState = TransactionsStateBase with _$TransactionsState;

abstract class TransactionsStateBase with Store {
  TransactionsStateBase(this._registrationRepository);

  final TransactionsRepository _registrationRepository;

  @observable
  ObservableFuture<List<Transaction>> _transactionsFuture;

  @observable
  List<Transaction> transactions = List<Transaction>.empty(growable: true);

  @observable
  List<StatisticModel> statisticModel =
      List<StatisticModel>.empty(growable: true);

  @observable
  String errorMessage;

  @observable
  double totalKG = 0;

  @observable
  double summ = 0;

  @computed
  StoreState get state {
    if (_transactionsFuture == null ||
        _transactionsFuture.status == FutureStatus.rejected) {
      return StoreState.INIT;
    }
    return _transactionsFuture.status == FutureStatus.pending
        ? StoreState.LOADING
        : StoreState.LOADED;
  }

  @action
  Future<List<Transaction>> getTransacts(DateTime from, DateTime to) async {
    totalKG = 0;
    summ = 0;
    try {
      errorMessage = null;
      _transactionsFuture =
          ObservableFuture(_registrationRepository.getTransactions());
      transactions = await _transactionsFuture;
      if (transactions != null && transactions != null) {
        if (transactions.isNotEmpty) {
          statisticModel != null
              ? statisticModel.clear()
              : statisticModel = List<StatisticModel>.empty(growable: true);
          var filters = await FilterTypesService().getFilters();
          filters.forEach((element) {
            var e = StatisticModel(filterType: element.copyWith(), count: 0);
            transactions.forEach((element) {
              element.items.forEach((item) {
                if (e.filterType.id == item.filterId && element.status == 'confirmed') {
                  e.count += item.amount;
                  //e.count += element.items.fold(0.0, (previousValue, element) => previousValue += element.amount);
                }
              });
            });
            if (e.count != 0) {
              statisticModel.add(e);
            }
          });
          transactions.forEach((element) {
            if (element.status == 'confirmed') {
              totalKG += element.items.fold(0.0, (previousValue, element) => previousValue += element.amount);
              summ += element.reward;
            }
          });
          return transactions;
        }
      }
      return [];
    } catch (error) {
      errorMessage = error.toString();
      return [];
    }
  }
}
