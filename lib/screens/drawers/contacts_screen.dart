import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Контакты",
          /* style: TextStyle(fontFamily: 'Gillroy'), */
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            /* Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Наши контакты",
                style: TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
              ),
            ), */
           /*  CommonCell(
              prefixIcon: Icon(
                Icons.phone_outlined,
                size: 25,
                color: kColorGreyLight,
              ),
              text: '+7 (999) 999-99-99',
              onTap: () {},
            ), */
            CommonCell(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: kColorGreyLight,
                size: 25,
              ),
              text: 'example@gmail.com',
              onTap: () {
                NetworkHelper.openUrl('example@gmail.com', context);
              },
            ),
            /* Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Наш сайт",
                style: TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
              ),
            ), */
            CommonCell(
              prefixIcon: Icon(
                Icons.link,
                color: kColorGreyLight,
                size: 25,
              ),
              text: 'www.recyclehub.ru',
              onTap: () {
                NetworkHelper.openUrl('www.recyclehub.ru', context);
              },
            ),
            /* Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "Мы в соц-сетях",
                style: TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
              ),
            ), */
            CommonCell(
              prefixIcon: FaIcon(
                FontAwesomeIcons.vk,
                color: Color(0xFF2787F5),
                size: 25,
              ),
              text: "Вконтакте",
              onTap: () {
                NetworkHelper.openUrl('https://vk.com/recyclehub', context);
              },
            ),
            CommonCell(
              prefixIcon: FaIcon(
                FontAwesomeIcons.instagram,
                color: kColorGreyLight,
                size: 25,
              ),
              text: "Инстаграм",
              onTap: () {
                NetworkHelper.openUrl('https://instagram.com/recyclehub.ru', context);
              },
            ),
            CommonCell(
              prefixIcon: FaIcon(
                FontAwesomeIcons.telegram,
                color: Color(0xFF039BE5),
                size: 25,
              ),
              text: "Телеграм",
              onTap: () {
                NetworkHelper.openUrl('https://t.me/recyclehub', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
