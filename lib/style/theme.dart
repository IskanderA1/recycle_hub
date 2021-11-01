import 'package:flutter/material.dart';

const kColorGreen = const Color(0xFF249507);
const kColorRed = const Color(0xFFF14343);
const kColorBlack = const Color(0xFF000000);
const kColorGreyDark = const Color(0xFF616161);
const kColorGreyLight = const Color(0xFF8D8D8D);
const kColorGreyVeryLight = const Color(0xFFF2F2F2);
const kColorWhite = const Color(0xFFFFFFFF);
const kColorPink = const Color(0xFFFF9966);
const kColorGreenYellow = const Color(0xFFD0E07A);
const kColorSteperLightGreen = const Color(0xFFDFE895);
const kColorIcon = const Color(0xFF8D8D8D);
const kColorScaffold = const Color(0xFFF2F2F2);

///Экран регистрации
const kColorRegGoogle = const Color(0xFFDD4B39);
const kColorRegVK = const Color(0xFF2787F5);
const kLightGrey = const Color(0xFF8D8D8D80);

const double kBorderRadius = 16;

ThemeData kAppThemeData() {
  return ThemeData(
    fontFamily: 'Gilroy',
    appBarTheme: AppBarTheme(
      shadowColor: kColorWhite,
      iconTheme: IconThemeData(
        color: Color(0xFFF2F2F2),
        size: 25,
        //size: 20
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kColorWhite,
        fontSize: 18,
        fontFamily: 'GillroyMedium',
        fontWeight: FontWeight.w700,
      ),
      color: kColorGreen,
      /* toolbarTextStyle: TextStyle(
        fontSize: 14,
        color: kColorWhite,
      ), */
    ),
    textTheme: TextTheme(headline6: TextStyle(color: kColorGreyDark, fontSize: 14, fontFamily: 'GilroyMedium')),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: kColorGreen, size: 23),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: kColorIcon,
      backgroundColor: Color(0xFFF2F2F2),
      selectedItemColor: kColorGreen,
      unselectedIconTheme: IconThemeData(color: kColorIcon, size: 20),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFFF2F2F2), shape: CircularNotchedRectangle()),
    backgroundColor: Color(0xFFFFFFFF),
    canvasColor: Color(0xFFF2F2F2),
    tabBarTheme: TabBarTheme(labelColor: kColorGreyLight),
    iconTheme: IconThemeData(
      color: kColorIcon,
      size: 18,
    ),
  );
}

const kCardSelectedTextStyle = TextStyle(fontSize: 16, color: kColorGreen);
const kCardUnselectedTextStyle = TextStyle(fontSize: 16, color: kColorGreyDark);
