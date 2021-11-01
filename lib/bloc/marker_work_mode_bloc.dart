import 'package:rxdart/rxdart.dart';

enum MODE { PAID, FREE, PARTNERS, unknown }

class MarkerWorkModeBloc {
  BehaviorSubject<MODE> _behaviorSubject = BehaviorSubject<MODE>();

  //MODE defaultItem = MODE.PAID;

  Stream<MODE> get stream => _behaviorSubject.stream;

  pickEvent(MODE type) {
    if (_behaviorSubject.hasValue &&  _behaviorSubject.value == type) {
      _behaviorSubject.sink.add(MODE.unknown);
    } else {
      _behaviorSubject.sink.add(type);
    }
  }

  close() {
    _behaviorSubject.close();
  }
}
