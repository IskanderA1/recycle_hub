import 'dart:async';

enum EcoMenuItem{SEARCH,CONTAINER,REFERENCE,ADVICE,QANDA,TEST,MENU}

class EcoMenuBloc{
  final StreamController<EcoMenuItem> _serviceItemController = StreamController<EcoMenuItem>.broadcast();

  EcoMenuItem defaultItem = EcoMenuItem.MENU;
  Stream<EcoMenuItem> get itemStream =>_serviceItemController.stream;

  void pickItem(int i){
    switch(i){
      case 0:
        _serviceItemController.sink.add(EcoMenuItem.SEARCH);
        break;
      case 1:
        _serviceItemController.sink.add(EcoMenuItem.CONTAINER);
        break;
      case 2:
        _serviceItemController.sink.add(EcoMenuItem.REFERENCE);
        break;
      case 3:
        _serviceItemController.sink.add(EcoMenuItem.ADVICE);
        break;
      case 4:
        _serviceItemController.sink.add(EcoMenuItem.QANDA);
        break;
      case 5:
        _serviceItemController.sink.add(EcoMenuItem.TEST);
        break;
    }
  }
  void backToMenu(){
    _serviceItemController.sink.add(EcoMenuItem.MENU);
  }

  close() {
    _serviceItemController?.close();
  }

}
final ecoMenu = EcoMenuBloc();