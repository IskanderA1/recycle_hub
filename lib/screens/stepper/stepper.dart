import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/model/global_state_models.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/stepper/page3.dart';
import 'package:recycle_hub/screens/stepper/page4.dart';
import 'package:recycle_hub/screens/stepper/page_1.dart';
import 'package:recycle_hub/screens/stepper/page_2.dart';
import 'package:recycle_hub/style/theme.dart';
import 'first_custom_paint.dart';
import 'indicators.dart';
import 'second_custom_paint.dart';

class WellcomePageStepper extends StatefulWidget {
  @override
  _WellcomePageStepperState createState() => _WellcomePageStepperState();
}

class _WellcomePageStepperState extends State<WellcomePageStepper> {
  int activeStepInd = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Align(
        alignment: Alignment.topCenter,
        child: CustomPainterAnimatedSwitcher(isFirst: activeStepInd % 2 == 0),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30, left: 30),
          child: IndicatorAnimatedSwitcher(
            selected: activeStepInd,
          ),
        ),
      ),
      PageView(
        controller: _pageController,
        children: [
          Page1(),
          Page2(),
          Page3(),
          Page4(),
        ],
        onPageChanged: (ind) {
          setState(() {
            activeStepInd = ind;
          });
        },
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.only(bottom: 30, right: 30),
            child: TextButton(
              child: Text(
                activeStepInd != 3 ? "Skip" : "Start",
                style: TextStyle(
                    fontSize: 16,
                    color: activeStepInd % 2 == 0 ? kColorGreen : kColorWhite,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                if (activeStepInd != 3) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthScreen()));*/
                  globalStateBloc.pickItem(GLobalStates.AUTH);
                }
              },
            )),
      ),
    ]));
  }
}

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
      /*transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          child: child,
          scale: animation,
        );
      },*/
      child: widget.isFirst ? CustomPainterFirst() : CustomPainterSecond(),
      duration: Duration(milliseconds: 500),
    );
  }
}
