import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/repo/app_repo.dart';

class AuthUserBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();
  UserResponse user;

  pickState(UserResponse state) {
    _subject.sink.add(state);
  }

  auth(String login, String password) async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.userAuth(login, password);
    _subject.sink.add(response);
    if (response is UserLoggedIn) {
      user = response;
    }
  }

  authLocal() async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.userAuthLocal();
    _subject.sink.add(response);
    if (response is UserLoggedIn) {
      user = response;
    }
  }

  authLogOut() async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.userLogOut();
    _subject.sink.add(response);
    if (response is UserLoggedIn) {
      user = null;
    }
  }

  Future<int> registrUser(String name, String surname, String username,
      String pass, String code) async {
    UserResponse response =
        await _repository.regUser(name, surname, username, pass, code);
    _subject.sink.add(response);
    if (response is UserRegOk) {
      return 0;
    }
    return -1;
  }

  Future<int> confirmCode(String code) async {
    UserResponse response = await _repository.confirmCode(code);
    _subject.sink.add(response);
    if (response is UserLoggedIn) {
      return 0;
    }
    return -1;
  }

  forgetPassCodeSend(String username) async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.sendCode(username);
    _subject.sink.add(response);
    if (response is UserForgetPassCodeSended) {
      return 0;
    }
    return -1;
  }

  forgetPassCodeConfirm(String code) async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.forgetConfirmCode(code);
    _subject.sink.add(response);
    if (response is UserForgetPassCodeOk) {
      return 0;
    }
    return -1;
  }

  Future<int> passChange(String pass) async {
    _subject.sink.add(UserLoading());
    UserResponse response = await _repository.changePass(pass);
    _subject.sink.add(response);
    if (response is UserPassChangedOk) {
      return 0;
    }
    return -1;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final authBloc = AuthUserBloc();
