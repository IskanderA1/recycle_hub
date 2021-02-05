import 'package:flutter/material.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/style/theme.dart';

///Отрисовка headerа bottomsheet'a
Widget buildHeader(
    BuildContext context, double bottomSheetOffset, CustMarker marker) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      height: 60, //bottomSheetOffset == 0.3 ? 300 : 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40 /*bottomSheetOffset == 0.85 ? 0 : 40*/),
          topRight: Radius.circular(40 /*bottomSheetOffset == 0.85 ? 0 : 40*/),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                bottomSheetOffset = 0.85;
              },
              child: Icon(
                bottomSheetOffset == 0.85
                    ? Icons.expand_more
                    : Icons.expand_less,
                size: 50,
                color: Colors.black54,
              ),
            ),
            Divider(
              color: kColorGreyLight,
              thickness: 2,
              height: 1,
            ),
          ]));
}
