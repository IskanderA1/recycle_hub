import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/icons/eco_guide_icons_icons.dart';
import '../../../../style/theme.dart';

List<String> titles = [
  "Виды отходов",
  "Справочник маркировок",
  "Советы для экономии",
  "Пройти тест"
];

List<IconData> icons = [
  EcoGuideIcons.recyclebin,
  EcoGuideIcons.book,
  EcoGuideIcons.project,
  EcoGuideIcons.brain,
];

class MainEcoGuideScreen extends StatefulWidget {
  @override
  _MainEcoGuideScreenState createState() => _MainEcoGuideScreenState();
  final TextEditingController _searchController = TextEditingController();
}

class _MainEcoGuideScreenState extends State<MainEcoGuideScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Text(
            "ЭкоГид",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(size: 1),
        ),
        body: Container(
          height: _size.height - 26,
          width: _size.width,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: BoxDecoration(
              color: kColorWhite, borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kColorGreyVeryLight,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: kColorBlack,
                      ),
                      hintText: "Что вы хотите сдать",
                      contentPadding: EdgeInsets.only(left: 16, top: 14)),
                  controller: widget._searchController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  buildBtn("Виды отходов", 0),
                  buildBtn("Справочник маркировок", 1),
                  buildBtn("Советы для экономии", 2),
                  buildBtn("Пройти тест", 3)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBtn(String text, int index) {
  return InkWell(
    onTap: () {
      GetIt.I.get<EcoGuideCubit>().moveTo(EcoGuideMenuItem.values[index]);
    },
    child: Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: kColorGreyLight, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 25,
                width: 25,
                child: Icon(icons[index], size: 25, color: kColorGreyDark),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                text,
                style: TextStyle(
                    color: kColorBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: kColorGreyLight,
          )
        ],
      ),
    ),
  );
}
