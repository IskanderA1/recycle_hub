import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/helpers/alert_helper.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/stepper/page3.dart';
import 'package:recycle_hub/screens/stepper/page4.dart';
import 'package:recycle_hub/screens/stepper/page_1.dart';
import 'package:recycle_hub/screens/stepper/page_2.dart';
import 'package:recycle_hub/screens/workspace_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'indicators.dart';
import 'image_painter.dart';
import 'package:image/image.dart' as image;
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class WellcomePageStepper extends StatefulWidget {
  @override
  _WellcomePageStepperState createState() => _WellcomePageStepperState();
}

class _WellcomePageStepperState extends State<WellcomePageStepper> {
  int activeStepInd = 0;
  bool isConfirmed = false;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  Size _size;
  ui.Image uimage;
  SequenceAnimation sequenceAnimation;
  GlobalKey<AnimatedBackGroundState> key = GlobalKey<AnimatedBackGroundState>();
  List<Widget> pages;

  @override
  void initState() {
    pages = [
      Page1(),
      Page2(),
      Page3(),
      Page4(
        val: isConfirmed,
        onChaned: (bool value) {
          setState(() {
            isConfirmed = value;
          });
        },
      ),
    ];
    getImage().then((value) {
      setState(() {
        uimage = value;
      });
    });
    super.initState();
  }

  Future<ui.Image> getImage() async {
    final ByteData assetImageByteData =
        await rootBundle.load('assets/onboarding/back.png');
    image.Image baseSizeImage = image.decodeImage(
      assetImageByteData.buffer.asUint8List(),
    );
    ui.Codec codec = await ui.instantiateImageCodec(
      image.encodePng(baseSizeImage),
    );
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Stack(children: [
        AnimatedBackGround(key: key, uimage: uimage, size: _size),
        PageView(
          controller: _pageController,
          clipBehavior: Clip.antiAlias,
          children: pages,
          onPageChanged: (ind) {
            if (activeStepInd < ind) {
              switch (activeStepInd) {
                case 0:
                  key.currentState.animateTo(-0.3333);
                  //key.currentState.startAnim();
                  break;
                case 1:
                  key.currentState.animateTo(0.3333);
                  //key.currentState.startAnim();
                  break;
                case 2:
                  key.currentState.animateTo(1);
                  //key.currentState.startAnim();
                  break;
              }
            } else if (activeStepInd > ind) {
              key.currentState.reverseAnim();

              switch (activeStepInd) {
                case 0:
                  break;
                case 1:
                  key.currentState.animateTo(-1);
                  break;
                case 2:
                  key.currentState.animateTo(-0.3333);
                  break;
                case 3:
                  key.currentState.animateTo(0.3333);
                  break;
              }
            }
            setState(() {
              activeStepInd = ind;
            });
          },
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
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(bottom: 30, right: 30),
            child: TextButton(
              child: Text(
                activeStepInd != 3 ? "Продолжить" : "Принять",
                style: TextStyle(
                    fontSize: 16,
                    color: kColorBlack,
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
                      MaterialPageRoute(builder: (context) => AuthScreen(),),);*/
                  /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkSpaceScreen(),),); */

                  GetIt.I.get<AuthBloc>().add(
                        AuthEventSwitchFirstIn(),
                      );
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class AnimatedBackGround extends StatefulWidget {
  const AnimatedBackGround({
    Key key,
    @required this.uimage,
    @required this.size,
  }) : super(key: key);

  final ui.Image uimage;
  final Size size;

  @override
  AnimatedBackGroundState createState() => AnimatedBackGroundState();
}

class AnimatedBackGroundState extends State<AnimatedBackGround>
    with TickerProviderStateMixin {
  AnimationController _controller;
  double offsetDx = -1;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
        lowerBound: -1,
        upperBound: 1);
    _controller.addListener(update);
  }

  void update() {
    print("newval ${_controller.value}");
    setState(() {
      offsetDx = _controller.value;
    });
  }

  void startAnim() {
    _controller.forward(from: -1).orCancel;
  }

  void reverseAnim() {
    _controller.reverse().orCancel;
  }

  void animateTo(double to) {
    //_controller.drive(Tween(begin: 150.0, end: 300.0),);
    //_controller.fling()
    _controller.animateTo(
      to,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: SvgPicture.asset(
        "assets/svg/background.svg",
        allowDrawingOutsideViewBox: true,
        clipBehavior: Clip.none,
        fit: BoxFit.fitHeight,
        alignment: AlignmentDirectional(offsetDx, 0),
      ),
    );
  }
}
