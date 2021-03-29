import 'package:recycle_hub/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/model/transactions/transaction_response.dart';

class ProfileMenuBloc {
  BehaviorSubject<TransactionsResponse> _subject =
      BehaviorSubject<TransactionsResponse>();
  BehaviorSubject<TransactionsResponse> get subject => _subject;

  AppRepository _appRepository = AppRepository();

  void getTransactionsLis(){
    _appRepository.getTransactions().then((value) => _subject.sink.add(value));
  }

  void dispose() {
    _subject?.close();
  }
}
