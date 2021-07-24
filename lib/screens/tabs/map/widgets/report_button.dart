import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/reoport_to_error_marker.dart';
import 'package:recycle_hub/style/theme.dart';

class ReportButtonWidget extends StatelessWidget {
  final String markerId;

  const ReportButtonWidget(
    this.markerId, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) {
              return ReportToErrorMarkerScreen(markerId);
            },
          ),
        );
      },
      child: Text(
        'Сообщить об ошибке',
        style: TextStyle(
          color: kColorRed,
        ),
      ),
    );
  }
}
