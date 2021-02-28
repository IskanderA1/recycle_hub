import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/bloc/qr_bloc.dart';
import 'package:recycle_hub/screens/qr_scanner_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BottomNavBarV2 extends StatefulWidget {
  final IconThemeData unselectedIconThemeData;
  final IconThemeData selectedIconThemeData;
  final int currentItem;
  final Color backgraundColor;
  Function func;

  BottomNavBarV2(
      {@required this.selectedIconThemeData,
      @required this.unselectedIconThemeData,
      @required this.currentItem,
      @required this.backgraundColor,
      @required this.func});
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
          //top: 200,
          //right: 10,
          child: Container(
            width: size.width,
            height: 70,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 70),
                  painter: BNBCustomPainter(size: size),
                ),
                Center(
                  heightFactor: 0.3,
                  child: Container(
                    height: 80,
                    width: 80,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: kColorGreen,
                      onPressed: () {
                        qrBloc
                            .mapEventToState(QRInitialEvent(context: context));
                      },
                      child: Container(
                        child: Icon(
                          Icons.qr_code,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  //height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButtonV2(
                        label: "Карта",
                        icon: Icon(Icons.map_outlined),
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 0 ? true : false,
                        ontap: () {
                          widget.func(0);
                          bottomNavBarBloc.pickItem(0);
                        },
                      ),
                      IconButtonV2(
                        label: "ЭкоГид",
                        icon: Icon(Icons.school_outlined),
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 1 ? true : false,
                        ontap: () {
                          widget.func(1);
                          bottomNavBarBloc.pickItem(1);
                          ecoMenu.backToMenu();
                        },
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 5),
                      ),
                      IconButtonV2(
                        label: "ЭкоКоин",
                        icon: Icon(Icons.copyright_outlined),
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 2 ? true : false,
                        ontap: () {
                          widget.func(2);
                          bottomNavBarBloc.pickItem(2);
                        },
                      ),
                      IconButtonV2(
                        label: "Профиль",
                        icon: Icon(Icons.person_outlined),
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 3 ? true : false,
                        ontap: () {
                          widget.func(3);
                          bottomNavBarBloc.pickItem(3);
                        },
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
  BNBCustomPainter({this.size});
  final Size size;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = getClip(size);
    /*path.moveTo(0, 0); // Start
    path.lineTo(size.width * 0.30, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 13);
    path.arcToPoint(Offset(size.width * 0.60, 13),
        radius: Radius.circular(33.2), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);*/

    //canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Path getClip(Size size) {
  Path path = Path();
  path.moveTo(0, 0); // Start
  path.lineTo(size.width * 0.30, 0);
  path.quadraticBezierTo(size.width * 0.37, 1, size.width * 0.42, 35);
  path.arcToPoint(Offset(size.width * 0.58, 35),
      radius: Radius.circular(40), clockwise: false);
  path.quadraticBezierTo(size.width * 0.63, 1, size.width * 0.70, 0);
  path.lineTo(size.width, 0);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.lineTo(0, 0);
  return path;
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
    final double size = (MediaQuery.of(context).size.width / 5);
    return GestureDetector(
      onTap: widget.ontap,
      child: Material(
        color: Color(0x00FFFFFF),
        child: LayoutBuilder(builder: (context, constraint) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size, minWidth: size),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTheme(
                      child: widget.icon,
                      data: widget.isActive
                          ? widget
                              .selectedIconThemeData /*.copyWith(size: size)*/
                          : widget.unselectedIconThemeData
                      //.copyWith(size: size + 3),
                      ),
                  AutoSizeText(widget.label,
                      style: TextStyle(
                          fontSize: 12,
                          color:
                              widget.isActive ? kColorGreen : kColorGreyLight))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
