import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppRepository {
  static String mainUrl = "http://eco.loliallen.com/api";
  Dio _dio = Dio();

  Future<UserResponse> userAuth(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("login", login);
    prefs.setString("password", password);
    try {
      var response = await http.post(mainUrl + "/login",
          body: {"username": '$login', "password": '$password'});
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        prefs.setString("u_id", data["_id"]["! @ # \$ & * ~oid"]);
        prefs.setString("username", data["username"]);
        prefs.setString("name", data["name"]);
        prefs.setString("password", data["password"]);
        prefs.setString("image", data["image"]);
        prefs.setBool("confirmed", data["confirmed"]);
        prefs.setInt("eco_coins", data["eco_coins"]);
        prefs.setInt("code", data["code"]);
        prefs.setString("qrcode", data["qrcode"]);
        prefs.setString("token", data["token"]);

        prefs.setBool("isFirstIn", false);
        print(prefs.getString("token"));
        return UserLoggedIn.fromUser(UserModel(
          id: prefs.getString("u_id"),
          username: prefs.getString("username"),
          name: prefs.getString("name"),
          password: prefs.getString("password"),
          image: prefs.getString("image"),
          confirmed: prefs.getBool("confirmed"),
          ecoCoins: prefs.getInt("eco_coins"),
          refCode: prefs.getInt("code"),
          qrCode: prefs.getString("qrcode"),
          token: prefs.getString("token"),
        ));
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString("password");

    UserModel user = UserModel(
      id: prefs.getString("u_id"),
      username: prefs.getString("username"),
      name: prefs.getString("name"),
      password: prefs.getString("password"),
      image: prefs.getString("image"),
      confirmed: prefs.getBool("confirmed"),
      ecoCoins: prefs.getInt("eco_coins"),
      refCode: prefs.getInt("code"),
      qrCode: prefs.getString("qrcode"),
      token: prefs.getString("token"),
    );
    if (user.token != null) {
      try {
        UserResponse userResponse = await userAuth(user.username, pass);
        return userResponse;
      } catch (error, stacktrace) {
        print("Exception occured: $error stackTrace: $stacktrace");
        return UserAuthFailed("Нет сети");
      }
    } else {
      return UserUnlogged();
    }
  }

  ///Запрос на регистрацию
  ///TODO: доделать возврат из функции
  Future<UserResponse> regUser(String name, String surname, String username,
      String pass, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
        prefs.setString("u_id", data["_id"]["! @ # \$ & * ~oid"]);
        prefs.setString("username", data["username"]);
        prefs.setString("name", data["name"]);
        prefs.setString("password", data["password"]);
        prefs.setString("image", data["image"]);
        prefs.setBool("confirmed", data["confirmed"]);
        prefs.setInt("eco_coins", data["eco_coins"]);
        prefs.setInt("code", data["code"]);
        prefs.setString("qrcode", data["qrcode"]);
        prefs.setString("token", data["token"]);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel(
      id: prefs.getString("u_id"),
      username: prefs.getString("username"),
      name: prefs.getString("name"),
      password: prefs.getString("password"),
      image: prefs.getString("image"),
      confirmed: prefs.getBool("confirmed"),
      ecoCoins: prefs.getInt("eco_coins"),
      refCode: prefs.getInt("code"),
      qrCode: prefs.getString("qrcode"),
      token: prefs.getString("token"),
    );
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
        mainUrl + "/forget?username=${username}&code=$code",
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("u_id");
    prefs.remove("username");
    prefs.remove("name");
    prefs.remove("password");
    prefs.remove("image");
    prefs.remove("confirmed");
    prefs.remove("eco_coins");
    prefs.remove("code");
    prefs.remove("qrcode");
    prefs.remove("token");
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
