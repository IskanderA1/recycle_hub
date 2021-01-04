import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:recycle_hub/model/user_response.dart';
import 'package:http/http.dart' as http;


class AppRepository {
  static String mainUrl =
      "";




  Future<UserResponse> userAuth(String login, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response =
          await http.post(mainUrl);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (data['status'] == 'success') {
        prefs.setString("login", login);
        prefs.setString("password", password);
        print(data['surname']);
        return UserResponse.fromJson(data);
      } else {
        print(data['message']);
        return UserResponse.withError(data['message']);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("Нет сети");
    }
  }

  Future<UserResponse> userAuthLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String login = prefs.getString("login");
    String password = prefs.getString("password");
    
    if (login != null && password != null) {
      try {
        var response =
          await http.post(mainUrl);
      Map<String, dynamic> data = jsonDecode(response.body);
      //var rest = data["Data"] as List;
      print(data);
      if (data['status'] == 'success') {
        print(data['surname']);
        return UserResponse.fromJson(data);
      } else {
        print(data['message']);
        return UserResponse.withError(data['message']);
      }
      } catch (error) {
        //print("Exception occured: $error stackTrace: $stacktrace");
        return UserResponse.withError("Нет сети");
      }
    } else {
      return UserResponse.withError("Авторизуйтесь");
    }
  }

  Future<UserResponse> userLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    prefs.remove("password");
    return UserResponse.withError("Авторизуйтесь");
  }

}
