import 'dart:async';

enum NavBarItem {MAP, ECO_GIDE, ECO_COIN, PROFILE }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.MAP;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.MAP);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.ECO_GIDE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.ECO_COIN);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.PROFILE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}

final bottomNavBarBloc = BottomNavBarBloc();

    // switch (event) {
    //   case NavigationEvents.HomePageClickedEvent:
    //     yield HomePage();
    //     break;
    //   case NavigationEvents.MyAccountClickedEvent:
    //     yield MyAccountsPage();
    //     break;
    //   case NavigationEvents.MyOrdersClickedEvent:
    //     yield MyOrdersPage();
    //     break;
    // }
