import 'package:flutter/material.dart';

const kColorGreen = Color(0xFF62C848);
const kColorRed = Color(0xFFF14343);
const kColorBlack = Color(0xFF000000);
const kColorGreyDark = Color(0xFF616161);
const kColorGreyLight = Color(0xFF8D8D8D);
const kColorWhite = Color(0xFFF2F2F2);

ThemeData kAppThemeData() {
  return ThemeData(
    appBarTheme: AppBarTheme(
        shadowColor: kColorWhite,
        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2),
          //size: 20
        ),
        color: Color(0xFF62C848),
        ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFF62C848), size: 28),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Color(0xFF8D8D8D),
      backgroundColor: Color(0xFFF2F2F2),
      selectedItemColor: Color(0xFF62C848),
      unselectedIconTheme: IconThemeData(color: Color(0xFF8D8D8D), size: 25),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
        color: Color(0xFFF2F2F2), shape: CircularNotchedRectangle()),
    backgroundColor: Color(0xFFF2F2F2),
    canvasColor: Color(0xFFF2F2F2),
    tabBarTheme: TabBarTheme(labelColor: kColorGreyLight),
    iconTheme: IconThemeData(color: kColorWhite)
  );
}
