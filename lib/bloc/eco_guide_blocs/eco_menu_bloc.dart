import 'dart:async';

enum EcoGuideMenuItem{CONTAINER,REFERENCE,ADVICE,TEST,MENU}

class EcoMenuBloc{
  final StreamController<EcoGuideMenuItem> _serviceItemController = StreamController<EcoGuideMenuItem>.broadcast();

  EcoGuideMenuItem defaultItem = EcoGuideMenuItem.MENU;
  Stream<EcoGuideMenuItem> get itemStream =>_serviceItemController.stream;

  void pickItem(int i){
    switch(i){
      case 0:
        _serviceItemController.sink.add(EcoGuideMenuItem.CONTAINER);
        break;
      case 1:
        _serviceItemController.sink.add(EcoGuideMenuItem.REFERENCE);
        break;
      case 2:
        _serviceItemController.sink.add(EcoGuideMenuItem.ADVICE);
        break;
      case 3:
        _serviceItemController.sink.add(EcoGuideMenuItem.TEST);
        break;
    }
  }
  void backToMenu(){
    _serviceItemController.sink.add(EcoGuideMenuItem.MENU);
  }

  close() {
    _serviceItemController?.close();
  }

}
final ecoGuideMenu = EcoMenuBloc();