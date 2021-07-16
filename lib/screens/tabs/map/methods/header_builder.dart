import 'package:flutter/material.dart';

class AnimatedHeader extends StatelessWidget {
  const AnimatedHeader({this.bottomSheetOffset});
  final double bottomSheetOffset;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 40, //bottomSheetOffset == 0.3 ? 300 : 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Icon(
          bottomSheetOffset == 0.85 ? Icons.expand_more : Icons.expand_less,
          size: 30,
          color: Colors.black54,
        ));
  }
}

///Отрисовка headerа bottomsheet'a
Widget buildHeader(BuildContext context, double bottomSheetOffset) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      height: 30, //bottomSheetOffset == 0.3 ? 300 : 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(/* bottomSheetOffset == 0.85 ? 0 :  */ 40),
          topRight: Radius.circular(/* bottomSheetOffset == 0.85 ? 0 :  */ 40),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              bottomSheetOffset == 0.85 ? Icons.expand_more : Icons.expand_less,
              size: 30,
              color: Colors.black54,
            ),
          ]));
}

Widget buildHeaderAnimated(BuildContext context, double bottomSheetOffset) {
  return AnimatedContainer(
      //color: kColorWhite,
      duration: const Duration(milliseconds: 100),
      width: double.infinity,
      height: 40, //bottomSheetOffset == 0.3 ? 300 : 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomSheetOffset == 0.85 ? 0 : 40),
          topRight: Radius.circular(bottomSheetOffset == 0.85 ? 0 : 40),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              bottomSheetOffset == 0.85 ? Icons.expand_more : Icons.expand_less,
              size: 40,
              color: Colors.black54,
            ),
          ]));
}
