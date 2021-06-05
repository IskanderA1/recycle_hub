import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:recycle_hub/helpers/static_data.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService userService = UserService();
  SessionManager sessionManager = SessionManager();
  AuthBloc() : super(AuthStateLoading());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthEventInit) {
      yield* _mapInitToState();
    } else if (event is AuthEventSwitchFirstIn) {
      yield* _mapSwitchFirstToState();
    } else if (event is AuthEventLogin) {
      yield* _mapLoginToState(event);
    } else if (event is AuthEventRegister) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<AuthState> _mapInitToState() async* {
    bool isfirst = await Settings().getIsFirstLaunch();
    if (isfirst == null || isfirst == true) {
      yield AuthStateFirstIn();
      return;
    }
    String token = await SessionManager().getAuthorizationToken();
    if (token == null) {
      await SessionManager().relogin();
      token = await SessionManager().getAuthorizationToken();
    }
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

  Stream<AuthState> _mapLoginToState(AuthEventLogin event) async* {
    yield AuthStateLoading();

    try {
      final response = await userService.login(event.login, event.password);
      if (response.statusCode == 200) {
        final user = await userService.userInfo();
        if (user != null) {
          Settings().isFirstLaunch = false;
          yield AuthStateLogedIn(user: user);
        } else {
          yield AuthStateLogOuted();
        }
      } else {
        yield AuthStateLogOuted();
      }
    } catch (e) {
      yield AuthStateLogOuted();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      await userService.userLogOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AuthState> _mapRegisterToState(AuthEventRegister event) async* {
    String name = event.name;
    String surname = event.surname;
    String username = event.username;
    String pass = event.pass;
    String code = event.code;
    try {
      final response =
          await userService.regUser(name, surname, username, pass, code);
      if (response is UserRegOk) {
        yield AuthStateNeedConfirm();
      } else {
        yield AuthStateFail(error: "Ошибка регистрации");
      }
    } catch (e) {
      yield AuthStateLogOuted();
    }
  }

  Stream<AuthState> confirmCode(String code) async* {
    final bool res = await userService.confirmCode(code);
    if (res) {
      String login = await sessionManager.getLogin();
      String pass = await sessionManager.getPassword();
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
    } else {
      yield AuthStateLogOuted();
    }
  }

  Stream<AuthState> _mapSwitchFirstToState() async* {
    Settings().isFirstLaunch = false;
    yield AuthStateLogOuted();
  }
}
