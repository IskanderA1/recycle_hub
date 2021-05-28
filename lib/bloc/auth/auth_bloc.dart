import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:recycle_hub/helpers/static_data.dart';
import 'package:recycle_hub/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLoading());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthEventInit) {
      yield* _mapInitToState();
    } else if (event is AuthEventSwitchFirstIn) {
      yield* _mapSwitchFirstToState();
    }
  }

  Stream<AuthState> _mapInitToState() async* {
    bool isfirst = await Settings().getIsFirstLaunch();
    if (isfirst) {
      yield AuthStateFirstIn();
      return;
    }
    String token = await SessionManager().getAuthorizationToken();
    if (token != null) {
      try {
        UserModel user = await UserService().userInfo();
        if (user != null) {
          StaticData.user.value = user;
          yield AuthStateLogedIn(user: user);
          Settings().isFirstLaunch = false;
        } else {
          yield AuthStateLogOuted();
        }
      } catch (e) {
        String login = await SessionManager().getLogin();
        String pass = await SessionManager().getPassword();
        if (login != null && pass != null) {
          await SessionManager().relogin();
          try {
            UserModel user = await UserService().userInfo();
            if (user != null) {
              StaticData.user.value = user;
              yield AuthStateLogedIn(user: user);
              Settings().isFirstLaunch = false;
            } else {
              yield AuthStateLogOuted();
            }
          } catch (e) {
            SessionManager().clearSession();
          }
        }
      }
    }
  }

  Stream<AuthState> _mapSwitchFirstToState() async* {
    Settings().isFirstLaunch = false;
    yield AuthStateLogOuted();
  }
}
