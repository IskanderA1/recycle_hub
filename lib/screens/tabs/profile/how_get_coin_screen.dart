import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
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
  static const _text1 = '   Заработать баллы вы можете в разделе ';
  static const _text2 =
      '. За каждое задание, вам будут начисляться определенное количество Экокоинов за 1 кг сданного вторсырья, которые вы сможете потратить на услуги и товары партнеров в разделе ';
  static const _text3 = '\n   За правильно решенный ';
  static const _text4 =
      ' система разблокирует ЭкоКоины.\n   В профиле вы можете увидеть свой баланс. Зеленым цветом обозначен баланс о количестве доступных к трате ЭкоКоинов. Красным цветом обозначен баланс, который доступен к разблокировке.';
  static const _ecoCoins = 'ЭкоКоины';
  static const _store = 'Магазин.';
  static const _test = 'тест';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            AppBarIcons.back,
            color: kColorWhite,
            size: 18,
          ),
          onPressed: () => GetIt.I.get<ProfileMenuCubit>().goBack(),
        ),
        title: Text(
          "Как заработать баллы?",
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
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: _text1,
                    style: TextStyle(color: kColorBlack, fontFamily: 'Gilroy'),
                    children: [
                      TextSpan(
                          text: _ecoCoins,
                          style: TextStyle(fontFamily: "Gilroy", color: kColorBlack, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ///To eco coins
                              GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.ECO_COIN);
                            }),
                      TextSpan(text: _text2),
                      TextSpan(
                          text: _store,
                          style: TextStyle(fontFamily: "Gilroy", color: kColorBlack, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ///To store
                              GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.STORE);
                            }),
                      TextSpan(text: _text3),
                      TextSpan(
                          text: _test,
                          style: TextStyle(fontFamily: "Gilroy", color: kColorBlack, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ///To test
                              GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.ECOTEST);
                            }),
                      TextSpan(text: _text4),
                    ],
                  ),
                )
                /* Column(
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
                ) */
                ),
          ),
        ),
      ),
    );
  }
}
