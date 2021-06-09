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
  List<Transaction> transactions;

  @observable
  List<StatisticModel> statisticModel;

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
  Future<List<UserTransaction>> getTransacts(String id) async {
    if (id == null) {
      errorMessage = "Идентификатор null";
      return [];
    }
    try {
      errorMessage = null;
      _transactionsFuture =
          ObservableFuture(_registrationRepository.getTransactions(id));
      transactions = await _transactionsFuture;
      if (transactions != null && transactions != null) {
        if (transactions.isNotEmpty) {
          List<StatisticModel> statistic =
              List<StatisticModel>.empty(growable: true);
          var filters = await FilterTypesService().getFilters();
          var rnd = Random();
          filters.forEach((element) {
            statistic.add(StatisticModel(
                filterType: element.copyWith(),
                count: rnd.nextInt(100).toDouble()));
          });
          statistic = statistic.map((e) {
            transactions.forEach((element) {
              totalKG += element.amount;
              summ += element.reward;
              if (e.filterType.id == element.id) {
                e.count += element.amount;
              }
            });
            if (e.count != 0) {
              return e;
            }
          }).toList();
          this.statisticModel = statistic;
        }
      }
    } catch (error) {
      errorMessage = error.toString();
    }
  }
}
