import 'package:rxdart/rxdart.dart';

enum StateButtons { ALLOWED, FORBIDDEN }

class ButtonSwitchBloc {
  StateButtons currentButton = StateButtons.ALLOWED;
  final BehaviorSubject<StateButtons> _switchButtonController =
      BehaviorSubject<StateButtons>();
  BehaviorSubject<StateButtons> get switchButtonController =>
      _switchButtonController;

  StateButtons defaultStateButton = StateButtons.ALLOWED;

  void pickWeek(int i) {
    switch (i) {
      case 0:
        _switchButtonController.sink.add(StateButtons.ALLOWED);
        break;
      case 1:
        _switchButtonController.sink.add(StateButtons.FORBIDDEN);
        break;
    }
  }

  close() {
    _switchButtonController?.close();
  }
}

final switchButtonBloc = ButtonSwitchBloc();
