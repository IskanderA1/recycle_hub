part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventInit extends AuthEvent {}

class AuthEventSwitchFirstIn extends AuthEvent {}

/* class AuthEventRegister extends AuthEvent {
  final String name;
  final String surname;
  final String username;
  final String pass;
  final String code;
  AuthEventRegister(
      {this.name, this.surname, this.username, this.pass, this.code});

  @override
  List<Object> get props => [name, surname, username, pass, code];
} */



class AuthEventLogin extends AuthEvent {
  final String login;
  final String password;
  AuthEventLogin({this.login, this.password});
  @override
  List<Object> get props => [login, password];
}

class AuthEventLogout extends AuthEvent {}

