import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/icons/user_profile_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

List<Widget> svgIcons = [];

class PointProfileScreen extends StatefulWidget {
  @override
  _PointProfileScreenState createState() => _PointProfileScreenState();
}

class _PointProfileScreenState extends State<PointProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kColorGreen,
        title: Text("Пункт приёма"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: kColorWhite,
          ),
          onPressed: () {
            GetIt.I
                .get<ProfileMenuCubit>()
                .moveTo(ProfileMenuStates.USER_PROFILE);
          },
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              height: 240,
              child: Image.asset(
                "svg/trash.jpg",
                fit: BoxFit.cover,
                height: 240,
                width: _size.width,
              ),
            ),
            Container(
              height: 240,
              color: Colors.black45,
            ),
            Container(
              child: ListView(
                padding:
                    EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 100),
                children: [
                  buildPointProfile(
                      "Пункт приёма Советский", "ООО НПП РИСАЛ", _size),
                  SizedBox(
                    height: _size.height * 0.08,
                  ),
                  buildStatus(10, 94),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 17, left: 17, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kColorWhite),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CommonCell(
                          onTap: () {
                            GetIt.I
                                .get<ProfileMenuCubit>()
                                .moveTo(ProfileMenuStates.PointEdit);
                          },
                          prefixIcon: Icon(
                            UserProfileIcons.user,
                            color: kColorGreyDark,
                          ),
                          text: 'Редактировать профиль',
                          arrowColor: kColorGreyDark,
                        ),
                        CommonCell(
                          onTap: () {
                            GetIt.I
                                .get<ProfileMenuCubit>()
                                .moveTo(ProfileMenuStates.PointWriteNews);
                          },
                          prefixIcon: Icon(
                            UserProfileIcons.user,
                            color: kColorGreyDark,
                          ),
                          text: 'Написать новости',
                          arrowColor: kColorGreyDark,
                        ),
                        CommonCell(
                          onTap: () {},
                          prefixIcon: Icon(
                            UserProfileIcons.pie_chart,
                            color: kColorGreyDark,
                          ),
                          text: 'Статистика',
                          arrowColor: kColorGreyDark,
                        ),
                        CommonCell(
                          onTap: () {},
                          prefixIcon: Icon(
                            UserProfileIcons.achievement,
                            color: kColorGreyDark,
                          ),
                          text: 'Достижения',
                          arrowColor: kColorGreyDark,
                        ),
                        CommonCell(
                          onTap: () {
                            GetIt.I.get<AuthBloc>().add(AuthEventLogout());
                          },
                          prefixIcon: Icon(
                            UserProfileIcons.log_out,
                            color: kColorGreyDark,
                          ),
                          text: 'Выйти',
                          arrowColor: kColorGreyDark,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPointProfile(String title, String subtitle, Size size) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          child: StarRating(
            rating: 2,
            spaceBetween: 1,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 115,
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
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: 115,
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
    padding: EdgeInsets.only(right: 17, left: 17, bottom: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), color: kColorWhite),
    child: Column(
      children: [
        buildListItem(0, "Редактировать профиль"),
        buildListItem(1, "Статистика"),
        buildListItem(2, "Как заработать баллы?"),
        buildListItem(3, "Задать вопрос авторам"),
        buildListItem(4, "Выйти"),
      ],
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
          Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              child: svgIcons[index]),
          SizedBox(
            width: 5,
          ),
          Text(text,
              style: TextStyle(
                color: index + 1 == svgIcons.length ? kColorRed : kColorBlack,
              ))
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
