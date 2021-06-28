import 'package:flutter/material.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';
import 'package:recycle_hub/style/theme.dart';

class AnswerCell extends StatelessWidget {
  AnswerCell({this.backColor, this.character, this.answer});
  Color backColor;
  final String character;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: backColor,
            border: Border.all(color: Color(0xFFC9C9C9), width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFC9C9C9), width: 2)),
              child: Text(
                character,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(answer),
          ],
        ));
  }
}
