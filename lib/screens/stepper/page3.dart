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
        //CustomPainterFirst(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 7,),
            Container(
              padding: const EdgeInsets.symmetric(
                    horizontal: 80),
              child: Image(
                width: ScreenUtil().screenWidth * 0.8,
                height: ScreenUtil().screenWidth * 0.6,
                //color: Color(0xFFDBCCB6),
                image: Svg('assets/icons/onboarding_3/People.svg'),
              ),
            ),
            Spacer(flex: 2),
            Text(
              "REUSE",
              style: TextStyle(
                  color: kColorBlack,
                  fontSize: 35,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w700),
            ),
            Spacer(flex: 5),
          ],
        ),
      ],
    ));
  }
}
