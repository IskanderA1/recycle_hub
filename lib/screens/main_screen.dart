import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/screens/stepper/stepper.dart';
import 'package:recycle_hub/screens/workspace_screen.dart';

import 'authorisation_and_registration/authorisation_main_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();
  AuthBloc authBloc;
  StreamSubscription<AuthState> _authSub;

  @override
  void initState() {
    authBloc = AuthBloc();
    _authSub = authBloc.stream.listen((state) {
      if (state is AuthStateLogOuted) {
        globalStateBloc.pickItem(GLobalStates.AUTH);
      } else if (state is AuthStateLogedIn) {
        bottomNavBarBloc.pickItem(0);
        globalStateBloc.pickItem(GLobalStates.TABS);
      } else if (state is AuthStateFirstIn) {
        globalStateBloc.pickItem(GLobalStates.FIRSTIN);
      } else {
        globalStateBloc.pickItem(GLobalStates.AUTH);
      }
      if (state is AuthStateFail) {
        showMessage(context: context, message: state.error);
      }
    });
    authBloc.add(AuthEventInit());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: StreamBuilder(
          stream: globalStateBloc.subject,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<GLobalStates> snapshot) {
            if (snapshot.hasData) {
              /*if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                if (snapshot.data.error == "Loading") {
                  return buildLoadingWidget();
                }
                if (snapshot.data.error == "Авторизуйтесь") {
                  //TODO: Заменить на AuthScreen после того как сделаем
                  return WorkSpaceScreen();
                }
                //TODO: Заменить на AuthScreen после того как сделаем
                return WorkSpaceScreen();
              }*/
              if (snapshot.data == GLobalStates.FIRSTIN) {
                return WellcomePageStepper();
              } else if (snapshot.data == GLobalStates.AUTH) {
                return AuthorisationMainScreen();
              } else if (snapshot.data == GLobalStates.TABS) {
                return WorkSpaceScreen();
              }
            } else if (snapshot.hasError) {
              return buildLoadingWidget();
            } else {
              return buildLoadingWidget();
            }
          }),
    );
  }
}
