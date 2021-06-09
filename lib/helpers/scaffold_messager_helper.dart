import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

void showMessage({BuildContext context, String message}) {
  var snackBar = SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
    backgroundColor: kColorGreen,
    elevation: 3.0,
    margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
    behavior: SnackBarBehavior.floating,
    content: Text(
        message,
        textAlign: TextAlign.center,
        style:
      TextStyle(fontSize: 14, fontFamily: 'Gillroy', color: kColorWhite, fontWeight: FontWeight.w500),
      ),
    duration: Duration(milliseconds: 2500),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
