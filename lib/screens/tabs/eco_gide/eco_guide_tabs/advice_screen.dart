import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Советы для экономики"),
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
          child: Text("Advice screen"),
        ),
      ),
    );
  }
}
