import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/elements/question_container.dart';
import 'package:recycle_hub/elements/question_container_answered.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

class TestScreen extends StatefulWidget {
  final Function onBackPressed;

  TestScreen({@required this.onBackPressed});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  EcoTestEvent event = EcoTestStartTestEvent();
  String btnText = 'Начать';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Пройти Тест"),
        centerTitle: true,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
          ),
          onTap: () {
            if (widget.onBackPressed != null) {
              widget.onBackPressed();
            }
          },
        ),
      ),
      body: BlocConsumer<EcoTestBloc, EcoTestState>(
        bloc: GetIt.I.get<EcoTestBloc>(),
        listener: (context, state) {
          if (state is EcoTestStateError) {
            showMessage(context: context, message: state.toString());
          }

          if (state is EcoTestStateInitial || state is EcoTestStateError) {
            event = EcoTestStartTestEvent();
            btnText = 'Начать';
          }
          /*  else if (state is EcoTestStateLoaded) {
            if (state.lastAnswerResult != null) {
              if (state.lastAnswerResult.isAttemptSuccess != null) {
                event = EcoTestStartTestEvent();
                btnText = 'Начать';
              } else {
                event = EcoTestEventNextQuestion();
                btnText = 'Продолжить';
              }
            } else {
              event = EcoTestAnswerToQuestionEvent();
              btnText = 'Продолжить';
            }
          } else {
            event = EcoTestStartTestEvent();
            btnText = 'Продолжить';
          } */
        },
        builder: (context, state) {
          if (state is EcoTestStateLoaded) {
            return Column(children: [
              QuestionContainer(
                state: state,
              ),
              EcoTestContinueButton(
                btnText: 'Ответить',
                onTap: () {
                  GetIt.I.get<EcoTestBloc>().add(EcoTestAnswerToQuestionEvent());
                },
              ),
            ]);
          } else if (state is EcoTestStateAnswered) {
            return Column(children: [
              QuestionContainerAnswered(
                question: state.currentQuestion,
                result: state.lastAnswerResult,
              ),
              EcoTestContinueButton(
                btnText: 'Продолжить',
                onTap: () {
                  GetIt.I.get<EcoTestBloc>().add(EcoTestEventNextQuestion());
                },
              ),
            ]);
          } else if (state is EcoTestStateInitial) {
            return Center(
              child: EcoTestContinueButton(
                btnText: 'Начать',
                onTap: () {
                  GetIt.I.get<EcoTestBloc>().add(EcoTestStartTestEvent());
                },
              ),
            );
          } else if (state is EcoTestStateError) {
            return Center(
              child: EcoTestContinueButton(
                btnText: 'Выйти',
                onTap: () {
                  GetIt.I.get<EcoGuideCubit>().goBack();
                  GetIt.I.get<EcoTestBloc>().add(EcoTestEventReset());
                },
              ),
            );
          } else if (state is EcoTestStateCompleted) {
            String resultStr;
            if (state.result.isAttemptSuccess != null && state.result.isAttemptSuccess) {
              resultStr = 'Ура, вы прошли тест!';
            } else {
              resultStr = 'Повторите попытку позже, вы получили ${state.gotPoints} из ${state.currentAttempt.points}';
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(resultStr),
                ),
                EcoTestContinueButton(
                  btnText: 'Выйти',
                  onTap: () {
                    GetIt.I.get<EcoGuideCubit>().goBack();
                    GetIt.I.get<EcoTestBloc>().add(EcoTestEventReset());
                  },
                )
              ],
            );
          }
          if (state is EcoTestStateInitial) {
            return Center(
              child: EcoTestContinueButton(
                btnText: btnText,
                onTap: () {
                  GetIt.I.get<EcoTestBloc>().add(event);
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class EcoTestContinueButton extends StatelessWidget {
  EcoTestContinueButton({this.btnText, @required this.onTap});

  final Function onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
            color: Color(0xFF249507),
          ),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Text(
              btnText,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
