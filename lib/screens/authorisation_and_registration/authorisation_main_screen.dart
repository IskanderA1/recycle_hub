import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'auth_screen.dart';

class AuthorisationMainScreen extends StatefulWidget {
  @override
  _AuthorisationMainScreenState createState() =>
      _AuthorisationMainScreenState();
}

class _AuthorisationMainScreenState extends State<AuthorisationMainScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        builder: (context, state) {
          if (state is AuthStateLogedIn) {
            return buildLoadingScaffold();
          } else if (state is AuthStateLoading) {
            return buildLoadingScaffold();
          } /*  else if (state is AuthStateFail) {
            return AuthScreen();
          } */
          /* else if(state is AuthStateNeedConfirm){
            return ConfirmCodeScreen();
          } */
          else if (state is AuthStateGuestAcc) {
            return AuthScreen();
          }
          /*else if (state is AuthStateFirstIn){
            return WellcomePageStepper();
          }*/
          return AuthScreen();
        });
  }
}
