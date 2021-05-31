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

  AuthStateLogedIn({
    @required this.user
  });

  @override
  List<Object> get props => [];
}

