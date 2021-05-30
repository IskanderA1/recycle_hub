import 'package:recycle_hub/api/app_repo.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/model/transactions/transaction_response.dart';

class ProfileMenuBloc {
  BehaviorSubject<TransactionsResponse> _subject =
      BehaviorSubject<TransactionsResponse>();
  BehaviorSubject<TransactionsResponse> get subject => _subject;

  UserService _appRepository = UserService();

  void getTransactionsLis(){
    //_appRepository.getTransactions().then((value) => _subject.sink.add(value));
  }

  void dispose() {
    _subject?.close();
  }
}
