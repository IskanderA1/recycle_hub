import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:recycle_hub/helpers/static_data.dart';
import 'package:recycle_hub/model/user_model.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  RecoveryBloc() : super(RecoveryInitial());
  final UserService userService = UserService();

  @override
  Stream<RecoveryState> mapEventToState(
    RecoveryEvent event,
  ) async* {
    if (event is RecoveryEventSendCode) {
      yield* _mapRecoveryCodeSendToState(event);
    } else if (event is RecoveryEventCheckCode) {
      yield* _mapRecoveryCodeCheckToState(event);
    } else if (event is RecoveryEventChangePass) {
      yield* _mapRecoveryChangePassToState(event);
    }
  }

  Stream<RecoveryState> _mapRecoveryCodeSendToState(
      RecoveryEventSendCode event) async* {
    try {
      yield RecoveryStateLoading();
      await UserService().sendCode(username: event.username);
      yield RecoveryStateLoaded(wasSend: true);
    } catch (e) {
      yield RecoveryStateError("Пользователь не найден");
    }
  }

  Stream<RecoveryState> _mapRecoveryCodeCheckToState(
      RecoveryEventCheckCode event) async* {
    final String username = await SessionManager().getLogin();
    if (username == null || username.isEmpty) {
      yield RecoveryStateError("Пользователь не найден");
      return;
    }
    try {
      final isValid =
          await UserService().chechCode(username: username, code: event.code);
      if (isValid) {
        yield RecoveryStateLoaded(
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
      yield RecoveryStateError(errorText);
    }
  }

  Stream<RecoveryState> _mapRecoveryChangePassToState(
      RecoveryEventChangePass event) async* {
    final String username = await SessionManager().getLogin();
    //TODO: check whether state is AuthStateRecovery
    if (username == null || username.isEmpty) {
      yield RecoveryStateError("Пользователь не найден");
      return;
    }
    await UserService().changePassword(password: event.password);
    final String password = await SessionManager().getPassword();
    if (password == null || password.isEmpty) {
      yield RecoveryStateError(
          'Ошибка при попытке изменить пароль. Повторите попытку');
      return;
    }
    SessionManager().relogin();
    String token = await SessionManager().getAuthorizationToken();
    if (token == null) {
      yield RecoveryStateError(
          'Ошибка при попытке изменить пароль. Повторите попытку');
      return;
    }
    if (token != null) {
      try {
        UserModel user = await userService.userInfo();
        if (user != null) {
          GetIt.I.get<AuthBloc>().add(AuthEventInit());
          Settings().isFirstLaunch = false;
        }
      } catch (e) {
        yield RecoveryStateError(e);
        return;
      }
    }
  }
}
