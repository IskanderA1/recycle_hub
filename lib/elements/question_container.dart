import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/elements/answer_cell.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
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
    int i = 0;
    answerWidgets =
        List<AnswerCell>.from(state.currentQuestion.answersVariants.map((e) {
      String char;
      try {
        char = characters[i];
      } on Exception catch (e) {
        char = '__';
      }
      i++;
      return AnswerCell(
        character: char,
        backColor: e == state.selectedAnswer
            ? kColorGreen
            : e == correctAnswer
                ? kColorGreen
                : e == userAnswer && !isCorrect
                    ? kColorRed
                    : kColorWhite,
        answer: e,
        onTap: () {
          GetIt.I.get<EcoTestBloc>().add(EcoTestEventSelectAnswer(e));
        },
      );
    }));
  }
  final EcoTestStateLoaded state;
  List<AnswerCell> answerWidgets;
  final characters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'Устал\nсчитать'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 10,
        ),
        state.currentQuestion.image != null
            ? CachedNetworkImage(
              placeholder: (BuildContext context, url) => LoaderWidget(),
              imageUrl: state.currentQuestion.image,
              errorWidget: (BuildContext context, url, error) =>
                  Icon(Icons.error),
            )
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
