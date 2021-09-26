import 'package:flutter/material.dart';
import 'package:recycle_hub/elements/ball.dart';
import 'package:recycle_hub/elements/common_button.dart';
import 'package:recycle_hub/style/theme.dart';

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

  static showWelcomeInfo(BuildContext context, {String okButtonTitle = "OK"}) {
    const partner =
        "Зеленые пункты приема дают возможность начисления ЭкоКоинов";
    const notPartner = "Оранжевые не являются партнерами";
    const title = "Информация о пунктеприёма";
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: title != null ? Text(title) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          content: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BallGreen(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            partner,
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BallGreen(
                        color: kColorPink,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            notPartner,
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CommonButton(
                    height: 50,
                    ontap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ок",
                          style: TextStyle(
                              color: kColorWhite,
                              fontFamily: 'GilroyMedium',
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            /* TextButton(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), */
          ],
        );
      },
    );
  }

  static showBalanceInfo(BuildContext context, {String okButtonTitle = "OK"}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: title != null ? Text(title) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          content: Container(
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Column(
              children: [
                Text(
                  "Информация о балансе",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius),)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          BallGreen(),
                          SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            child: Text(
                              'Зеленым цветом выделена информация о балансе разблокированных экокоинов.',
                              overflow: TextOverflow.visible,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            BallGreen(
                              color: kColorRed,
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: Text(
                                'Красным цветом выделена информация о балансе заблокированных экокоинов.',
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CommonButton(
                    height: 50,
                    ontap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ок",
                          style: TextStyle(
                              color: kColorWhite,
                              fontFamily: 'GilroyMedium',
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            /* TextButton(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), */
          ],
        );
      },
    );
  }
}
