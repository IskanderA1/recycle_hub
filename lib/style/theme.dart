import 'package:flutter/material.dart';

const kColorGreen = Color(0xFF249507);
const kColorRed = Color(0xFFF14343);
const kColorBlack = Color(0xFF000000);
const kColorGreyDark = Color(0xFF616161);
const kColorGreyLight = Color(0xFF8D8D8D);
const kColorGreyVeryLight = Color(0xFFF2F2F2);
const kColorWhite = Color(0xFFFFFFFF);
const kColorPink = Color(0xFFFF9966);
const kColorGreenYellow = Color(0xFFD0E07A);
const kColorSteperLightGreen = Color(0xFFDFE895);

///Экран регистрации
const kColorRegGoogle = Color(0xFFDD4B39);
const kColorRegVK = Color(0xFF2787F5);
const kLightGrey = const Color(0xFF8D8D8D80);

ThemeData kAppThemeData() {
  return ThemeData(
      fontFamily: 'Gilroy',
      appBarTheme: AppBarTheme(
        shadowColor: kColorWhite,
        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2),
          //size: 20
        ),
        color: kColorGreen,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: kColorGreen, size: 23),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xFF8D8D8D),
        backgroundColor: Color(0xFFF2F2F2),
        selectedItemColor: kColorGreen,
        unselectedIconTheme: IconThemeData(color: Color(0xFF8D8D8D), size: 20),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
          color: Color(0xFFF2F2F2), shape: CircularNotchedRectangle()),
      backgroundColor: Color(0xFFFFFFFF),
      canvasColor: Color(0xFFF2F2F2),
      tabBarTheme: TabBarTheme(labelColor: kColorGreyLight),
      iconTheme: IconThemeData(color: kColorWhite));
}

const kCardSelectedTextStyle = TextStyle(fontSize: 16, color: kColorGreen);
const kCardUnselectedTextStyle = TextStyle(fontSize: 16, color: kColorGreyDark);
