import 'dart:convert';

import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/helpers/jwt_parser.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/invite_model.dart';
import 'package:recycle_hub/model/new_point_model.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const _kUsername = "user_service.username";

  static final UserService _instance = UserService._internal();

  SharedPreferences _preferences;

  UserModel get user => _user;

  UserModel _user;

  factory UserService() {
    return _instance;
  }

  UserService._internal() {
    getPrefs();
  }

  getPrefs() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future<http.Response> login(String login, String password) async {
    var response = await CommonRequest.makeRequest('login',
        body: {
          "username": login,
          "password": password,
        },
        method: CommonRequestMethod.post,
        needAuthorization: false);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String jwtToken = data['access_token'];
      JwnParser.parseJwt(jwtToken);

      SessionManager().saveToken(jwtToken);
    }

    return response;
  }

  Future<UserModel> userInfo() async {
    var response = await CommonRequest.makeRequest('user_info',
        method: CommonRequestMethod.get, needAuthorization: true);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var user = UserModel.fromMap(data);
      _user = user;
      return user;
    } else {
      return null;
    }
  }

  ///Запрос на регистрацию
  ///Если запрос успешен, сохраняет пользователя в БД
  ///затем, после подтверждения кода, в другом методе, возвращается юзер
  Future<UserResponse> regUser(String name, String surname, String username,
      String pass, String code) async {
    try {
      var response;
      if (code == "") {
        response = await CommonRequest.makeRequest('register',
            method: CommonRequestMethod.post,
            body: {
              {
                "name": '$name $surname',
                "username": '$username',
                "password": '$pass'
              }
            });
      } else {
        response = await CommonRequest.makeRequest('register',
            method: CommonRequestMethod.post,
            body: {
              "name": '$name $surname',
              "username": '$username',
              "password": '$pass'
            });
        /*response = await http.post(mainUrl + "/users?code=$code", body: {
          "name": '$name $surname',
          "username": '$username',
          "password": '$pass'
        });*/
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return UserRegOk();
      } else {
        print(response.reasonPhrase);
        return UserRegFailed(data['message']);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserRegFailed("Нет сети");
    }
  }

  ///Отправка кода на указанный емайл
  /*Future<UserResponse> sendCode(String username) async {
    _preferences.setString("username", username);
    try {
      var response = await CommonRequest.makeRequest(endpoint);
      if (response.statusCode == 200) {
        return UserForgetPassCodeSended();
      } else {
        print(response.reasonPhrase);
        return UserForgetPassCodeSendFailed(response.reasonPhrase);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserForgetPassCodeSendFailed(error);
    }
  }*/

  ///Проверка кода для сброса пароля и регистрации
  Future<bool> confirmCode(String code) async {
    try {
      String username = await _preferences.getString(_kUsername);
      if (username == null) {}
      var response = await CommonRequest.makeRequest("confirm",
          body: {"username": username, "code": code},
          method: CommonRequestMethod.post,
          needAuthorization: false);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  /*Future<UserResponse> forgetConfirmCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    try {
      var response = await http.get(
        mainUrl + "/forget?username=$username&code=$code",
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        prefs.setString("code", code);
        return UserForgetPassCodeOk();
      } else {
        print(response.reasonPhrase);
        return UserCodeConfirmFailed(data['message']);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserCodeConfirmFailed("Нет сети");
    }
  }*/

  ///Изменени пароля
  /*Future<UserResponse> changePass(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    String code = prefs.getString("code");

    try {
      var response = await http.post(
        mainUrl + "/forget?username=$username&code=$code&pwd=$pass",
      );
      if (response.statusCode == 200) {
        return UserPassChangedOk();
      } else {
        print(response.reasonPhrase);
        return UserPassChangeFailed();
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserPassChangeFailed();
    }
  }*/

  Future<UserResponse> userLogOut() async {
    return UserUnlogged();
  }

  Future<String> getTransactions() async {
    /*var box = await Hive.openBox('user');
    UserModel user = box.get('user', defaultValue: null);
    if (user != null) {
      try {
        var response = await http.get(
          mainUrl + "/api/recycle?id=${user.id}&type=user",
        );
        if (response.statusCode == 200) {
          List<Map<String, dynamic>> data = json.decode(response.body);
          return TransactionsResponseOk(data);
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return TransactionsResponseError(error);
      }
    }*/
    await Future.delayed(Duration(milliseconds: 300));
    return "ABCDEFG";
  }

  Future sendNewOfferPoint(NewPoint newPoint) async {
    /*var box = await Hive.openBox('user');
    UserModel user = box.get('user', defaultValue: null);
    if (user != null) {
      try {
        var response = await http.get(
          mainUrl + "/api/recycle?id=${user.id}&type=user",
        );
        if (response.statusCode == 200) {
          List<Map<String, dynamic>> data = json.decode(response.body);
          return TransactionsResponseOk(data);
        }
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return TransactionsResponseError(error);
      }
    }*/
    await Future.delayed(Duration(milliseconds: 300));
    return;
  }

  Future<String> getInvite(String id) async {
    /*if (id == null) return null;
    try {
      //final response = await CommonRequest.makeRequest("");
      if (response.statusCode == 201) {
        return Invite.fromMap(response.data);
      } else {
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }*/
    await Future.delayed(Duration(milliseconds: 300));
    return "ABCDEFG";
  }
}
