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
      child: ListView(
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
                padding:
                    EdgeInsets.only(left: 30, top: 45, bottom: 20, right: 30),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Ура!!! Вместе мы сдали более 1320 кг!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Новости', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Статистика', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Настройки', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Частые вопросы', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Как пользоваться', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Информация', style: TextStyle(fontSize: 16)),
                onTap: () {},
                trailing: Icon(
                  Icons.arrow_drop_down,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Контакты', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title:
                    Text('Оценить приложение', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF616161), width: 0.5))),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Обратная связь', style: TextStyle(fontSize: 16)),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
