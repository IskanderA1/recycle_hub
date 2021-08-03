part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationEventInit extends RegistrationEvent {
  RegistrationEventInit();
  @override
  List<Object> get props => [];
}

class RegistrationEventRegister extends RegistrationEvent {
  final String name;
  final String surname;
  final String username;
  final String pass;
  final String code;
  RegistrationEventRegister(
      {this.name, this.surname, this.username, this.pass, this.code});

  @override
  List<Object> get props => [name, surname, username, pass, code];
}

class RegistrationEventConfirm extends RegistrationEvent {
  final String code;

  RegistrationEventConfirm({this.code});

  @override
  List<Object> get props => [code];
}

class RegistrationEventHasCode extends RegistrationEvent {
  final String username;

  RegistrationEventHasCode({this.username});

  @override
  List<Object> get props => [username];
}
