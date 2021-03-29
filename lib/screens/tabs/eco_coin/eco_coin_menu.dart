import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_coin_bloc.dart/eco_coin_menu_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
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
    return StreamBuilder(
        stream: ecoCoinMenuBloc.stream,
        initialData: ecoCoinMenuBloc.defaultItem,
        builder:
            (BuildContext context, AsyncSnapshot<EcoCoinMenuItems> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == EcoCoinMenuItems.MENU) {
              return EcoCoinScreen();
            } else if (snapshot.data == EcoCoinMenuItems.STORE) {
              return StoreScreen(onBackCall: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.MENU),);
            } else if (snapshot.data == EcoCoinMenuItems.ANSWERQUESTS) {
              bottomNavBarBloc.pickItem(1);
              ecoGuideMenu.pickItem(3);
              return EcoCoinScreen();
            } else if (snapshot.data == EcoCoinMenuItems.FEEDBACK) {
              openApp(
                  'https://pub.dev/packages/url_launcher');
              return EcoCoinScreen();
            } else if (snapshot.data == EcoCoinMenuItems.GIVEGARBAGE) {
              return GiveGarbageInstructionScreen();
            } else if (snapshot.data == EcoCoinMenuItems.OFFERNEWPOINT) {
              return OfferNewPointScreen(onBack: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.MENU));
            } else if (snapshot.data == EcoCoinMenuItems.RECOMMEND) {
              
              return EcoCoinScreen();
            }
            return EcoCoinScreen();
          } else {
            return Container(
              child: Center(child: Text("Что-то пошло не так")),
            );
          }
        });
  }

  Future openApp(String url) async {
    if (await canLaunch('url'))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
