import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

class AboutProjectScreen extends StatefulWidget {
  @override
  _AboutProjectScreenState createState() => _AboutProjectScreenState();
}

class _AboutProjectScreenState extends State<AboutProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "О проекте",
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
            Container(
              height: 180,
              child: Image(
                image: Svg('assets/icons/reg/reg_logo.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "О приложении RecycleHub",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'RecycleHub – карманный гид в мире экологии для жителей Казани 🙌\n\nЧто вы найдёте в приложении? \n🌱точное описание маршрута до пунктов приема вторсырья \n🌱 возможность обмена вторсырья на сорторубли (бонусная единица измерения для обмена на бонусные товары и услуги от партнеров) \n🌱 интерактивный блок с ответами на вопросы \n🌱 образовательный блок с подробным описанием сортируемых категорий\n\nПомимо приложения на этой странице всегда можно будет найти дополнительную информационную поддержку Живем экологично вместе с RecycleHub 💚',
              style: TextStyle(fontSize: 14, fontFamily: 'GilroyMeduim'),
            ),
          ],
        ),
      ),
    );
  }
}
