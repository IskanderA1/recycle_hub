import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {this.backGroundColor = kColorGreen,
      this.textColor = kColorBlack,
      this.height,
      this.width,
      @required this.text,
      this.isExpanded = false,
      this.ontap,
      this.borderRadius = const BorderRadius.all(
        Radius.circular(16),
      ),
      this.shape = BoxShape.rectangle});
  final Color backGroundColor;
  final Color textColor;
  final double height;
  final double width;
  final Function ontap;
  final String text;
  final bool isExpanded;
  final BorderRadiusGeometry borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    if (isExpanded || width == null || height == null) {
      return InkWell(
        onTap: () {
          if (ontap != null) ontap();
        },
        child: Container(
            decoration: BoxDecoration(color: backGroundColor, borderRadius: borderRadius, shape: shape),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: buildButton(),
            )),
      );
    } else {
      return InkWell(
        onTap: () {
          if (ontap != null) ontap();
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: backGroundColor, shape: shape, borderRadius: borderRadius),
          child: buildButton(),
        ),
      );
    }
  }

  Widget buildButton() {
    return Center(
        child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontFamily: 'GilroyMedium',
      ),
    ));
  }
}
