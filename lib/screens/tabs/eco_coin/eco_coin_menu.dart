import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/screens/offer_new_point.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screens/give_garbage_instruction_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/do_test_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/store_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'eco_coin_screens/eco_coin_screen.dart';
import 'dart:io' show Platform;

class EcoCoinMainScreen extends StatefulWidget {
  @override
  _EcoCoinMainScreenState createState() => _EcoCoinMainScreenState();
}

class _EcoCoinMainScreenState extends State<EcoCoinMainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EcoCoinMenuCubit, EcoCoinMenuItems>(
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
            return TestScreen(
              onBackPressed: GetIt.I.get<EcoCoinMenuCubit>().goBack,
            );
          } else if (state == EcoCoinMenuItems.FEEDBACK) {
            openApp(Platform.isIOS
                ? 'https://apps.apple.com/us/app/recyclehub/id1584204305#?platform=iphone'
                : 'https://play.google.com/store/apps/details?id=com.beerstudio.recycle_hub');
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
        });
  }

  Future openApp(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
