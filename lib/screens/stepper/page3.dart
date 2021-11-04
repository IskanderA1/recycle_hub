import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/style/theme.dart';

class Page3 extends StatelessWidget {
  static const _text =
      "За выполнение заданий, которые помогают приложению становиться лучше. Затем вы сможете обменять ЭкоКоины на товары и услуги партнеров сервиса";

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
            image: Svg('assets/icons/onboarding_3/People.svg'),
          ),
        ),
        Spacer(flex: 1),
        Text(
          "Получайте ЭкоКоины",
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