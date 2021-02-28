import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../style/theme.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';

List<Widget> svgIcons = [
  Image.asset("svg/profile.png"),
  Image.asset("svg/cash.png"),
  Image.asset("svg/stats.png"),
  Image.asset("svg/cash-hand.png"),
  SvgPicture.asset("svg/question.svg"),
  Image.asset("svg/log-out.png")
];

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        profileMenuBloc.mapEventToState(ProfileMenuEvents.USER_PROFILE);
      },
      child: Scaffold(
        body: Container(
          height: _size.height,
          width: _size.width,
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Image.asset("svg/Mask Group.png"),
              Container(
                padding: EdgeInsets.only(left: 17, right: 17, top: 10),
                child: Column(
                  children: [
                    buildAppBar(),
                    SizedBox(
                      height: 17,
                    ),
                    buildProfileAvatar("Иван Иванов", "ЭКОЛОГ"),
                    SizedBox(
                      height: 24,
                    ),
                    buildStatus(10, 78, 94),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: _size.height - _size.height * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 45, top: 10),
                          children: [
                            buildAchievments("Эколог", 94.3),
                            SizedBox(
                              height: 20,
                            ),
                            buildMenu()
                          ],
                        ),
                      ),
                    ),
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

Widget buildAppBar() {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(top: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              profileMenuBloc.mapEventToState(ProfileMenuEvents.POINT_PROFILE);
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: kColorWhite,
              size: 30,
            ),
          ),
        ),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Профиль",
            style: TextStyle(
                fontSize: 18, color: kColorWhite, fontWeight: FontWeight.bold),
          ))
    ],
  );
}

Widget buildProfileAvatar(String username, String status) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                  height: 82,
                  width: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorPink,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(41),
                    child: Image.network(
                        "https://idsb.tmgrup.com.tr/ly/uploads/images/2020/04/30/33310.jpg"),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 50, left: 50),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kColorWhite),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: kColorGreen,
                        size: 21,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username,
                style: TextStyle(
                  color: kColorWhite,
                  fontSize: 18,
                )),
            Text(status,
                style: TextStyle(
                  color: kColorWhite,
                  fontSize: 12,
                ))
          ],
        )
      ],
    ),
  );
}

Widget buildStatus(int place, int balance, int made) {
  return Container(
    decoration: BoxDecoration(
      color: kColorWhite,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.all(26),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$place",
              style: TextStyle(color: kColorBlack, fontSize: 36),
            ),
            Text(
              "Место",
              style: TextStyle(color: kColorBlack, fontSize: 16),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$balance",
              style: TextStyle(color: kColorBlack, fontSize: 36),
            ),
            Text(
              "Баланс",
              style: TextStyle(color: kColorBlack, fontSize: 16),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$made",
              style: TextStyle(color: kColorBlack, fontSize: 36),
            ),
            Text(
              "Сдал(кг)",
              style: TextStyle(color: kColorBlack, fontSize: 16),
            )
          ],
        )
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

Widget buildMenu() {
  return Container(
    padding: EdgeInsets.only(top: 17, bottom: 35, right: 17, left: 17),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), color: kColorWhite),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          buildListItem(0, "Редактировать профиль"),
          buildListItem(1, "Кошелек"),
          buildListItem(2, "Статистика"),
          buildListItem(3, "Как заработать баллы?"),
          buildListItem(4, "Задать вопрос авторам"),
          buildListItem(5, "Выйти"),
        ],
      ),
    ),
  );
}

Widget buildListItem(int index, String text) {
  return Container(
    padding: EdgeInsets.only(top: 12, bottom: 12),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kLightGrey, width: 0.5))),
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
