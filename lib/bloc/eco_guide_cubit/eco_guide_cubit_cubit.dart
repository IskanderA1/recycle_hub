import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';

enum EcoGuideMenuItem { CONTAINER, REFERENCE, ADVICE, TEST, MENU }

class EcoGuideCubit extends Cubit<EcoGuideMenuItem> {
  EcoGuideCubit() : super(EcoGuideMenuItem.MENU);
  EcoGuideMenuItem _last = EcoGuideMenuItem.MENU;

  void moveTo(EcoGuideMenuItem screen) {
    emit(screen);
    _last = screen;
  }

  void goBack() {
    if(_last == EcoGuideMenuItem.MENU){
      GetIt.I.get<NavBarCubit>().goBack();
      return;
    }
    emit(_last);
  }
}
