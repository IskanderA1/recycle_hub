import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/screens/tabs/profile/edit_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/how_get_coin_screen.dart';
import 'package:recycle_hub/screens/offer_new_point.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purchases_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/my_purse_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/point_profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/store_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/top_up_history_screen.dart';

import '../../statistic_screen.dart';

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
              return StatisticScreen();
              break;
            case ProfileMenuStates.HOWGETCOIN:
              return HowToGetCoinScreen();
              break;
            case ProfileMenuStates.BACK:
              return ProfileScreen();
              break;
            case ProfileMenuStates.OFFERNEWPOINT:
              return OfferNewPointScreen();
              break;
            case ProfileMenuStates.PURSE:
              return MyPurseScreen();
              break;
            case ProfileMenuStates.STORE:
              return StoreScreen(onBackCall: ()=>profileMenuBloc.mapEventToState(ProfileMenuStates.BACK),);
              break;
            case ProfileMenuStates.EDITPROFILE:
              return EditProfileScreen();
              break;
            case ProfileMenuStates.MYPURCHASES:
              return MyPurchasesScreen();
              break;
            case ProfileMenuStates.TOPUPSHISTORY:
              return TopUpHistoryScreen();
              break;
          }
        });
  }
}
