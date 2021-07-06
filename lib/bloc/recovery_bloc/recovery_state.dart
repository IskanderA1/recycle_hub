part of 'recovery_bloc.dart';

abstract class RecoveryState extends Equatable {
  const RecoveryState();

  @override
  List<Object> get props => [];
}

class RecoveryInitial extends RecoveryState {}
class RecoveryStateLoading extends RecoveryState {}

class RecoveryStateError extends RecoveryState {
  final Object error;
  RecoveryStateError(this.error);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return error.toString();
  }
}

class RecoveryStateLoaded extends RecoveryState {
  final bool wasSend;
  final bool isCodeValid;
  final bool passChanged;

  RecoveryStateLoaded(
      {this.wasSend = false,
      this.isCodeValid = false,
      this.passChanged = false});

  @override
  List<Object> get props => [wasSend, isCodeValid, passChanged];
}
