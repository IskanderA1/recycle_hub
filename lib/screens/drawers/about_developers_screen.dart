import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/style/theme.dart';

class AboutDevelopersScreen extends StatefulWidget {
  @override
  _AboutDevelopersScreenState createState() => _AboutDevelopersScreenState();
}

class _AboutDevelopersScreenState extends State<AboutDevelopersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "О разработчиках",
          style: TextStyle(fontFamily: 'Gillroy'),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
            size: 35,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                'assets/svg/logo_original.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Данное мобильное приложение было разработано молодыми амбициозными ит-специалистами из студии мобильной разработки BeerStudio:',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GilroyMeduim',
              ),
            ),
            _ContactCell(
              link: "https://vk.com/ramz_galimov",
              name: '-Рамзиль Галимов',
              post: 'Frontend-разработчик',
            ),
            _ContactCell(
              link: "https://vk.com/kosinosta",
              name: '-Костя Инцын',
              post: 'Backend-разработчик',
            ),
            _ContactCell(
              link: "https://vk.com/iadiullov",
              name: '-Искандер Адиуллов',
              post: 'Team Lead',
            ),
            _ContactCell(
              link: "https://vk.com/mrnikbur",
              name: '-Никита Буравкин',
              post: 'Product manager',
            ),
            _ContactCell(
              link: "https://vk.com/baka_shonen",
              name: '-Суннат Савруллоев',
              post: 'Frontend-разработчик',
            ),
            _ContactCell(
              link: "https://vk.com/im?sel=554327760",
              name: '-Якуби Абдукаххор',
              post: 'UI/UX дизайнер',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Спасибо, что пользуетесь нашим приложением! Мы постараемся в свою очередь его совершенствовать!',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'GilroyMeduim',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Официальный сайт BeerStudio",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}

class _ContactCell extends StatelessWidget {
  const _ContactCell({this.link, this.name, this.post});
  final String name;
  final String link;
  final String post;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NetworkHelper.openUrl(link, context);
      },
      child: ListView(
        padding: EdgeInsets.only(top: 8),
        shrinkWrap: true,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'GilroyMeduim',
            ),
          ),
          Text(
            " " + post,
            style: TextStyle(color: kColorGreyLight),
          ),
        ],
      ),
    );
  }
}
