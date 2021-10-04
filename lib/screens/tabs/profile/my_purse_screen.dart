import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/icons/my_pyrchase_icons_icons.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screens/eco_coin_screen.dart';
import 'package:recycle_hub/style/theme.dart';

class MyPurseScreen extends StatefulWidget {
  @override
  _MyPurseScreenState createState() => _MyPurseScreenState();
}

class _MyPurseScreenState extends State<MyPurseScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
          ),
          onTap: () => GetIt.I.get<ProfileMenuCubit>().goBack(),
        ),
        title: Text(
          "Кошелек",
          /* style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'GillroyMedium', fontWeight: FontWeight.bold), */
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Container(
              height: size.height,
              decoration: BoxDecoration(color: kColorWhite, borderRadius: BorderRadius.all(Radius.circular(kBorderRadius),)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    MenuItemWidget(
                      name: "Магазин",
                      func: () => GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.STORE),
                      iconData: MyPyrchaseIcons.shopping_bags,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Мои покупки",
                      func: () {
                        GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.MYPURCHASES);
                      },
                      iconData: MyPyrchaseIcons.exchange,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "История пополнений",
                      func: () async {
                        GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.TOPUPSHISTORY);
                      },
                      iconData: MyPyrchaseIcons.shopping_cart,
                    ),
                    EcoCoinHorisontalDivider(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
