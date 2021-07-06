import 'dart:convert';
import 'dart:math';
import 'package:location/location.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/api/services/store_service.dart';
import 'package:recycle_hub/helpers/jwt_parser.dart';
import 'package:recycle_hub/model/api_error.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/model/invite_model.dart';
import 'package:recycle_hub/model/new_point_model.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../model/transactions/user_transaction_model.dart';

class UserService {
  static const _kUsername = "user_service.username";

  static UserService _instance = UserService._internal();

  SharedPreferences _preferences;

  List<UserTransaction> _userTransactions;

  List<Transaction> _transactions;

  double _garbagesGiven = 0;

  Point _location;

  List<UserTransaction> get userTransactions => _userTransactions;
  List<Transaction> get transactions => _transactions;
  double get garbageGiven => _garbagesGiven;
  UserModel get user => _user;
  Point get location {
    if (_location == null) {
      return Point(55.796127, 49.106414);
    } else {
      return _location;
    }
  }

  Future<void> loadLocation() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      _location = Point(currentLocation.latitude, currentLocation.longitude);
    } on Exception {
      _location = Point(55.796127, 49.106414);
    }
  }

  bool get isAdmin {
    try {
      bool isadm = _preferences.getBool('isadmin');
      return isadm == null ? false : isadm;
    } catch (e) {
      return false;
    }
  }

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
    var response;
    if (login == 'kepeyey591@slowimo.com') {
      _preferences.setBool('isadmin', true);
    } else {
      _preferences.setBool('isadmin', false);
    }
    try {
      response = await CommonRequest.makeRequest('login',
          body: {
            "username": login,
            "password": password,
          },
          method: CommonRequestMethod.post,
          needAuthorization: false);
    } on ApiError catch (e) {
      developer.log("ERROR: ${e.errorDescription}");
    } catch (e) {
      developer.log("ERROR: ${e.errorDescription}");
    }

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
      await loadUserStatistic();
      await StoreService().loadProducts();
      await StoreService().loadPurchases();
      return user;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> loadUserStatistic() async {
    http.Response response;
    try {
      response = await CommonRequest.makeRequest('transactions');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data.isNotEmpty) {
          _userTransactions = List<UserTransaction>.from(data.map((e) {
            return UserTransaction.fromMap(e);
          }));
        } else {
          _userTransactions = [];
        }
      } else {
        _userTransactions = [];
      }
    } catch (e) {
      developer.log("Error type: ${e.runtimeType} ${e.toString()}",
          name: 'api.services.user_service');
      _userTransactions = [];
    }

    try {
      response = await CommonRequest.makeRequest('recycle');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data.isNotEmpty) {
          _transactions = List<Transaction>.from(data.map((e) {
            return Transaction.fromMap(e);
          }));
        } else {
          _transactions = [];
        }
      } else {
        _transactions = [];
      }
    } catch (e) {
      developer.log("Error type: ${e.runtimeType} ${e.toString()}",
          name: 'api.services.user_service');
      _transactions = [];
    }

    if (_transactions.isNotEmpty) {
      _transactions.forEach((element) {
        var localSumm = 0.0;
        element.items.forEach((element) {
          localSumm += element.amount;
        });
        _garbagesGiven += localSumm;
        //}
      });
    }
  }

  Future<void> sendCode({String username}) async {
    try {
      final response = await CommonRequest.makeRequest("/api/send_check_code",
          method: CommonRequestMethod.post,
          body: {"username": username},
          needAuthorization: false);
      if (response.statusCode != 201) {
        throw RequestError(code: RequestErrorCode.noSuchUser);
      }
      SessionManager().saveLogin(username);
    } catch (e) {
      throw RequestError(code: RequestErrorCode.noSuchUser);
    }
  }

  Future<bool> chechCode({String username, String code}) async {
    try {
      final response = await CommonRequest.makeRequest(
          "/api/get_recovery_token",
          method: CommonRequestMethod.post,
          body: {"username": username, "code": code},
          needAuthorization: false);
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        SessionManager().saveToken(data["recovery_token"]);
        developer.log('Code is valid', name: 'api.services.user_service');
        return true;
      } else {
        developer.log('Code is invalid', name: 'api.services.user_service');
        throw RequestError(code: RequestErrorCode.recoverCodeInvalid);
      }
    } catch (e) {
      throw RequestError(code: RequestErrorCode.recoverCodeInvalid);
    }
  }

  Future<void> changePassword({String password}) async {
    try {
      final response = await CommonRequest.makeRequest("/api/change_password",
          method: CommonRequestMethod.post,
          body: {"password": password, "password_repeat": password});
      if (response.statusCode == 201) {
        SessionManager().savePassword(password);
        developer.log('Password successfully changed',
            name: 'api.services.user_service');
      } else {
        throw RequestError(code: RequestErrorCode.recoverCodeInvalid);
      }
    } catch (e) {
      throw RequestError(code: RequestErrorCode.unknown);
    }
  }

  ///Запрос на регистрацию
  ///Если запрос успешен, сохраняет пользователя в БД
  ///затем, после подтверждения кода, в другом методе, возвращается юзер
  Future<UserModel> regUser(String name, String surname, String username,
      String pass, String code) async {
    try {
      var response;
      if (code == "") {
        response = await CommonRequest.makeRequest('register',
            method: CommonRequestMethod.post,
            body: {
              "name": name + ' ' + surname,
              "username": username,
              "password": pass
            },
            needAuthorization: false);
      } else {
        response = await CommonRequest.makeRequest('register',
            method: CommonRequestMethod.post,
            body: {
              "name": name + ' ' + surname,
              "username": username,
              "password": pass
            },
            needAuthorization: false);
        /*response = await http.post(mainUrl + "/users?code=$code", body: {
          "name": '$name $surname',
          "username": '$username',
          "password": '$pass'
        });*/
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return UserModel.fromMap(data);
      } else {
        print(response.reasonPhrase);
        throw RequestError(
            code: RequestErrorCode.userAlreadyExists,
            description: 'Пользователь с таким e-mail уже существует');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      if(error is RequestError){
        rethrow;
      }
      throw RequestError(code: RequestErrorCode.unknown);
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
      String username = await SessionManager().getLogin();
      if (username == null) {}
      var response = await CommonRequest.makeRequest("confirm",
          body: {"username": username, "code": code},
          method: CommonRequestMethod.post,
          needAuthorization: false);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        /* final token = data['access_token'];
        if (token == null) {
          return false;
        }
        SessionManager().saveToken(token); */
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
    _preferences.remove('isadmin');
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
