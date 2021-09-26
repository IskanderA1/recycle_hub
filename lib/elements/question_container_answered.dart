import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/elements/answer_cell.dart';
import 'package:recycle_hub/model/profile_models/eco_test_attempt_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_question_model.dart';
import 'package:recycle_hub/model/profile_models/eco_test_result_model.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';

class QuestionContainerAnswered extends StatelessWidget {
  QuestionContainerAnswered({this.question, this.result}) {
    int i = 0;
    answerWidgets = List<AnswerCell>.from(question.answersVariants.map((e) {
      String char;
      try {
        char = characters[i];
      } on Exception catch (e) {
        char = '__';
      }
      i++;

      Color backColor = kColorWhite;
      if (e == result.yourAnswer && result.answerStatus) {
        backColor = kColorGreen;
      } else if (e == result.yourAnswer && !result.answerStatus) {
        backColor = kColorRed;
      } else if (e == result.correctAnswer) {
        backColor = kColorGreen;
      }
      return AnswerCell(
        character: char,
        backColor: backColor,
        answer: e,
        onTap: () {
          //GetIt.I.get<EcoTestBloc>().add(EcoTestEventSelectAnswer(e));
        },
      );
    }));
  }

  final AnswerResult result;
  final Question question;

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
        question.image != null
            ? CachedNetworkImage(
                placeholder: (BuildContext context, url) => LoaderWidget(),
                imageUrl: question.image,
                errorWidget: (BuildContext context, url, error) =>
                    Icon(Icons.error),
              )
            : SvgPicture.asset("svg/test_illustration.svg"),
        SizedBox(
          height: 10,
        ),
        Text(
          question.question,
          style: TextStyle(
              color: kColorBlack, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: answerWidgets,
            )),
        if (result.answerStatus)
          Text(
            'Ответ верный',
            style: TextStyle(color: kColorGreen, fontSize: 16),
          ),
        if (!result.answerStatus)
          Text(
            'Ответ неверный, ' + result.description,
            style: TextStyle(color: kColorRed, fontSize: 16),
          )
      ],
    );
  }
}
