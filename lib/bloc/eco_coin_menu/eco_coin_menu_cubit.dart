import 'package:bloc/bloc.dart';

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

  EcoCoinMenuItems _last = EcoCoinMenuItems.MENU;

  void moveTo(EcoCoinMenuItems screen) {
    if (screen == null) {
      emit(EcoCoinMenuItems.MENU);
      return;
    }
    emit(screen);
    _last = screen;
  }

  void goBack() {
    emit(_last);
  }
}
