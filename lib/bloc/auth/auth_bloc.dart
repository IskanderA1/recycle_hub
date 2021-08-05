import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/news_service.dart';
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
  AuthBloc() : super(AuthStateGuestAcc());

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
    } else if (event is AuthEventLogout) {
      yield* _mapLogoutToState();
    } else if (event is AuthEventRefresh) {
      yield* _mapRefreshToState();
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
          //StaticData.user.value = user;
          NewsService().loadNews();
          yield AuthStateLogedIn(user: user);

          Settings().isFirstLaunch = false;
        } else {
          yield AuthStateGuestAcc();
        }
      } catch (e) {
        String login = await SessionManager().getLogin();
        String pass = await SessionManager().getPassword();
        if (login != null && pass != null) {
          await SessionManager().relogin();
          try {
            UserModel user = await UserService().userInfo();
            if (user != null) {
              //StaticData.user.value = user;
              //NewsService().loadNews();
              yield AuthStateLogedIn(user: user);
              Settings().isFirstLaunch = false;
            } else {
              yield AuthStateGuestAcc();
            }
          } catch (e) {
            SessionManager().clearSession();
          }
        }
      }
    } else {
      SessionManager().clearSession();
      yield AuthStateGuestAcc();
    }
    try {
      UserService().loadLocation();
    } catch (e) {}
  }

  Stream<AuthState> _mapLoginToState(AuthEventLogin event) async* {
    yield AuthStateLoading();

    try {
      final response = await userService.login(event.login, event.password);
      if (response.statusCode == 200) {
        final user = await userService.userInfo();
        if (user != null) {
          Settings().isFirstLaunch = false;
          NewsService().loadNews();
          yield AuthStateLogedIn(user: user);
        } else {
          yield AuthStateGuestAcc();
        }
      } else {
        yield AuthStateFail(error: 'Неверный логин или пароль');
        yield AuthStateGuestAcc();
      }
    } catch (e) {
      yield AuthStateGuestAcc();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      yield AuthStateLoading();
      await userService.userLogOut();
      SessionManager().clearSession();
      StaticData.user = null;
      yield AuthStateGuestAcc();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AuthState> _mapSwitchFirstToState() async* {
    Settings().isFirstLaunch = false;
    yield AuthStateGuestAcc(needToShowInfo: true);
  }

  Stream<AuthState> _mapRefreshToState() async* {
    AuthState cState = state;

    if (cState is AuthStateLogedIn) {
      //yield AuthStateLoading();
      String token = await SessionManager().getAuthorizationToken();
      if (token == null) {
        await SessionManager().relogin();
        token = await SessionManager().getAuthorizationToken();
      }
      if (token != null) {
        try {
          UserModel user = await userService.userInfo();
          if (user != null) {
            //StaticData.user.value = user;
            yield AuthStateLogedIn(user: user);
          } else {
            yield cState;
          }
        } catch (e) {
          yield cState;
        }
      }
    }
  }
}
