import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:menu_button/menu_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

List<Widget> sIcons = [
  SvgPicture.asset("svg/blue_container.svg"),
  SvgPicture.asset("svg/yellow_container.svg"),
  SvgPicture.asset("svg/green_container.svg"),
  SvgPicture.asset("svg/red_container.svg"),
  SvgPicture.asset("svg/black_container.svg"),
  Icon(Icons.more_horiz, color: kColorBlack)
];

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  DropDownMenuItem _selectedItem = DropDownMenuItem(count: 1, name: "Месяц");
  List<DropDownMenuItem> _itemsList = [
    DropDownMenuItem(count: 1, name: "Неделя"),
    DropDownMenuItem(count: 1, name: "Месяц"),
    DropDownMenuItem(count: 3, name: "Месяца"),
    DropDownMenuItem(count: 1, name: "Год")
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        profileMenuBloc.mapEventToState(ProfileMenuStates.BACK);
        return;
      },
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Статистика",
            style: TextStyle(fontFamily: 'Gillroy'),
          ),
          leading: GestureDetector(
            onTap: () {
              profileMenuBloc.mapEventToState(ProfileMenuStates.BACK);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorWhite,
              size: 35,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2021",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  fontFamily: 'Gillroy'),
                            ),
                            Text("April 24 - May 24",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Gillroy')),
                          ],
                        ),
                        MenuButton<DropDownMenuItem>(
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          selectedItem: _selectedItem,
                          itemBackgroundColor: Color(0xFFF7F7F7),
                          menuButtonBackgroundColor: Color(0xFFF7F7F7),
                          child: NormalChildButton(
                            selectedItem: _selectedItem,
                          ),
                          items: _itemsList,
                          itemBuilder: (DropDownMenuItem item) => Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: Text("${item.count} ${item.name}"),
                          ),
                          toggledChild: Container(
                            child: NormalChildButton(
                              selectedItem: _selectedItem,
                            ),
                          ),
                          onItemSelected: (DropDownMenuItem item) {
                            setState(() {
                              _selectedItem = item;
                            });
                          },
                          onMenuButtonToggle: (bool isTohgle) {
                            print(isTohgle);
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Сколько сдал по отдельности",
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'GillroyMedium'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 0,
                            name: "Бумага",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 1,
                            name: "Пластик",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 2,
                            name: "Стекло",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 3,
                            name: "Отходы",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 4,
                            name: "Мусор",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: StatisticListElement(
                            svgId: 5,
                            name: "Прочие отходы",
                            kg: "24",
                            percent: "23",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDCF4E0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: kColorGreen,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Сдал всего",
                                          style: TextStyle(
                                            color: kColorGreyLight,
                                            fontSize: 12,
                                            fontFamily: 'Gillroy',
                                          )),
                                      Text("99.34",
                                      style: TextStyle(
                                            color: const Color(0xFF484848),
                                            fontSize: 13,
                                            fontFamily: 'Gillroy',
                                            fontWeight: FontWeight.bold
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF3DE77),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10))),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: const Color(0xFFC8BB42),
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Заработал",
                                          style: TextStyle(
                                            color: kColorGreyLight,
                                            fontSize: 12,
                                            fontFamily: 'Gillroy',
                                          )),
                                      Text(r'$'+" 14.34",
                                      style: TextStyle(
                                            color: const Color(0xFF484848),
                                            fontSize: 13,
                                            fontFamily: 'Gillroy',
                                            fontWeight: FontWeight.bold
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticListElement extends StatelessWidget {
  const StatisticListElement({
    Key key,
    @required this.svgId,
    @required this.name,
    @required this.kg,
    @required this.percent,
  }) : super(key: key);
  final int svgId;
  final String name;
  final String kg;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: sIcons[svgId],
          ),
          height: 40,
          width: 40,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            //width: ScreenUtil().screenWidth - 120,
            //padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Gillroy'),
                    ),
                    Column(
                      children: [
                        Text(
                          "${kg}кг",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gillroy'),
                        ),
                        Text(
                          "${percent}% от общего",
                          style: TextStyle(
                              fontSize: 10,
                              color: kColorBlack.withOpacity(0.6),
                              fontFamily: 'Gillroy'),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                StepProgressIndicator(
                  totalSteps: 100,
                  direction: Axis.horizontal,
                  currentStep: 34,
                  size: 10,
                  selectedSize: 8,
                  unselectedSize: 8,
                  padding: 0,
                  selectedColor: kColorGreen,
                  unselectedColor: Color(0xFFF7F7F7),
                  roundedEdges: Radius.circular(5),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NormalChildButton extends StatelessWidget {
  const NormalChildButton({
    Key key,
    @required DropDownMenuItem selectedItem,
  })  : _selectedItem = selectedItem,
        super(key: key);

  final DropDownMenuItem _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20)
      ),
      width: 120,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(
              "${_selectedItem.count} ${_selectedItem.name}",
              overflow: TextOverflow.visible,
            )),
            const SizedBox(
              width: 15,
              height: 20,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: kColorGreyLight,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownMenuItem {
  String name;
  int count;
  DropDownMenuItem({@required this.name, @required this.count});
}
