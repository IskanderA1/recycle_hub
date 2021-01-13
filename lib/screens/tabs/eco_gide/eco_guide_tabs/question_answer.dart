import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';

class QuestionAnswerScreen extends StatefulWidget {
  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Вопросы и ответы"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            ecoMenu.backToMenu();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Text("Q&A screen"),
        ),
      ),
    );
  }
}
