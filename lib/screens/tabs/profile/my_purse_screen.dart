import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
          onPressed: () =>
              profileMenuBloc.mapEventToState(ProfileMenuStates.BACK),
        ),
        title: Text(
          "Кошелек",
          style: TextStyle(
              color: kColorWhite,
              fontSize: 18,
              fontFamily: 'GillroyMedium',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Container(
              height: size.height,
              decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    MenuItemWidget(
                      name: "Магазин",
                      func: () => profileMenuBloc
                          .mapEventToState(ProfileMenuStates.STORE),
                      iconData: MyPyrchaseIcons.shopping_bags,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Мои покупки",
                      func: () {
                        profileMenuBloc
                            .mapEventToState(ProfileMenuStates.MYPURCHASES);
                      },
                      iconData: MyPyrchaseIcons.exchange,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "История пополнений",
                      func: () =>profileMenuBloc
                            .mapEventToState(ProfileMenuStates.TOPUPSHISTORY),
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
