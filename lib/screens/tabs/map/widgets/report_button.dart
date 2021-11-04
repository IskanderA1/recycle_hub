import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
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
        if (GetIt.I.get<AuthBloc>().state is AuthStateLogedIn) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) {
                return ReportToErrorMarkerScreen(markerId);
              },
            ),
          );
        }else{
          Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) {
              return AuthScreen();
            },
          ),
        );
        }
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
