import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CheckBoxCell extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onTap;
  CheckBoxCell({this.isSelected, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
      },
      child: Row(
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected ? kColorGreen : kColorWhite,
                border: Border.all(color: kColorGreyDark)),
            child: Icon(
              Icons.check,
              color: kColorWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              text,
              style: TextStyle(color: kColorBlack, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
