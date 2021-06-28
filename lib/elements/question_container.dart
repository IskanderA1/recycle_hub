import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/elements/answer_cell.dart';
import 'package:recycle_hub/style/theme.dart';

///TODO: create list of answers, show anser results such as design
class QuestionContainer extends StatelessWidget {
  QuestionContainer({this.state}) {
    String correctAnswer = '';
    String userAnswer = '';
    bool isCorrect = false;
    if (state.lastAnswerResult != null) {
      correctAnswer = state.lastAnswerResult.correctAnswer;
      userAnswer = state.lastAnswerResult.yourAnswer;
      isCorrect = state.lastAnswerResult.answerStatus;
    }
    answerWidgets = List<Widget>.from(
        state.currentQuestion.answersVariants.map((e) => AnswerCell(
            backColor: e == correctAnswer
                ? kColorGreen
                : e == userAnswer && !isCorrect
                    ? kColorRed
                    : kColorWhite)));
  }
  final EcoTestStateLoaded state;
  List<AnswerCell> answerWidgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 10,
        ),
        state.currentQuestion.image != null
            ? NetworkImage(state.currentQuestion.image)
            : SvgPicture.asset("svg/test_illustration.svg"),
        SizedBox(
          height: 10,
        ),
        Text(
          state.currentQuestion.question,
          style: TextStyle(
              color: kColorBlack, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: answerWidgets,
            ))
      ],
    );
  }
}
