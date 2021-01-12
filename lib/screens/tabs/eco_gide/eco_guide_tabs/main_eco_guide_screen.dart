import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/advice_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/container_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/do_test_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/question_answer.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/reference_book_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/search_screen.dart';
import 'package:recycle_hub/style/style.dart';

import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';
import '../../../../style/theme.dart';

List<String> titles = [
  "Поиск",
  "Виды отходов",
  "Справочник маркировок",
  "Советы для экономики",
  "Вопросы и ответы",
  "Пройти тест"
];

List<Icon> icons = [
  Icon(Icons.search_rounded),
  Icon(Icons.restore_from_trash_outlined),
  Icon(Icons.book),
  Icon(Icons.monetization_on_outlined),
  Icon(Icons.question_answer_outlined),
  Icon(Icons.contact_support_outlined)
];

class MainEcoGuideScreen extends StatefulWidget {
  @override
  _MainEcoGuideScreenState createState() => _MainEcoGuideScreenState();
}

class _MainEcoGuideScreenState extends State<MainEcoGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ЭкоГид",
        ),
        centerTitle: true,
        iconTheme: IconThemeData(size: 1),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child: ListView(
                      children: _buildButton(context),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: customDrawer,
    );
  }
}

List<Container> _buildButton(BuildContext context) {
  List<Container> buttonContainer = [];
  for (int i = 0; i < titles.length; i++) {
    buttonContainer.add(Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kColorGreyLight
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          ecoMenu.pickItem(i);
        },
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 66,
              height: 55,
              child: ListTile(
                leading: icons[i],
                title: Text(
                  titles[i],
                  style: TextStyle(color: kColorGreyLight),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kColorGreyLight,
            )
          ],
        ),
      ),
    ));
  }
  return buttonContainer;
}
