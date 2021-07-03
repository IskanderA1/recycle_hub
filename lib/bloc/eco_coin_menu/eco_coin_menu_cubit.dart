import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';

enum EcoCoinMenuItems {
  MENU,
  STORE,
  GIVEGARBAGE,
  OFFERNEWPOINT,
  ANSWERQUESTS,
  RECOMMEND,
  FEEDBACK
}

class EcoCoinMenuCubit extends Cubit<EcoCoinMenuItems> {
  EcoCoinMenuCubit() : super(EcoCoinMenuItems.MENU);

  List<EcoCoinMenuItems> _lasts = [];

  void moveTo(EcoCoinMenuItems screen) {
    if (screen == null) {
      emit(EcoCoinMenuItems.MENU);
      return;
    }
    emit(screen);
    _lasts.add(screen);
  }

  void goBack() {
    if(_lasts.isEmpty){
      GetIt.I.get<NavBarCubit>().goBack();
    }else{
      _lasts.removeLast();
      if(_lasts.isEmpty){
        emit(EcoCoinMenuItems.MENU);
      }else{
        emit(_lasts.last);
      }
    }
  }
}
