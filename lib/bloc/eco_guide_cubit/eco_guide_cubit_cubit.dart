import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';

enum EcoGuideMenuItem { CONTAINER, REFERENCE, ADVICE, TEST, MENU }

class EcoGuideCubit extends Cubit<EcoGuideMenuItem> {
  EcoGuideCubit() : super(EcoGuideMenuItem.MENU);
  List<EcoGuideMenuItem> _lasts = [];

  void moveTo(EcoGuideMenuItem screen) {
    emit(screen);
    _lasts.add(screen);
  }

  void goBack() {
    if (_lasts.isEmpty || _lasts.last == EcoGuideMenuItem.MENU) {
      GetIt.I.get<NavBarCubit>().goBack();
      return;
    }
    _lasts.removeLast();
    if (_lasts.isNotEmpty) {
      emit(_lasts.last);
    } else {
      emit(EcoGuideMenuItem.MENU);
    }
  }
}
