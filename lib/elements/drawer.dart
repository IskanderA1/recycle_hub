import 'package:flutter/material.dart';

import '../style/theme.dart';
import '../style/theme.dart';
import '../style/theme.dart';
import '../style/theme.dart';

Drawer customDrawer = Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  color: kColorWhite,
                  size: 80,
                ),
                title: Text("Иван Иванов", style: TextStyle(color: kColorWhite),),
                subtitle: Text("ЭкоГерой",style: TextStyle(color: kColorWhite),),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Ура вместе мы сдали 320 кг",style: TextStyle(color: kColorWhite),)
          ],
        ),
        decoration: BoxDecoration(
          color: kColorGreen,
        ),
      ),
      ListTile(
        title: Text('Новости'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Статистика'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Настройки'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Частые вопросы'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Как пользоваться'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Информация'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Контакты'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Оценить приложение'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Обратная связь'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Темная тема'),
        onTap: () {},
      ),
    ],
  ),
);
