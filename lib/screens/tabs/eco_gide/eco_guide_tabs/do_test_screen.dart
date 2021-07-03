import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/elements/question_container.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/model/profile_models/eco_test_answer_model.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  EcoTestAnswerModel selectedAnswer =
      EcoTestAnswerModel(answer: '', questionId: '');
  EcoTestEvent event = EcoTestStartTestEvent();
  String btnText = 'Начать';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Пройти Тест"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            GetIt.I.get<EcoGuideCubit>().goBack();
          },
        ),
      ),
      body: BlocConsumer<EcoTestBloc, EcoTestState>(
        bloc: GetIt.I.get<EcoTestBloc>(),
        listener: (context, state) {
          if (state is EcoTestStateError) {
            showMessage(context: context, message: state.toString());
          }

          if (state is EcoTestStateCompleted ||
              state is EcoTestStateInitial ||
              state is EcoTestStateError) {
            event = EcoTestStartTestEvent();
            btnText = 'Начать';
          } else if (state is EcoTestStateLoaded) {
            if (state.lastAnswerResult != null) {
              if (state.lastAnswerResult.isAttemptSuccess != null) {
                event = EcoTestStartTestEvent();
                btnText = 'Начать';
              } else {
                event = EcoTestEventNextQuestion();
                btnText = 'Продолжить';
              }
            } else {
              event = EcoTestAnswerToQuestionEvent(selectedAnswer);
              btnText = 'Продолжить';
            }
          } else {
            event = EcoTestStartTestEvent();
            btnText = 'Продолжить';
          }
        },
        builder: (context, state) {
          if (state is EcoTestStateLoaded) {
            return Column(children: [
              QuestionContainer(
                state: state,
              ),
              EcoTestContinueButton(
                btnText: btnText,
                onTap: () {
                  GetIt.I.get<EcoTestBloc>().add(event);
                },
              ),
            ]);
          }
          if (state is EcoTestStateInitial || state is EcoTestStateError) {
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
            borderRadius: BorderRadius.circular(15),
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
