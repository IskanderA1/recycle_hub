import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import '../style/theme.dart';

Drawer customDrawer(BuildContext context) => Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height-82.5,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF286385),
                            child: Icon(
                              Icons.person,
                              color: Color(0xFFFDC00F),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Ураа!!",
                                  style: TextStyle(
                                      color: kColorWhite, fontSize: 19)),
                              Text(
                                "Вместе мы сдали 320 кг",
                                style:
                                    TextStyle(color: kColorWhite, fontSize: 19),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kColorGreen,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Новости'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Статистика'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Настройки'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Частые вопросы'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Как пользоваться'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Информация'),
                    onTap: () {},
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Контакты'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Оценить приложение'),
                    onTap: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF616161), width: 0.5))),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Обратная связь'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 8,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: kColorBlack,
                  size: 30,
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: DayNightSwitcher(
                      isDarkModeEnabled: false, onStateChanged: (state) {}),
                )
              ],
            ),
          )
        ],
      ),
    );
