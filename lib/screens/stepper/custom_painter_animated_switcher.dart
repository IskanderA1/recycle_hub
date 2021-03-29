import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/stepper/first_custom_paint.dart';
import 'package:recycle_hub/screens/stepper/second_custom_paint.dart';

class CustomPainterAnimatedSwitcher extends StatefulWidget {
  const CustomPainterAnimatedSwitcher({Key key, @required this.isFirst})
      : super(key: key);
  final bool isFirst;
  @override
  _CustomPainterAnimatedSwitcherState createState() =>
      _CustomPainterAnimatedSwitcherState();
}

class _CustomPainterAnimatedSwitcherState
    extends State<CustomPainterAnimatedSwitcher> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: widget.isFirst ? CustomPainterFirst() : CustomPainterSecond(),
      duration: Duration(milliseconds: 500),
    );
  }
}