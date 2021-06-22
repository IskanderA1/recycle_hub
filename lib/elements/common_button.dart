import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {this.backGroundColor = kColorGreen,
      this.textColor = kColorBlack,
      this.height,
      this.width,
      @required this.text,
      this.isExpanded = false,
      this.ontap});
  final Color backGroundColor;
  final Color textColor;
  final double height;
  final double width;
  final Function ontap;
  final String text;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    if (isExpanded || width == null || height == null) {
      return Container(
          decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: buildButton(),
          ));
    } else {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: buildButton(),
      );
    }
  }

  Widget buildButton() {
    return InkWell(
      onTap: () {
        if (ontap != null) ontap();
      },
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontFamily: 'GilroyMedium',
        ),
      )),
    );
  }
}
