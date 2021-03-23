import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style/theme.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 45),
            children: <Widget>[
              Container(
                color: Colors.grey[300],
                child: Stack(children: [
                  SvgPicture.asset(
                    "svg/drawer_header.svg",
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 30, top: 45, bottom: 20, right: 30),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "Ура!!! Вместе мы сдали более 1320 кг!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
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
                        bottom:
                            BorderSide(color: Color(0xFF616161), width: 0.5))),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('Обратная связь'),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Container(
            color: kColorWhite,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: kColorBlack,
                  size: 30,
                ),
                Container(
                  height: 47,
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
  }
}