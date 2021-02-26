import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../style/theme.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';

List<Widget> svgIcons = [
  Icon(
    Icons.account_box_outlined,
    color: kColorPink,
  ),
  Icon(
    Icons.graphic_eq_outlined,
    color: kColorPink,
  ),
  Icon(
    Icons.handyman_outlined,
    color: kColorPink,
  ),
  Icon(
    Icons.support_outlined,
    color: kColorPink,
  ),
  Icon(
    Icons.exit_to_app_outlined,
    color: kColorPink,
  ),
];

class PointProfileScreen extends StatefulWidget {
  @override
  _PointProfileScreenState createState() => _PointProfileScreenState();
}

class _PointProfileScreenState extends State<PointProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        profileMenuBloc.mapEventToState(ProfileMenuEvents.USER_PROFILE);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kColorGreen,
          title: Text("Пункт приёма"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: kColorWhite,
            ),
            onPressed: () {
              profileMenuBloc.mapEventToState(ProfileMenuEvents.USER_PROFILE);
            },
          ),
        ),
        body: Container(
          height: _size.height,
          width: _size.width,
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Image.asset(
                "svg/trash.jpg",
              ),
              Container(
                height: 226,
                color: Colors.black45,
              ),
              Container(
                padding: EdgeInsets.only(left: 17, right: 17, top: 10),
                child: Column(
                  children: [
                    buildPointProfile(
                        "Пункт приёма Советский", "ООО НПП РИСАЛ"),
                    SizedBox(
                      height: 24,
                    ),
                    buildStatus(10, 94),
                    SizedBox(
                      height: 20,
                    ),
                    buildMenu(_size.height * 0.4)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPointProfile(String title, String subtitle) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 160),
          child: StarRating(
            rating: 2,
            spaceBetween: 5,
            starConfig: StarConfig(
                size: 25,
                fillColor: kColorGreen,
                emptyColor: Colors.white,
                strokeWidth: 0,
                strokeColor: Colors.transparent),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(color: kColorWhite, fontSize: 24),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(color: kColorWhite, fontSize: 18),
        ),
      ],
    ),
  );
}

Widget buildStatus(int place, int made) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kColorWhite),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("$place",
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 36,
                  )),
              SizedBox(height: 5),
              Wrap(
                children: [
                  Text(
                    "Место в общем зачете",
                    style: TextStyle(color: kColorBlack, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kColorWhite),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("$made",
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 36,
                  )),
              SizedBox(height: 5),
              Wrap(
                children: [
                  Text(
                    "Всего сдано вторсырье(кг)",
                    style: TextStyle(color: kColorBlack, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAchievments(String status, double made) {
  return Container(
    decoration: BoxDecoration(
      color: kColorWhite,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.only(top: 12, bottom: 12, right: 19, left: 19),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset("svg/dostizheniya.svg"),
            SizedBox(
              width: 15,
            ),
            Text("Достижения",
                style: TextStyle(color: kColorBlack, fontSize: 14))
          ],
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Статус:",
                    style: TextStyle(
                      color: kColorBlack,
                      fontSize: 14,
                    )),
                SizedBox(width: 14),
                Text(
                  status,
                  style: TextStyle(
                      color: kColorGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        )),
        SizedBox(
          height: 7,
        ),
        _buildProgressIndicator(2),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              "Всего сдано: ",
              style: TextStyle(fontSize: 14, color: kColorBlack),
            ),
            Text(
              "$made",
              style: TextStyle(
                  color: kColorBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text("кг",
                style: TextStyle(
                  color: kColorBlack,
                  fontSize: 14,
                ))
          ],
        )
      ],
    ),
  );
}

Widget _buildProgressIndicator(int lastKGindex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          height: 20,
          width: 50,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: (0 < lastKGindex) ? kColorGreen : kLightGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: (0 < lastKGindex)
              ? Container()
              : Text(
                  "0кг",
                  style: TextStyle(fontSize: 12, color: kColorGreyDark),
                )),
      Container(
          height: 20,
          width: 50,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (1 < lastKGindex) ? kColorGreen : kLightGrey,
          ),
          child: (1 < lastKGindex)
              ? Container()
              : Text(
                  "50кг",
                  style: TextStyle(fontSize: 12, color: kColorGreyDark),
                )),
      Container(
          height: 20,
          width: 50,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (2 < lastKGindex) ? kColorGreen : kLightGrey,
          ),
          child: (2 < lastKGindex)
              ? Container()
              : Text(
                  "100кг",
                  style: TextStyle(fontSize: 12, color: kColorGreyDark),
                )),
      Container(
          height: 20,
          width: 50,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (3 < lastKGindex) ? kColorGreen : kLightGrey,
          ),
          child: (3 < lastKGindex)
              ? Container()
              : Text(
                  "250кг",
                  style: TextStyle(fontSize: 12, color: kColorGreyDark),
                )),
      Container(
          height: 20,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: (4 < lastKGindex) ? kColorGreen : kLightGrey,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: (4 < lastKGindex)
              ? Container()
              : Text(
                  "500кг",
                  style: TextStyle(fontSize: 12, color: kColorGreyDark),
                )),
    ],
  );
}

Widget buildMenu(double size) {
  return Container(
    height: size,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), color: kColorWhite),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ListView(
        padding: EdgeInsets.only(top: 17, bottom: 35, right: 17, left: 17),
        children: [
          buildListItem(0, "Редактировать профиль"),
          buildListItem(1, "Статистика"),
          buildListItem(2, "Как заработать баллы?"),
          buildListItem(3, "Задать вопрос авторам"),
          buildListItem(4, "Выйти"),
        ],
      ),
    ),
  );
}

Widget buildListItem(int index, String text) {
  return Container(
    padding: EdgeInsets.only(top: 12, bottom: 12),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kColorGreyDark, width: 0.5))),
    child: Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          svgIcons[index],
          SizedBox(
            width: 5,
          ),
          Text(text)
        ],
      ),
      Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            color: kLightGrey,
          ))
    ]),
  );
}

profileScreenAppBar() {
  return AppBar();
}
