import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/features/transactions/internal/transactions_module.dart';
import 'package:recycle_hub/screens/tabs/profile/edit_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/how_get_coin_screen.dart';
import 'package:recycle_hub/screens/offer_new_point.dart';
import 'package:recycle_hub/screens/tabs/profile/invite_friend_scren.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purchases_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purse_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/point_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/store_screen.dart';
import 'package:recycle_hub/features/transactions/presentation/top_up_history_screen.dart';

import '../../../features/transactions/presentation/statistic_screen.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  _ProfileMenuScreenState createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: profileMenuBloc.subject.stream,
        initialData: profileMenuBloc.defaultState,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<ProfileMenuStates> snapshot) {
          switch (snapshot.data) {
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
                onBack: () =>
                    profileMenuBloc.mapEventToState(ProfileMenuStates.MENU),
              );
              break;
            case ProfileMenuStates.PURSE:
              return MyPurseScreen();
              break;
            case ProfileMenuStates.STORE:
              return StoreScreen(
                onBackCall: () =>
                    profileMenuBloc.mapEventToState(ProfileMenuStates.MENU),
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
          }
        });
  }
}
