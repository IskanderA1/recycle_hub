import 'package:flutter/material.dart';

enum AnswerCellStatesEnum { Selected, Correct, Incorrect, None }

class AnswerCell extends StatelessWidget {
  AnswerCell(
      {@required this.backColor,
      @required this.character,
      @required this.answer,
      this.onTap});
  final Color backColor;
  final String character;
  final String answer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
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
          )),
    );
  }
}
