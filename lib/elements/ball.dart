import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class BallGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kColorGreen
      ),
    );
  }
}