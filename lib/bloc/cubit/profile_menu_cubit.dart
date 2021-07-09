import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/model/user_model.dart';

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
  INVITE,

  PointEdit,
  PointWriteNews,
  PointStatistic,
  PointAchievments,
}

class ProfileMenuCubit extends Cubit<ProfileMenuStates> {
  ProfileMenuCubit() : super(ProfileMenuStates.MENU);

  List<ProfileMenuStates> _lasts = [];

  void moveTo(ProfileMenuStates screen) {
    if (screen == null &&
        GetIt.I.get<AuthBloc>().state.userModel.userType == UserTypes.admin) {
      emit(ProfileMenuStates.POINT_PROFILE);
      return;
    } else if (screen == null) {
      emit(ProfileMenuStates.POINT_PROFILE);
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
      if (_lasts.isEmpty &&
          GetIt.I.get<AuthBloc>().state.userModel.userType == UserTypes.admin) {
        emit(ProfileMenuStates.POINT_PROFILE);
      } else if (_lasts.isEmpty) {
        emit(ProfileMenuStates.MENU);
      } else {
        emit(_lasts.last);
      }
    }
  }
}
