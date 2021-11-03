import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/screens/stepper/confidentiality_policy_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:recycle_hub/helpers/network_helper.dart';

import 'second_custom_paint.dart';

class Page44 extends StatelessWidget {
  static const _text =
      "Мы не собираем лишних данных и запрашиваем только лишь доступ к местоположению во время работы приложения. Нажимая «Принять», вы соглашаетесь с ";
  static const _buttonText =
      "пользовательским соглашением и политикой конфиденциальности";
  final bool val;
  final Function onChaned;
  Page44({this.val, this.onChaned});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          //CustomPainterSecond(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 7,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Image(
                  width: ScreenUtil().screenWidth * 0.8,
                  height: ScreenUtil().screenHeight * 0.6,
                  //color: Color(0xFFDBCCB6),
                  image: Svg('assets/icons/onboarding_4/People.svg'),
                ),
              ),
              Spacer(flex: 1),
              Text(
                "Конфиденциальность",
                style: TextStyle(
                    color: kColorBlack,
                    fontSize: 28,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w700),
              ),
              Spacer(flex: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: _text,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "GilroyMedium",
                          color: kColorBlack),
                      children: <TextSpan>[
                        TextSpan(
                            text: _buttonText,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "GilroyMedium",
                                color: kColorBlack,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfidentialityPolicy(),
                                  ),
                                );
                              }),
                      ]),
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ],
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  static const _text =
      "Мы не собираем лишних данных и запрашиваем только лишь доступ к местоположению во время работы приложения. Нажимая «Принять», вы соглашаетесь с ";
  static const _buttonText_1 = "пользовательским соглашением";
  static const _buttonText_2 = "политикой конфиденциальности";
  final bool val;
  final Function onChaned;
  Page4({this.val, this.onChaned});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(
          flex: 7,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Image(
            width: ScreenUtil().screenWidth * 0.8,
            height: ScreenUtil().screenHeight * 0.3,
            image: Svg('assets/icons/onboarding_4/People.svg'),
          ),
        ),
        Spacer(flex: 1),
        Text(
          "Конфиденциальность",
          style: TextStyle(
              color: kColorBlack,
              fontSize: 28,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w700),
        ),
        Spacer(flex: 1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: _text,
              style: TextStyle(
                  fontSize: 16, fontFamily: "GilroyMedium", color: kColorBlack),
              children: <TextSpan>[
                TextSpan(
                  text: _buttonText_1,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GilroyMedium",
                      color: kColorBlack,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NetworkHelper.openUrl(
                          'https://recyclehub.ru/privacy/#/conditions/',
                          context);
                    },
                ),
                TextSpan(
                  text: ' и ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "GilroyMedium",
                    color: kColorBlack,
                  ),
                ),
                TextSpan(
                  text: _buttonText_2,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GilroyMedium",
                      color: kColorBlack,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NetworkHelper.openUrl(
                          'https://recyclehub.ru/privacy/#/', context);
                    },
                ),
              ],
            ),
          ),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
