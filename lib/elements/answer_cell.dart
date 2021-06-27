import 'package:flutter/material.dart';

class AnswerCell extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
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
                "A",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text("совокупность живого вещества"),
          ],
        ));
  }
}
