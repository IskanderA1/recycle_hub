import 'package:bloc/bloc.dart';

enum NavBarItem { MAP, ECO_GIDE, ECO_COIN, PROFILE, QRSCANNER }

class NavBarCubit extends Cubit<NavBarItem> {
  NavBarCubit() : super(NavBarItem.MAP);
  List<NavBarItem> _lastsList = [];

  void moveTo(NavBarItem screen) {
    emit(screen);
    if(_lastsList.length > 0){
      _lastsList.removeAt(0);
    }
    _lastsList.add(screen);
  }

  void goBack(){
    if(_lastsList.length > 0){
      emit(_lastsList.last);
      _lastsList.removeLast();
    }else{
      emit(NavBarItem.MAP);
    }
  }
}
