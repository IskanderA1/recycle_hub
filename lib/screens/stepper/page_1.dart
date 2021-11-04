import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/style/theme.dart';

class Page1 extends StatelessWidget {
  static const _text =
      "Это приложение поможет вам найти ближайший пункт приема вторсырья и получить реальные деньги за отсортированный мусор из вашего дома";

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
            width: ScreenUtil().screenWidth * 0.9,
            height: ScreenUtil().screenHeight * 0.3,
            image: Svg('assets/icons/onboarding_1/People.svg'),
          ),
        ),
        Spacer(flex: 1),
        Text(
          "Привет!",
          style: TextStyle(
              color: kColorBlack,
              fontSize: 28,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w700),
        ),
        Spacer(flex: 1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'GilroyMedium',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
