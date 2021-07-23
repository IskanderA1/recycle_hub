import 'package:flutter/material.dart';

class AlertHelper {
  static showErrorAlert(
    BuildContext context,
    String title,
    Widget content, {
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
          title: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              : null,
          content: content,
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

  static showInfoAlert(BuildContext context, String title, String message,
      {Function onClick, String okButtonTitle = "OK"}) {
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
}
