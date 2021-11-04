import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class AlertHelper {
  static bool isShowing = false;
  static void showMessage({BuildContext context, String message, Color backColor = kColorRed}) {
    if(isShowing){
      return;
    }
    isShowing = true;
    var snackBar = SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(kBorderRadius),
      )),
      backgroundColor: backColor,
      elevation: 3.0,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Gillroy',
          color: kColorWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Future.delayed(Duration(milliseconds: 1500), () {
      isShowing = false;
    });
  }
   static void showSuccesMessage({BuildContext context, String message, Color backColor = kColorGreen}) {
    if(isShowing){
      return;
    }
    isShowing = true;
    var snackBar = SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(kBorderRadius),
      )),
      backgroundColor: backColor,
      elevation: 3.0,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Gillroy',
          color: kColorWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Future.delayed(Duration(milliseconds: 1500), () {
      isShowing = false;
    });
  }

  static showInfoAlert(BuildContext context, String title, String message, {Function onClick, String okButtonTitle = "OK"}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
                if (onClick != null) {
                  onClick();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static showErrorAlert(
    BuildContext context,
    String title,
    String message, {
    Function onClick,
    String okButtonTitle = "OK",
    Function onDenial,
    String denialButtonTitle,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            if (denialButtonTitle != null)
              FlatButton(
                child: Text(denialButtonTitle),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onDenial != null) {
                    onDenial();
                  }
                },
              ),
            FlatButton(
              child: Text(okButtonTitle,
                  style: TextStyle(
                    color: Colors.blue,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                if (onClick != null) {
                  onClick();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
