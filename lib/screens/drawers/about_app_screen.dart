import 'package:flutter/material.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';
import 'about_developers_screen.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "О приложении",
          /* style: TextStyle(fontFamily: 'Gillroy'), */
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            AppBarIcons.back,
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
              text: 'Условия и положения',
              onTap: () {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BePartnerScreen(),
                  ),
                ); */
              },
            ),
            CommonCell(
              text: 'Политика конфеденциальности',
              onTap: () {},
            ),
            CommonCell(
              text: 'Условия реферальной программы',
              onTap: () {},
            ),
            CommonCell(
              text: 'О разработчиках',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutDevelopersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
