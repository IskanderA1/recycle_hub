import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:recycle_hub/helpers/static_data.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'dart:developer' as developer;

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
    developer.log("AuthEvent: ${event.runtimeType}",
        name: 'bloc.auth_bloc.bloc');
    if (event is AuthEventInit) {
      yield* _mapInitToState();
    } else if (event is AuthEventSwitchFirstIn) {
      yield* _mapSwitchFirstToState();
    } else if (event is AuthEventLogin) {
      yield* _mapLoginToState(event);
    } else if (event is AuthEventRegister) {
      yield* _mapRegisterToState(event);
    } else if (event is AuthEventLogout) {
      yield* _mapLogoutToState();
    } else if (event is AuthEventRecoverySendCode) {
      yield* _mapRecoveryCodeSendToState(event);
    } else if (event is AuthEventRecoveryCheckCode) {
      yield* _mapRecoveryCodeCheckToState(event);
    } else if (event is AuthEventRecoveryChangePass) {
      yield* _mapRecoveryChangePassToState(event);
    } else if (event is AuthEventConfirm) {
      yield* _mapRegConfirmToState(event.code);
    } else if (event is AuthEventHasCode) {
      yield* _mapAlreadyHasCodeToState(event);
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
        UserModel user = await userService.userInfo();
        if (user != null) {
          StaticData.user.value = user;
          if (userService.isAdmin) {
            yield AuthStateLogedIn(user: user, isAdmin: true);
          } else {
            yield AuthStateLogedIn(user: user);
          }

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
    } else {
      SessionManager().clearSession();
      yield AuthStateLogOuted();
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
          if (userService.isAdmin) {
            yield AuthStateLogedIn(user: user, isAdmin: true);
          } else {
            yield AuthStateLogedIn(user: user);
          }
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
      SessionManager().clearSession();
      StaticData.user = null;
      yield AuthStateLogOuted();
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
    yield AuthStateLoading();
    try {
      final response =
          await userService.regUser(name, surname, username, pass, code);
      if (response != null) {
        SessionManager().saveLogin(event.username);
        /*SessionManager().savePassword(event.pass);
        SessionManager().relogin();
        final user = await userService.userInfo(); */
        yield AuthStateNeedConfirm();
      }
    } catch (e) {
      yield AuthStateLogOuted();
    }
  }

  Stream<AuthState> _mapRegConfirmToState(String code) async* {
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
      yield AuthStateFail(error: 'Неверный код');
      //yield AuthStateLogOuted();
    }
  }

  Stream<AuthState> _mapSwitchFirstToState() async* {
    Settings().isFirstLaunch = false;
    yield AuthStateLogOuted();
  }

  Stream<AuthState> _mapRecoveryCodeSendToState(
      AuthEventRecoverySendCode event) async* {
    try {
      await UserService().sendCode(username: event.username);
      yield AuthStateRecovery(wasSend: true);
    } catch (e) {
      yield AuthStateFail(error: "Пользователь не найден");
    }
  }

  Stream<AuthState> _mapRecoveryCodeCheckToState(
      AuthEventRecoveryCheckCode event) async* {
    final String username = await SessionManager().getLogin();
    //TODO: check whether state is AuthStateRecovery
    if (username == null || username.isEmpty) {
      yield AuthStateFail(error: "Пользователь не найден");
      return;
    }
    try {
      final isValid =
          await UserService().chechCode(username: username, code: event.code);
      if (isValid) {
        yield AuthStateRecovery(
          wasSend: true,
          isCodeValid: true,
        );
      }
    } catch (e) {
      String errorText;
      if (e is RequestError) {
        if (e.code == RequestErrorCode.recoverCodeInvalid) {
          errorText = 'Неверный код';
        } else {
          errorText = 'Ошибка соединения';
        }
      } else {
        errorText = 'Упс, что-то пошло не так...';
      }
      yield AuthStateFail(error: errorText);
    }
  }

  Stream<AuthState> _mapRecoveryChangePassToState(
      AuthEventRecoveryChangePass event) async* {
    final String username = await SessionManager().getLogin();
    //TODO: check whether state is AuthStateRecovery
    if (username == null || username.isEmpty) {
      yield AuthStateFail(error: "Пользователь не найден");
      return;
    }
    await UserService().changePassword(password: event.password);
    final String password = await SessionManager().getPassword();
    if (password == null || password.isEmpty) {
      yield AuthStateFail(
          error: 'Ошибка при попытке изменить пароль. Повторите попытку');
      return;
    }
    SessionManager().relogin();
    String token = await SessionManager().getAuthorizationToken();
    if (token == null) {
      yield AuthStateFail(
          error: 'Ошибка при попытке изменить пароль. Повторите попытку');
      return;
    }
    if (token != null) {
      try {
        UserModel user = await userService.userInfo();
        if (user != null) {
          StaticData.user.value = user;
          if (userService.isAdmin) {
            yield AuthStateLogedIn(user: user, isAdmin: true);
          } else {
            yield AuthStateLogedIn(user: user);
          }

          Settings().isFirstLaunch = false;
        } else {
          yield AuthStateLogOuted();
        }
      } catch (e) {
        yield AuthStateFail(error: e.toString());
        return;
      }
    }
  }

  Stream<AuthState> _mapAlreadyHasCodeToState(AuthEventHasCode event) async* {
    if (event.username == null || event.username.isEmpty) {
      yield AuthStateFail(error: 'Введите логин');
    }
    try {
      await SessionManager().saveLogin(event.username);
      yield AuthStateNeedConfirm();
    } catch (e) {
      yield AuthStateFail(error: 'Упс, что-то пошло не так');
    }
  }
}
