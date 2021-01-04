import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/model/user_response.dart';
import 'package:recycle_hub/repo/app_repo.dart';


class AuthUserBloc{
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<UserResponse> _subject =
  BehaviorSubject<UserResponse>();

  auth(String login, String password) async{
    _subject.sink.add(UserResponse.withError("Loading"));
    UserResponse response = await _repository.userAuth(login, password);
    _subject.sink.add(response);
  }
  authLocal() async {
    _subject.sink.add(UserResponse.withError("Loading"));
    UserResponse response = await _repository.userAuthLocal();
    _subject.sink.add(response);
  }

  authLogOut() async {
    _subject.sink.add(UserResponse.withError("Loading"));
    UserResponse response = await _repository.userLogOut();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

}
final authBloc = AuthUserBloc();