part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  UserModel get userModel => UserModel.guestAcc();

  @override
  List<Object> get props => [];
}

class AuthStateFail extends AuthState {
  final String error;

  AuthStateFail({this.error});

  @override
  List<Object> get props => [error];
}

class AuthStateFirstIn extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoggedOut extends AuthState {}

class AuthStateLogedIn extends AuthState {
  final UserModel user;

  AuthStateLogedIn({@required this.user});

  @override
  UserModel get userModel => this.user;

  @override
  List<Object> get props => [user];
}

class AuthStateGuestAcc extends AuthState {
  AuthStateGuestAcc({
    this.needToShowInfo = false,
  });
  final bool needToShowInfo;

  @override
  List<Object> get props => [needToShowInfo];
}
