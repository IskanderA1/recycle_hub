import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Пройти Тест"),
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
          child: Text("Test screen"),
        ),
      ),
    );
  }
}
