import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:recycle_hub/helpers/static_data.dart';
import 'package:recycle_hub/model/user_model.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationStateInitial());
  final UserService userService = UserService();
  final SessionManager sessionManager = SessionManager();

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationEventRegister) {
      yield* _mapRegisterToState(event);
    } else if (event is RegistrationEventConfirm) {
      yield* _mapRegConfirmToState(event.code);
    } else if (event is RegistrationEventHasCode) {
      yield* _mapAlreadyHasCodeToState(event);
    }
  }

  Stream<RegistrationState> _mapRegisterToState(
      RegistrationEventRegister event) async* {
    String name = event.name;
    String surname = event.surname;
    String username = event.username;
    String pass = event.pass;
    String code = event.code;
    yield RegistrationStateLoading();
    try {
      final response =
          await userService.regUser(name, surname, username, pass, code);
      if (response != null) {
        sessionManager.saveLogin(event.username);
        sessionManager.savePassword(event.pass);
        /*SessionManager().relogin();
        final user = await userService.userInfo(); */
        yield RegistrationStateNeedConfirm();
      }else{
        RegistrationStateError('Упс... Что-то пошло не так');
      }
    } catch (e) {
      yield RegistrationStateError(e.toString());
    }
  }

  Stream<RegistrationState> _mapRegConfirmToState(String code) async* {
    final bool res = await userService.confirmCode(code);
    if (res) {
      String login = await sessionManager.getLogin();
      String pass = await sessionManager.getPassword();
      if (login != null && pass != null) {
        await sessionManager.relogin();
        try {
          UserModel user = await UserService().userInfo();
          if (user != null) {
            StaticData.user.value = user;
            GetIt.I.get<AuthBloc>().add(AuthEventInit());
            yield RegistrationStateConfirmed();
            Settings().isFirstLaunch = false;
          } else {
            yield RegistrationStateError('Не удалось авторизоваться');
          }
        } catch (e) {
          SessionManager().clearSession();
        }
      }
    } else {
      yield RegistrationStateError('Неверный код');
      //yield AuthStateLogOuted();
    }
  }

  Stream<RegistrationState> _mapAlreadyHasCodeToState(
      RegistrationEventHasCode event) async* {
    if (event.username == null || event.username.isEmpty) {
      yield RegistrationStateError('Введите логин');
    }
    try {
      await SessionManager().saveLogin(event.username);
      yield RegistrationStateNeedConfirm();
    } catch (e) {
      yield RegistrationStateError('Упс, что-то пошло не так');
    }
  }
}
