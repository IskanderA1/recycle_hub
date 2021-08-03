import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/icons/how_to_get_coin_icons_icons.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';
import '../eco_coin/eco_coin_screens/eco_coin_screen.dart';

class HowToGetCoinScreen extends StatefulWidget {
  @override
  _HowToGetCoinScreenState createState() => _HowToGetCoinScreenState();
}

class _HowToGetCoinScreenState extends State<HowToGetCoinScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
          onPressed: () => GetIt.I.get<ProfileMenuCubit>().goBack(),
        ),
        title: Text(
          "Как заработать баллы?",
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
                      name: "Предложить новый пункт приема",
                      func: () => GetIt.I
                          .get<ProfileMenuCubit>()
                          .moveTo(ProfileMenuStates.OFFERNEWPOINT),
                      iconData: HowToGetCoinIcons.add_pointer,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Пригласить друга",
                      func: () => GetIt.I
                          .get<ProfileMenuCubit>()
                          .moveTo(ProfileMenuStates.INVITE),
                      iconData: HowToGetCoinIcons.add_user,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Редактировать устаревшее\nописание пункта приема",
                      func: () {},
                      iconData: HowToGetCoinIcons.edit,
                    ),
                    /* EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Заполнить информацию о себе",
                      func: () {},
                      iconData: HowToGetCoinIcons.information,
                    ), */
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Написать отзыв в Play Market",
                      func: () {},
                      iconData: HowToGetCoinIcons.reviews,
                    ),
                    EcoCoinHorisontalDivider(),
                    MenuItemWidget(
                      name: "Пройти тест",
                      func: () {
                        GetIt.I
                            .get<ProfileMenuCubit>()
                            .moveTo(ProfileMenuStates.ECOTEST);
                      },
                      iconData: HowToGetCoinIcons.brain,
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
