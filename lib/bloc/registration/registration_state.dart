part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

///Начальное состояние
class RegistrationStateInitial extends RegistrationState {

  @override
  List<Object> get props => [];
}

class RegistrationStateLoading extends RegistrationState {

  @override
  List<Object> get props => [];
}

///Состояние после отправки кода подтверждения на почту
class RegistrationStateNeedConfirm extends RegistrationState {

  @override
  List<Object> get props => [];
}

///Код подтвержден
class RegistrationStateConfirmed extends RegistrationState {

  @override
  List<Object> get props => [];
}

class RegistrationStateError extends RegistrationState {
  final Object error;

  RegistrationStateError(this.error);
  @override
  List<Object> get props => [this.error];

  @override
  String toString() => error.toString();
}
