import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class BottomNavBarV2 extends StatefulWidget {
  final IconThemeData unselectedIconThemeData;
  final IconThemeData selectedIconThemeData;
  final int currentItem;
  final Color backgraundColor;

  BottomNavBarV2(
      {@required this.selectedIconThemeData,
      @required this.unselectedIconThemeData,
      @required this.currentItem,
      @required this.backgraundColor});
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 70,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 70),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.3,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: kColorGreen,
                    onPressed: () {},
                    child: Container(
                      child: Icon(
                        Icons.qr_code,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: IconButtonV2(
                          label: "Карта",
                          icon: Icon(Icons.map_outlined),
                          selectedIconThemeData: widget.selectedIconThemeData,
                          unselectedIconThemeData:
                              widget.unselectedIconThemeData,
                          isActive: widget.currentItem == 0 ? true : false,
                          ontap: () {
                            bottomNavBarBloc.pickItem(0);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: IconButtonV2(
                          label: "ЭкоГид",
                          icon: Icon(Icons.school_outlined),
                          selectedIconThemeData: widget.selectedIconThemeData,
                          unselectedIconThemeData:
                              widget.unselectedIconThemeData,
                          isActive: widget.currentItem == 1 ? true : false,
                          ontap: () {
                            bottomNavBarBloc.pickItem(1);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Container(
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: IconButtonV2(
                          label: "ЭкоКоин",
                          icon: Icon(Icons.copyright_outlined),
                          selectedIconThemeData: widget.selectedIconThemeData,
                          unselectedIconThemeData:
                              widget.unselectedIconThemeData,
                          isActive: widget.currentItem == 2 ? true : false,
                          ontap: () {
                            bottomNavBarBloc.pickItem(2);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: IconButtonV2(
                          label: "Профиль",
                          icon: Icon(Icons.person_outlined),
                          selectedIconThemeData: widget.selectedIconThemeData,
                          unselectedIconThemeData:
                              widget.unselectedIconThemeData,
                          isActive: widget.currentItem == 3 ? true : false,
                          ontap: () {
                            bottomNavBarBloc.pickItem(3);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.42, 0, size.width * 0.42, 13);
    path.arcToPoint(Offset(size.width * 0.58, 13),
        radius: Radius.circular(33.2), clockwise: false);
    path.quadraticBezierTo(size.width * 0.58, 0, size.width * 0.65, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class IconButtonV2 extends StatefulWidget {
  final Icon icon;
  final IconThemeData unselectedIconThemeData;
  final IconThemeData selectedIconThemeData;
  final String label;
  final Function ontap;
  final bool isActive;
  IconButtonV2(
      {@required this.selectedIconThemeData,
      @required this.unselectedIconThemeData,
      @required this.icon,
      @required this.label,
      @required this.isActive,
      @required this.ontap});
  @override
  _IconButtonV2State createState() => _IconButtonV2State();
}

class _IconButtonV2State extends State<IconButtonV2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        width: 70,
        height: 60,
        child: Column(
          children: [
            IconTheme(
              child: widget.icon,
              data: widget.isActive
                  ? widget.selectedIconThemeData
                  : widget.unselectedIconThemeData,
            ),
            Text(widget.label,
                style: TextStyle(
                    fontSize: 12,
                    color: widget.isActive ? kColorGreen : kColorGreyLight))
          ],
        ),
      ),
    );
  }
}
