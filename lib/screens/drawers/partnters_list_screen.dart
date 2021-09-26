import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/screens/drawers/be_partner_screen.dart';
import 'package:recycle_hub/style/theme.dart';

class PartnersListScreen extends StatefulWidget {
  @override
  _PartnersListScreenState createState() => _PartnersListScreenState();
}

class _PartnersListScreenState extends State<PartnersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Партнеры",
          /* style: TextStyle(fontFamily: 'Gillroy'), */
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            AppBarIcons.back,
            color: kColorWhite,
            size: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            CommonCell(
              text: 'Альметьевск',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Зеленодольск',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Казань',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Иннополис',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Лениногорск',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Чистополь',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                );
              },
            ),
            CommonCell(
              text: 'Менделеевск',
              onTap: () {},
            ),
            CommonCell(
              text: 'Мамадыш',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
