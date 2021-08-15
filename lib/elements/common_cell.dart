import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CommonCell extends StatelessWidget {
  CommonCell(
      {this.onTap,
      this.prefixIcon,
      this.text,
      this.arrowColor = kColorBlack,
      this.textColor = kColorBlack,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.contentPadding = const EdgeInsets.only(top: 12, bottom: 12),
      this.padding = const EdgeInsets.all(0)});

  final Function onTap;
  final Widget prefixIcon;
  final String text;
  final Color arrowColor;
  final Color textColor;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          padding: contentPadding,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: kLightGrey, width: 0.5))),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              if (prefixIcon != null)
                Container(height: 30, width: 30, child: prefixIcon),
              if (prefixIcon != null)
                SizedBox(
                  width: 5,
                ),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: kLightGrey,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
