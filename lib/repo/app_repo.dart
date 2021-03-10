import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class AppRepository {
  static String mainUrl = "http://eco.loliallen.com/api";
  Box userBox;
  AppRepository() {
    hiveOpen();
  }

  hiveOpen()async{
    userBox = await Hive.openBox('user');
  }

  Future<UserResponse> userAuth(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.post(mainUrl + "/login",
          body: {"username": '$login', "password": '$password'});
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        prefs.setBool("isFirstIn", false);
        print(data["token"]);
        UserModel user = UserModel(
          id: data["_id"]["! @ # \$ & * ~oid"],
        username: data["username"],
        name: data["name"],
        password: data["password"],
        image: data["image"],
        confirmed: data["confirmed"],
        ecoCoins: data["eco_coins"],
        refCode: data["code"],
        qrCode: data["qrcode"],
        token: data["token"],
        );
        userBox.put('user', user);
        print(userBox.get('user').toString());
        return UserLoggedIn.fromUser(user);
      } else {
        print(response.reasonPhrase);
        return UserAuthFailed(data['message']);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserAuthFailed("Нет сети");
    }
  }

  Future<UserResponse> userAuthLocal() async {
    var box = await Hive.openBox('user');
    UserModel user = box.get('user');
    if(user!= null){
    if (user.token != null) {
      try {
        UserResponse userResponse = await userAuth(user.username, user.password);
        return userResponse;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return UserAuthFailed("Нет сети");
      }
    } else {
      return UserUnlogged();
    }}else {
      return UserUnlogged();}
  }

  ///Запрос на регистрацию
  ///Если запрос успешен, сохраняет пользователя в БД
  ///затем, после подтверждения кода, в другом методе, возвращается юзер
  Future<UserResponse> regUser(String name, String surname, String username,
      String pass, String code) async {
    try {
      var response;
      if (code == "") {
        response = await http.post(mainUrl + "/users", body: {
          "name": '$name $surname',
          "username": '$username',
          "password": '$pass'
        });
      } else {
        response = await http.post(mainUrl + "/users?code=$code", body: {
          "name": '$name $surname',
          "username": '$username',
          "password": '$pass'
        });
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        UserModel user = UserModel(
          id: data["_id"]["! @ # \$ & * ~oid"],
        username: data["username"],
        name: data["name"],
        password: data["password"],
        image: data["image"],
        confirmed: data["confirmed"],
        ecoCoins: data["eco_coins"],
        refCode: data["code"],
        qrCode: data["qrcode"],
        token: data["token"],
        );
        userBox.put('user', user);
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
  Future<UserResponse> sendCode(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    try {
      var response = await http.post(
        mainUrl + '/forget?username=$username',
      );
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
  }

  ///Проверка кода для сброса пароля и регистрации
  Future<UserResponse> confirmCode(String code) async {
    UserModel user = userBox.get('user');
    try {
      var response = await http.get(
        mainUrl + "/forget?username=${user.username}&code=$code",
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return UserLoggedIn.fromUser(user);
      } else {
        print(response.reasonPhrase);
        return UserCodeConfirmFailed(data['message']);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserCodeConfirmFailed("Нет сети");
    }
  }

  Future<UserResponse> forgetConfirmCode(String code) async {
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
  }

  ///Изменени пароля
  Future<UserResponse> changePass(String pass) async {
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
  }

  Future<UserResponse> userLogOut() async {
    userBox.delete('user');
    return UserUnlogged();
  }

  Future<bool> getComeInNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var isF = prefs.getBool("isFirstIn");
      if (isF == null) {
        return true;
      }
      return isF;
    } catch (error) {
      return true;
    }
  }
}
