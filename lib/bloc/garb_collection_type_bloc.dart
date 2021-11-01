import 'package:rxdart/rxdart.dart';

enum GCOLLTYPE { RECYCLING, UTILISATION, BENEFIT, unknown }

class GarbageCollectionTypeBloc {
  BehaviorSubject<GCOLLTYPE> _behaviorSubject = BehaviorSubject<GCOLLTYPE>();

  //GCOLLTYPE defaultItem = GCOLLTYPE.RECYCLING;

  Stream<GCOLLTYPE> get stream => _behaviorSubject.stream;

  pickEvent(GCOLLTYPE type) {
    if (_behaviorSubject.hasValue &&  _behaviorSubject.value == type) {
      _behaviorSubject.sink.add(GCOLLTYPE.unknown);
    } else {
      _behaviorSubject.sink.add(type);
    }
  }

  close() {
    _behaviorSubject.close();
  }
}
