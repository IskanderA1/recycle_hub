import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

Widget buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 100.0,
        width: 100.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Style.titleColor,
        ),
      )
    ],
  ));
}

Widget buildLoadingScaffold() {
  return Scaffold(
    body: Container(
      color: kColorWhite,
      child: Center(
          child: SizedBox(
        height: 100.0,
        width: 100.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Style.titleColor,
        ),
      )),
    ),
  );
}
