import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {this.backGroundColor = kColorGreen,
      this.textColor = kColorBlack,
      @required this.height,
      @required this.width,
      @required this.text,
      this.ontap});
  final Color backGroundColor;
  final Color textColor;
  final double height;
  final double width;
  final Function ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ontap != null) ontap();
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: textColor),
          )),
        ),
      ),
    );
  }
}
