import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({@required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kColorWhite,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      child: Text(message ?? "Ошибка",
                      textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
