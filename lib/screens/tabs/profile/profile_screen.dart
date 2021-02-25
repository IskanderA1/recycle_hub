import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../style/theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        color: kColorGreen,
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            buildAppBar(),
            SizedBox(height: 17,),
            buildProfileAvatar("Иван Иванов", "ЭКОЛОГ"),
            SizedBox(height: 24,),
            buildStatus(10, 78, 94),
            SizedBox(height: 20,),
            buildAchievments("Эколог", 94.3)
          ],
        ),
      ),
    );
  }
}

Widget buildAppBar() {
  return Stack(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: kColorWhite,
          ),
          onPressed: () {},
          padding: EdgeInsets.all(0),
        ),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(
            "Профиль",
            style: TextStyle(fontSize: 18, color: kColorWhite),
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
              Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kColorWhite),
                      child: SvgPicture.asset("svg/Camera.svg"),
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
        decoration: BoxDecoration(
            color: (0 < lastKGindex) ? kColorGreen : kColorGreyLight,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
        child: (0 < lastKGindex)
            ? Text(
                "0кг",
                style: TextStyle(fontSize: 12, color: kColorGreyDark),
              )
            : Container(),
      ),
      Container(
        decoration: BoxDecoration(
          color: (1 < lastKGindex) ? kColorGreen : kColorGreyLight,
        ),
        child: (1 < lastKGindex)
            ? Text(
                "50кг",
                style: TextStyle(fontSize: 12, color: kColorGreyDark),
              )
            : Container(),
      ),
      Container(
        decoration: BoxDecoration(
          color: (2 < lastKGindex) ? kColorGreen : kColorGreyLight,
        ),
        child: (2 < lastKGindex)
            ? Text(
                "100кг",
                style: TextStyle(fontSize: 12, color: kColorGreyDark),
              )
            : Container(),
      ),
      Container(
        decoration: BoxDecoration(
          color: (3 < lastKGindex) ? kColorGreen : kColorGreyLight,
        ),
        child: (3 < lastKGindex)
            ? Text(
                "250кг",
                style: TextStyle(fontSize: 12, color: kColorGreyDark),
              )
            : Container(),
      ),
      Container(
        decoration: BoxDecoration(
            color: (4 < lastKGindex) ? kColorGreen : kColorGreyLight,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: (4 < lastKGindex)
            ? Text(
                "500кг",
                style: TextStyle(fontSize: 12, color: kColorGreyDark),
              )
            : Container(),
      ),
    ],
  );
}

profileScreenAppBar() {
  return AppBar();
}
