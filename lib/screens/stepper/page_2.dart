import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/style/theme.dart';
import 'second_custom_paint.dart';

class Page2 extends StatelessWidget {
  static const _text =
      "Мы научимся правильной сортировке бытовых отходов и поможем нашей планете стать чище. Для этого в приложении мы разработали ЭкоГид, который поможет во всем разобраться";
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
            //color: Color(0xFFDBCCB6),
            image: Svg('assets/icons/onboarding_2/People.svg'),
          ),
        ),
        Spacer(flex: 2),
        Text(
          "Вместе",
          style: TextStyle(
              color: kColorBlack,
              fontSize: 28,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w700),
        ),
        Spacer(),
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
