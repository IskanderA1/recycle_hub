import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/settings.dart';
import './request.dart';


class SessionManager {
  static const String authorizationTokenKey = "AuthToken";
  static const String kLoginKey = "Recycle.Login";
  static const String kPasswordKey = "Recycle.Password";

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String _token;
  String _login;
  String _password;

  static final SessionManager _singleton = SessionManager._internal();

  factory SessionManager() {
    return _singleton;
  }

  SessionManager._internal();

  Future<void> saveToken(String token) async {
    _token = token;
    await _storage.write(
        key: SessionManager.authorizationTokenKey, value: token);
  }

  Future<void> saveLogin(String login) async {
    _login = login;
    await _storage.write(key: SessionManager.kLoginKey, value: login);
  }

  Future<void> savePassword(String password) async {
    _password = password;
    await _storage.write(key: SessionManager.kPasswordKey, value: password);
  }

  Future<String> getLogin() async {
    if (_login == null) {
      _login = await _readValueFromKeychain(SessionManager.kLoginKey);
    }
    return _login;
  }

  Future<String> getPassword() async {
    if (_password == null) {
      _password = await _readValueFromKeychain(SessionManager.kPasswordKey);
    }
    return _password;
  }

  Future<String> _readValueFromKeychain(String key) async {
    var value;
    try {
      value = await _storage.read(key: key);
    } catch (e) {
      print("Error: $e");
      return null;
    }

    return value;
  }

  Future<String> getAuthorizationToken() async {
    if (_token == null) {
      _token =
          await _readValueFromKeychain(SessionManager.authorizationTokenKey);
    }

    return _token;
  }

  Future<void> initializeApi() async {
    var response;
    try {
      response = await CommonRequest.makeRequest("initialize",
          method: CommonRequestMethod.post, needAuthorization: false);
    } catch (e) {
      throw e;
    }

    var authorizationToken = response.headers["authorization"];

    await this.saveToken(authorizationToken);
  }

  Future<void> relogin() async {
    String login = await SessionManager().getLogin();
    String password = await SessionManager().getPassword();
    if (login != null && password != null) {
      await UserService().login(login, password);
    }
  }

  Future<void> clearSession() async {
    print("CLEAR SESSION");
    await _storage.delete(key: authorizationTokenKey);
    await _storage.delete(key: kPasswordKey);
    await _storage.delete(key: kLoginKey);
    await initializeApi();
  }


  Future<bool> isNeedLogin() async {
    DateTime time = await Settings().getSessionTokenTime();
    DateTime nowTime = DateTime.now();
    Duration duration = nowTime.difference(time);
    if (duration.inHours >= 2) {
      return true;
    }
    return false;
  }
}
