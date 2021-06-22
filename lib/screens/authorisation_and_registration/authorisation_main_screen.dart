import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/reg_confirm_code_screen.dart';
import 'package:recycle_hub/screens/stepper/stepper.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';

import 'auth_screen.dart';
import 'registration_screen.dart';

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
          else if (state is AuthStateLogOuted) {
            return AuthScreen();
          }
          /*else if (state is AuthStateFirstIn){
            return WellcomePageStepper();
          }*/
          return AuthScreen();
        });
  }
}
