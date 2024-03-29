import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/features/transactions/internal/transactions_module.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/do_test_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/edit_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/how_get_coin_screen.dart';
import 'package:recycle_hub/screens/offer_new_point.dart';
import 'package:recycle_hub/screens/tabs/profile/invite_friend_scren.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purchases_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purse_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/offer_news_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/point_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/store_screen.dart';
import 'package:recycle_hub/features/transactions/presentation/top_up_history_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/edit_point_profile_screen.dart';
import '../../../features/transactions/presentation/statistic_screen.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  _ProfileMenuScreenState createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: GetIt.I.get<AuthBloc>(),
        builder: (BuildContext context, state) {
          return BlocBuilder<ProfileMenuCubit, ProfileMenuStates>(
              bloc: GetIt.I.get<ProfileMenuCubit>(),
              builder: (context, ProfileMenuStates state) {
                switch (state) {
                  case ProfileMenuStates.USER_PROFILE:
                    return ProfileScreen();
                    break;
                  case ProfileMenuStates.POINT_PROFILE:
                    return PointProfileScreen();
                    break;
                  case ProfileMenuStates.STATISTIC:
                    return Provider<TransactionsState>(
                        create: (_) => TransactionsModule.getModule(),
                        child: StatisticScreen());
                    break;
                  case ProfileMenuStates.HOWGETCOIN:
                    return HowToGetCoinScreen();
                    break;
                  case ProfileMenuStates.MENU:
                    return ProfileScreen();
                    break;
                  case ProfileMenuStates.OFFERNEWPOINT:
                    return OfferNewPointScreen(
                      onBack: () => GetIt.I
                          .get<ProfileMenuCubit>()
                          .moveTo(ProfileMenuStates.MENU),
                    );
                    break;
                  case ProfileMenuStates.PURSE:
                    return MyPurseScreen();
                    break;
                  case ProfileMenuStates.STORE:
                    return StoreScreen(
                      onBackCall: () =>
                          GetIt.I.get<ProfileMenuCubit>().goBack(),
                    );
                    break;
                  case ProfileMenuStates.EDITPROFILE:
                    return EditProfileScreen();
                    break;
                  case ProfileMenuStates.MYPURCHASES:
                    return MyPurchasesScreen();
                    break;
                  case ProfileMenuStates.TOPUPSHISTORY:
                    return Provider<TransactionsState>(
                        create: (_) => TransactionsModule.getModule(),
                        child: TopUpHistoryScreen());
                    break;
                  case ProfileMenuStates.INVITE:
                    return InviteScreen();
                    break;
                  case ProfileMenuStates.PointEdit:
                    return EditPointProfileScreen();
                    break;
                  case ProfileMenuStates.PointWriteNews:
                    return OfferNewsScreen();
                    break;
                  case ProfileMenuStates.ECOTEST:
                    return TestScreen(
                        onBackPressed: GetIt.I.get<ProfileMenuCubit>().goBack);
                    break;
                  default:
                    return ProfileScreen();
                    break;
                }
              });
        });
  }
}
