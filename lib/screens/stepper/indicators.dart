import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class IndicatorAnimatedSwitcher extends StatefulWidget {
  IndicatorAnimatedSwitcher({@required this.selected});
  final int selected;
  @override
  _IndicatorAnimatedSwitcherState createState() =>
      _IndicatorAnimatedSwitcherState();
}

class _IndicatorAnimatedSwitcherState extends State<IndicatorAnimatedSwitcher> {
  @override
  Widget build(BuildContext context) {
    Color selected = widget.selected == 0 || widget.selected == 2
        ? kColorGreyDark
        : kColorWhite;
    Color unselected = widget.selected == 0 || widget.selected == 2
        ? kColorGreyLight
        : kColorWhite.withOpacity(0.5);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Container(
        height: 60,
        width: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.selected == 0 ? 40 : 20,
              width: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.selected == 0 ? selected : unselected),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: widget.selected == 1 ? 40 : 20,
              width: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.selected == 1 ? selected : unselected),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: widget.selected == 2 ? 40 : 20,
              width: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.selected == 2 ? selected : unselected),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: widget.selected == 3 ? 40 : 20,
              width: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.selected == 3 ? selected : unselected),
            )
          ],
        ),
      ),
    );
  }
}
