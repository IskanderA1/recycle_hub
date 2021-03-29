import 'package:mobx/mobx.dart';
import 'package:recycle_hub/features/transactions/domain/model/statistic_model.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';
import 'package:recycle_hub/features/transactions/domain/repository/repository.dart';

part 'transactions_state.g.dart';

enum StoreState { INIT, LOADING, LOADED }

class TransactionsState = TransactionsStateBase with _$TransactionsState;

abstract class TransactionsStateBase with Store {
  TransactionsStateBase(this._registrationRepository);

  final TransactionsRepository _registrationRepository;

  @observable
  ObservableFuture<Transactions> _transactionsFuture;

  @observable
  Transactions transactions;

  @observable
  StatisticModel statisticModel;

  @observable
  String errorMessage;

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
  Future<Transactions> getTransacts(String id) async {
    if (id == null) {
      errorMessage = "Идентификатор null";
      return Transactions.empty("Идентификатор null");
    }
    try {
      errorMessage = null;
      _transactionsFuture =
          ObservableFuture(_registrationRepository.getTransactions(id));
      transactions = await _transactionsFuture;
      if (transactions != null && transactions.list != null) {
        if (transactions.list.isNotEmpty) {
          double paperKG = 0,
              plasticKG = 0,
              glassKG = 0,
              othodyKG = 0,
              garbageKG = 0,
              othersKG = 0,
              totalKG = 0;
          double summ = 0;
          transactions.list.forEach((element) {
            totalKG += element.ammount;
            summ += 15.5;
            if (element.filterType.varName == 'bumaga' ||
                element.filterType.varName == 'karton') {
              paperKG += element.ammount;
            } else if (element.filterType.varName == 'plastic') {
              plasticKG += element.ammount;
            } else if (element.filterType.varName == 'steklo') {
              glassKG += element.ammount;
            } else if (element.filterType.varName == 'othody') {
              othodyKG += element.ammount;
            } else if (element.filterType.varName == 'musor') {
              garbageKG += element.ammount;
            } else {
              othersKG += element.ammount;
            }
          });
          statisticModel = StatisticModel(
              paperKG: paperKG,
              plasticKG: plasticKG,
              glassKG: glassKG,
              othodyKG: othodyKG,
              garbageKG: garbageKG,
              othersKG: othersKG,
              totalKG: totalKG,
              summ: summ,
              errorMessage: null);
        }else{
          statisticModel = StatisticModel(
            paperKG: 0,
            plasticKG: 0,
            glassKG: 0,
            othodyKG: 0,
            garbageKG: 0,
            othersKG: 0,
            totalKG: 0,
            summ: 0,
            errorMessage: "Недостаточно данных для предоставления статистики");
        }
        
      }
    } catch (error) {
      errorMessage = error.toString();
    }
  }
}
