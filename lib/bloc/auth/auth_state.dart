part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateFail extends AuthState {
  final String error;

  AuthStateFail({this.error});

  @override
  List<Object> get props => [];
}

class AuthStateFirstIn extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLogOuted extends AuthState {}

class AuthStateNeedConfirm extends AuthState {}

class AuthStateLogedIn extends AuthState {
  final UserModel user;
  final bool isAdmin;

  AuthStateLogedIn({@required this.user, this.isAdmin = false});

  @override
  List<Object> get props => [];
}

class AuthStateRecovery extends AuthState {
  final bool wasSend;
  final bool isCodeValid;
  final bool passChanged;

  AuthStateRecovery(
      {this.wasSend = false,
      this.isCodeValid = false,
      this.passChanged = false});

  @override
  List<Object> get props => [wasSend, isCodeValid, passChanged];
}
