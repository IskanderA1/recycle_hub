import 'package:flutter/material.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/screens/tabs/map/methods/icon_data_method.dart';
import 'package:recycle_hub/style/theme.dart';

class DialogContainer extends StatelessWidget {
  DialogContainer({Key key, this.acceptType}) : super(key: key);

  final FilterType acceptType;

  String _keyWords = "";
  String _badWords = "";

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < acceptType.keyWords.length; i++) {
      _keyWords = _keyWords + "\n -" + acceptType.keyWords[i];
    }

    for (int i = 0; i < acceptType.badWords.length; i++) {
      _badWords = _badWords + "\n -" + acceptType.badWords[i];
    }
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.fromLTRB(25, 10, 15, 10),
      contentTextStyle: TextStyle(color: kColorBlack, fontSize: 16),
      title: Container(
        height: 100,
        color: kColorGreen,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getIconData(acceptType.varName),
              size: 40,
              color: kColorWhite,
            ),
            Text(
              acceptType.name,
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        )),
      ),
      content: Container(
        height: 300,
        //constraints: BoxConstraints(minHeight: 300, minWidth: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text("Подлежат: $_keyWords"),
            ),
            Expanded(
              child: Text("Не подлежат: $_badWords"),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                      color: kColorGreen,
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  child: Center(
                    child: Text(
                      "Понятно",
                      style: TextStyle(fontSize: 22, color: kColorWhite),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
