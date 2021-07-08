import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';

enum ProfileMenuStates {
  MENU,
  USER_PROFILE,
  POINT_PROFILE,
  STATISTIC,
  HOWGETCOIN,
  OFFERNEWPOINT,
  PURSE,
  STORE,
  EDITPROFILE,
  MYPURCHASES,
  TOPUPSHISTORY,
  INVITE
}

class ProfileMenuCubit extends Cubit<ProfileMenuStates> {
  ProfileMenuCubit() : super(ProfileMenuStates.MENU);

  List<ProfileMenuStates> _lasts = [];

  void moveTo(ProfileMenuStates screen) {
    if (screen == null) {
      emit(ProfileMenuStates.MENU);
      return;
    }
    emit(screen);
    _lasts.add(screen);
  }

  void goBack() {
    if (_lasts.isEmpty) {
      GetIt.I.get<NavBarCubit>().goBack();
    } else {
      _lasts.removeLast();
      if (_lasts.isEmpty) {
        emit(ProfileMenuStates.MENU);
      } else {
        emit(_lasts.last);
      }
    }
  }
}