import 'package:rxdart/rxdart.dart';

enum MODE { PAID, FREE, ROUND, PARTNERS }

class MarkerWorkModeBloc {
  BehaviorSubject<MODE> _behaviorSubject = BehaviorSubject<MODE>();

  MODE defaultItem = MODE.PAID;

  Stream<MODE> get stream => _behaviorSubject.stream;

  pickEvent(MODE type) {
    _behaviorSubject.sink.add(type);
  }

  close() {
    _behaviorSubject.close();
  }
}
