import 'package:rxdart/rxdart.dart';

enum StoreStates {SERVICES, TOEAT }

class StoreTabBarBloc {
  BehaviorSubject<StoreStates> _subject =
      BehaviorSubject<StoreStates>();
  BehaviorSubject<StoreStates> get subject => _subject;

  final defaultState = StoreStates.SERVICES;

  void mapEventToState(StoreStates event) {
    switch (event) {
      case StoreStates.SERVICES:
        _subject.sink.add(StoreStates.SERVICES);
        break;
      case StoreStates.TOEAT:
        _subject.sink.add(StoreStates.TOEAT);
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final storeTabBarBloc = StoreTabBarBloc();
