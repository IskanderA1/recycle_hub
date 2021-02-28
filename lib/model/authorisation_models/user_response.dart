import 'package:recycle_hub/model/global_state_models.dart';
import 'package:recycle_hub/model/user_model.dart';

class UserResponse extends AuthGlobalModel {
  final UserModel user;
  final String error;

  UserResponse(this.user, this.error);

  UserResponse.fromJson(var data)
      : user = UserModel.fromJson(data),
        error = "";

  UserResponse.withError(String errorValue)
      : user = UserModel(),
        error = errorValue;
}

class UserToRegScr extends UserResponse {
  UserToRegScr() : super.withError("");
}

class UserToForgetScr extends UserResponse {
  UserToForgetScr() : super.withError("");
}

class UserLoggedIn extends UserResponse {
  UserLoggedIn(var data) : super.fromJson(data);

  UserLoggedIn.fromUser(UserModel user) : super(user, "");
}

class UserUnlogged extends UserResponse {
  UserUnlogged() : super.withError("Авторизуйтесь");
}

class UserAuthFailed extends UserResponse {
  UserAuthFailed(String err) : super.withError(err);
}

class UserLoading extends UserResponse {
  UserLoading() : super.withError("Загрузка");
}

class UserRegFailed extends UserResponse {
  UserRegFailed(String err) : super.withError(err);
}

class UserRegOk extends UserResponse {
  UserRegOk() : super.withError("Код отправлен");
}

class UserForgetPassCodeSended extends UserResponse {
  UserForgetPassCodeSended() : super.withError("Код отправлен");
}

class UserForgetPassCodeSendFailed extends UserResponse {
  UserForgetPassCodeSendFailed(String err) : super.withError(err);
}

class UserForgetPassCodeOk extends UserResponse {
  UserForgetPassCodeOk() : super.withError("Код проверен");
}

class UserCodeConfirmFailed extends UserResponse {
  UserCodeConfirmFailed(String err) : super.withError(err);
}

class UserPassChangedOk extends UserResponse {
  UserPassChangedOk() : super.withError("Пароль изменен");
}

class UserPassChangeFailed extends UserResponse {
  UserPassChangeFailed() : super.withError("Ошибка при изменении пароля");
}
