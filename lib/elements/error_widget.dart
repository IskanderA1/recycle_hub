import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({this.error});
  final Error error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kColorWhite,
        child: Center(child: Text(error.toString() ?? "Ошибка")),
      ),
    );
  }
}
