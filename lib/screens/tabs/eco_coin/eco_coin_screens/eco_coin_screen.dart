import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_coin_bloc.dart/eco_coin_menu_bloc.dart';
import 'package:recycle_hub/icons/eco_coin_icons_icons.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class EcoCoinScreen extends StatefulWidget {
  @override
  _EcoCoinScreenState createState() => _EcoCoinScreenState();
}

class _EcoCoinScreenState extends State<EcoCoinScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ecoCoinMenuBloc.pickState(EcoCoinMenuItems.MENU),
          child: Scaffold(
        body: Container(
          color: Color(0xFFF2F2F2),
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size.width, size.height),
                painter: EcoCoinCustomPainter(size: size),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Positioned(
                top: size.height * 0.12,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: size.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: RichText(
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "  "),
                                  TextSpan(
                                      text: kEcoCoinString,
                                      children: [TextSpan(text: "  ")],
                                      style: const TextStyle(
                                          color: kColorBlack,
                                          fontSize: 14,
                                          fontFamily: 'GillRoyMedium')),
                                ],
                                style: const TextStyle(
                                    color: kColorBlack,
                                    fontSize: 14,
                                    fontFamily: 'GillRoyMedium')),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: size.height * 0.8,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              MenuItemWidget(
                                name: "Магазин",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.STORE),
                                iconData: EcoCoinIcons.shoppingcart,
                              ),
                              EcoCoinHorisontalDivider(),
                              MenuItemWidget(
                                name: "Сдать вторсырье",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.GIVEGARBAGE),
                                iconData: EcoCoinIcons.recyclebin,
                              ),
                              EcoCoinHorisontalDivider(),
                              MenuItemWidget(
                                name: "Добавить новый пункт приема",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.OFFERNEWPOINT),
                                iconData: EcoCoinIcons.addpointer,
                              ),
                              EcoCoinHorisontalDivider(),
                              MenuItemWidget(
                                name: "Ответить на вопросы из ЭкоГида",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.ANSWERQUESTS),
                                iconData: EcoCoinIcons.question,
                              ),
                              EcoCoinHorisontalDivider(),
                              MenuItemWidget(
                                name: "Порекомендуйте нас друзьям",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.RECOMMEND),
                                iconData: EcoCoinIcons.adduser,
                              ),
                              EcoCoinHorisontalDivider(),
                              MenuItemWidget(
                                name: "Оцените наше приложение\nв маркете",
                                func: ()=>ecoCoinMenuBloc.pickState(EcoCoinMenuItems.FEEDBACK),
                                iconData: EcoCoinIcons.reviews,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EcoCoinHorisontalDivider extends StatelessWidget {
  const EcoCoinHorisontalDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Divider(
        color: Color(0xFF8D8D8D),
        height: 1,
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    Key key,
    @required this.func,
    @required this.name,
    @required this.iconData,
  }) : super(key: key);

  final Function func;
  final String name;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            iconData,
            color: Color(0xFF8D8D8D),
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          RichText(
            overflow: TextOverflow.visible,
            text: TextSpan(
              text: name,
              style: TextStyle(
                  color: kColorBlack,
                  fontFamily: 'GillroyMedium',
                  fontSize: 14),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xFF8D8D8D),
            size: 25,
          )
        ],
      ),
    );
  }
}

ecoCoinScreenAppBar() {
  return AppBar();
}

class EcoCoinCustomPainter extends CustomPainter {
  EcoCoinCustomPainter({this.size});
  final Size size;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kColorGreen
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
  path.lineTo(0, size.height * 0.15);
  path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.3, size.width, size.height * 0.15);
  /*path.arcToPoint(Offset(size.width, size.height * 0.2),
      radius: Radius.circular(50), clockwise: false,
      largeArc: true);*/
  //path.quadraticBezierTo(size.width * 0.63, 1, size.width * 0.70, 0);
  path.lineTo(size.width, 0);
  path.lineTo(0, 0);
  return path;
}