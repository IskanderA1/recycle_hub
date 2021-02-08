import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/elements/input_style.dart';
import '../../../../style/theme.dart';

List<String> titles = [
  "Виды отходов",
  "Справочник маркировок",
  "Советы для экономии",
  "Пройти тест"
];

List<Icon> icons = [
  Icon(Icons.restore_from_trash_outlined),
  Icon(Icons.book),
  Icon(Icons.monetization_on_outlined),
  Icon(Icons.contact_support_outlined)
];

class MainEcoGuideScreen extends StatefulWidget {
  @override
  _MainEcoGuideScreenState createState() => _MainEcoGuideScreenState();
}

class _MainEcoGuideScreenState extends State<MainEcoGuideScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
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
                height: 60,
                margin: EdgeInsets.only(top: 7, bottom: 5),
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: inputDecorWidget(),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView(
                      children: _buildButton(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
        border: Border.all(color: kColorGreyLight),
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
