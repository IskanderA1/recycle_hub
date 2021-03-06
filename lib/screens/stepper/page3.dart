import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/style/theme.dart';

import 'first_custom_paint.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        CustomPainterFirst(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Stack(children: [
                Image(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight * 0.4,
                  color: Color(0xFFDBCCB6),
                  image: Svg('assets/icons/onboarding_3/Clouds.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 100),
                  child: Image(
                    width: ScreenUtil().screenWidth * 0.8,
                    height: ScreenUtil().screenWidth * 0.6,
                    //color: Color(0xFFDBCCB6),
                    image: Svg('assets/icons/onboarding_3/People.svg'),
                  ),
                )
              ]),
            ),
            Spacer(flex: 1),
            Text(
              "REUSE",
              style: TextStyle(
                  color: kColorBlack,
                  fontSize: 35,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w700),
            ),
            Spacer(flex: 4),
          ],
        ),
      ],
    ));
  }
}
