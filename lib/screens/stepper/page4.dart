import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
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
        Spacer(flex: 4),
      ],
    ));
  }
}
