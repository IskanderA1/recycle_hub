import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/elements/custom_bottom_sheet.dart';
import 'package:recycle_hub/icons/nav_bar_icons_icons.dart';
import 'package:recycle_hub/screens/qr_scanner_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
  AuthBloc authBLoc;

  @override
  void initState() {
    this.authBLoc = GetIt.I.get<AuthBloc>();
    super.initState();
  }

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
              children: [
                CustomPaint(
                  size: Size(size.width, 70),
                  painter: BNBCustomPainter(size: size),
                ),
                Center(
                  heightFactor: 0.3,
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: kColorGreen,
                      onPressed: () {
                        AuthState state = authBLoc.state;
                        if (state is AuthStateLogedIn) {
                          if (state.isAdmin) {
                            GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.QRSCANNER);
                            return;
                          }
                        }
                        showModalBottomSheetCustom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25))),
                          context: context,
                          builder: (context) {
                            if (state is AuthStateLogedIn) {
                              return QRCodeContainer(
                                userState: state,
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.qr_code,
                          size: size.width * 0.12,
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
                        icon: Icon(
                          NavBarIcons.location,
                          size: size.width / 13,
                        ),
                        spacing: 0,
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 0 ? true : false,
                        ontap: () {
                          GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.MAP);
                        },
                      ),
                      IconButtonV2(
                        label: "ЭкоГид",
                        icon: Icon(
                          NavBarIcons.ecogid,
                          size: size.width / 13,
                        ),
                        spacing: 4,
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 1 ? true : false,
                        ontap: () {
                          GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.ECO_GIDE);
                          GetIt.I.get<EcoGuideCubit>().moveTo(EcoGuideMenuItem.MENU);
                        },
                      ),
                      SizedBox(
                        width: size.width / 5,
                      ),
                      IconButtonV2(
                        label: "ЭкоКоин",
                        icon: Icon(
                          NavBarIcons.coin,
                          size: size.width / 13,
                        ),
                        spacing: 0,
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 2 ? true : false,
                        ontap: () {
                          GetIt.I.get<EcoCoinMenuCubit>().moveTo(EcoCoinMenuItems.MENU);
                          GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.ECO_COIN);
                        },
                      ),
                      IconButtonV2(
                        label: "Профиль",
                        icon: Icon(
                          NavBarIcons.profile,
                          size: size.width / 13,
                        ),
                        spacing: 0,
                        selectedIconThemeData: widget.selectedIconThemeData,
                        unselectedIconThemeData: widget.unselectedIconThemeData,
                        isActive: widget.currentItem == 3 ? true : false,
                        ontap: () {
                          GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.MENU);
                          GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.PROFILE);
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

    canvas.drawShadow(path, Colors.black, 5, true);
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
  final Widget icon;
  final IconThemeData unselectedIconThemeData;
  final IconThemeData selectedIconThemeData;
  final String label;
  final Function ontap;
  final bool isActive;
  final double spacing;
  IconButtonV2(
      {@required this.selectedIconThemeData,
      @required this.unselectedIconThemeData,
      @required this.icon,
      @required this.label,
      @required this.isActive,
      @required this.ontap,
      @required this.spacing});
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
                  SizedBox(
                    height: widget.spacing,
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
