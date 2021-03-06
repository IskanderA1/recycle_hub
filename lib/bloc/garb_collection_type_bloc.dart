import 'package:rxdart/rxdart.dart';

enum GCOLLTYPE { RECYCLING, UTILISATION, BENEFIT }

class GarbageCollectionTypeBloc {
  BehaviorSubject<GCOLLTYPE> _behaviorSubject = BehaviorSubject<GCOLLTYPE>();

  //GCOLLTYPE defaultItem = GCOLLTYPE.RECYCLING;

  Stream<GCOLLTYPE> get stream => _behaviorSubject.stream;

  pickEvent(GCOLLTYPE type) {
    _behaviorSubject.sink.add(type);
  }

  close() {
    _behaviorSubject.close();
  }
}
