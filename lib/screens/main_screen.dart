import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/screens/stepper/stepper.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
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
    authBloc = GetIt.I.get<AuthBloc>();
    _authSub = authBloc.stream.listen((state) {
      /* if (state is AuthStateGuestAcc) {
        globalStateBloc.pickItem(GLobalStates.AUTH);
      }  else*/
      /* if (state is AuthStateLogedIn || state is AuthStateGuestAcc) {
        GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.MAP);
        globalStateBloc.pickItem(GLobalStates.TABS);
      } else if (state is AuthStateFirstIn) {
        globalStateBloc.pickItem(GLobalStates.FIRSTIN);
      } else if (state is AuthStateLoggedOut) {
        globalStateBloc.pickItem(GLobalStates.TABS);
      } else {
        globalStateBloc.pickItem(GLobalStates.AUTH);
      }
      if (state is AuthStateFail) {
        showMessage(context: context, message: state.error);
      } */
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
    return BlocBuilder(
        bloc: authBloc,
        buildWhen: (previous, current) {
          if (current is AuthStateLoading) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is AuthStateFirstIn) {
            return WellcomePageStepper();
          } else if (state is AuthStateLoading) {
            return LoaderWidget();
          }
          bool needToShowInfo = false;
          if (state is AuthStateGuestAcc) {
            needToShowInfo = state.needToShowInfo;
          }
          return WorkSpaceScreen(
            needToShowInfoAlert: needToShowInfo,
          );
        });
  }
}
