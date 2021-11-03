import 'package:flutter/material.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'about_developers_screen.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    print('helloabdu');
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
            Icons.arrow_back,
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
                NetworkHelper.openUrl('https://recyclehub.ru/privacy/#/conditions/', context);
              },
            ),
            CommonCell(
              text: 'Политика конфеденциальности',
              onTap: () {
                NetworkHelper.openUrl('https://recyclehub.ru/privacy/#/', context);
              },
            ),
            CommonCell(
              text: 'Условия реферальной программы',
              onTap: () {
                NetworkHelper.openUrl('https://recyclehub.ru/privacy/#/conditions/', context);
              },
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
