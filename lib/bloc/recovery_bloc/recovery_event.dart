part of 'recovery_bloc.dart';

abstract class RecoveryEvent extends Equatable {
  const RecoveryEvent();

  @override
  List<Object> get props => [];
}

class RecoveryEventSendCode extends RecoveryEvent {
  RecoveryEventSendCode({this.username});
  final String username;

  @override
  List<Object> get props => [this.username];
}

class RecoveryEventCheckCode extends RecoveryEvent {
  final String code;

  RecoveryEventCheckCode({this.code});

  @override
  List<Object> get props => [code];
}

class RecoveryEventChangePass extends RecoveryEvent {
  final String password;

  RecoveryEventChangePass({this.password});

  @override
  List<Object> get props => [password];
}
