import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';

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

  @override
  void initState() {
    //globalStateBloc.getComeIn();
    //authBloc.auth();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authBloc.subject,
        initialData: UserUnlogged(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<UserResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is UserLoggedIn) {
              globalStateBloc.pickItem(GLobalStates.TABS);
              return buildLoadingScaffold();
            } else if (snapshot.data is UserLoading) {
              return buildLoadingScaffold();
            } else if (snapshot.data is UserAuthFailed) {
              return AuthScreen();
            } else if (snapshot.data is UserUnlogged) {
              return AuthScreen();
            }
            return AuthScreen();
          } else if (snapshot.hasError) {
            return buildLoadingScaffold();
          } else {
            return buildLoadingScaffold();
          }
        });
  }
}
