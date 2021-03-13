import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/screens/stepper/confidentiality_policy_screen.dart';
import 'package:recycle_hub/style/theme.dart';

import 'second_custom_paint.dart';

class Page4 extends StatelessWidget {
  final bool val;
  final Function onChaned;
  Page4({this.val, this.onChaned});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        CustomPainterSecond(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Stack(children: [
                Image(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight * 0.4,
                  color: Color(0xFFDBCCB6),
                  image: Svg('assets/icons/onboarding_4/Clouds.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 100),
                  child: Image(
                    width: ScreenUtil().screenWidth * 0.8,
                    height: ScreenUtil().screenWidth * 0.6,
                    //color: Color(0xFFDBCCB6),
                    image: Svg('assets/icons/onboarding_4/People.svg'),
                  ),
                )
              ]),
            ),
            Spacer(flex: 1),
            Text(
              "CONFIDENTIALITY",
              style: TextStyle(
                  color: kColorWhite,
                  fontSize: 35,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w700),
            ),
            Spacer(flex: 1),
            Container(
              width: 300,
              child: RichText(
                text: TextSpan(
                    text: "Нажимая Принять, вы соглашаетесь с ",
                    style: TextStyle(
                        fontSize: 16, fontFamily: "Gilroy", color: kColorWhite),
                    children: <TextSpan>[
                      TextSpan(
                          text: "политикой конфиденциальности.",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy",
                              color: kColorWhite,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfidentialityPolicy()));
                            }),
                    ]),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ],
    ));
  }
}
