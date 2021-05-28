import 'package:rxdart/rxdart.dart';

enum NavBarState { SHOW, HIDE }

class NavBarStateBloc {
  final BehaviorSubject<NavBarState> _navBarStateController =
      BehaviorSubject<NavBarState>();
  BehaviorSubject<NavBarState> get navBarStateController =>
      _navBarStateController;

  NavBarState defaultStateButton = NavBarState.SHOW;

  void pickState(int i) {
    switch (i) {
      case 0:
        _navBarStateController.sink.add(NavBarState.HIDE);
        break;
      case 1:
        _navBarStateController.sink.add(NavBarState.SHOW);
        break;
    }
  }

  close() {
    _navBarStateController.close();
  }
}

final navBarStateBloc = NavBarStateBloc();
