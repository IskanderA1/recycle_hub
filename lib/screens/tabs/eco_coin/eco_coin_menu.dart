import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/screens/offer_new_point.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screens/give_garbage_instruction_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/store_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'eco_coin_screens/eco_coin_screen.dart';

class EcoCoinMainScreen extends StatefulWidget {
  @override
  _EcoCoinMainScreenState createState() => _EcoCoinMainScreenState();
}

class _EcoCoinMainScreenState extends State<EcoCoinMainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        GetIt.I.get<EcoCoinMenuCubit>().goBack();
      },
          child: BlocBuilder<EcoCoinMenuCubit, EcoCoinMenuItems>(
          bloc: GetIt.I.get<EcoCoinMenuCubit>(),
          builder: (context, state) {
            if (state == EcoCoinMenuItems.MENU) {
              return EcoCoinScreen();
            } else if (state == EcoCoinMenuItems.STORE) {
              return StoreScreen(
                onBackCall: () {
                  GetIt.I.get<EcoCoinMenuCubit>().moveTo(EcoCoinMenuItems.MENU);
                },
              );
            } else if (state == EcoCoinMenuItems.ANSWERQUESTS) {
              GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.ECO_GIDE);
              GetIt.I.get<EcoGuideCubit>().moveTo(EcoGuideMenuItem.TEST);
              return EcoCoinScreen();
            } else if (state == EcoCoinMenuItems.FEEDBACK) {
              openApp('https://pub.dev/packages/url_launcher');
              return EcoCoinScreen();
            } else if (state == EcoCoinMenuItems.GIVEGARBAGE) {
              return GiveGarbageInstructionScreen();
            } else if (state == EcoCoinMenuItems.OFFERNEWPOINT) {
              return OfferNewPointScreen(
                  onBack: () => GetIt.I
                      .get<EcoCoinMenuCubit>()
                      .moveTo(EcoCoinMenuItems.MENU));
            } else if (state == EcoCoinMenuItems.RECOMMEND) {
              return EcoCoinScreen();
            }
            return EcoCoinScreen();
          }),
    );
  }

  Future openApp(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
