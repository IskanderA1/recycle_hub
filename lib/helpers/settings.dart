import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static const _kIsFirstLaunch = "isFirstLaunch";
  static const _kSessionTime = "sessionTime";

  static final Settings _instance = Settings._();
  SharedPreferences _prefs;

  factory Settings() {
    return _instance;
  }

  Settings._() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<int> getIntValue(String key) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs.getInt(key);
  }

  Future<void> setIntValue(String key, int value) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    _prefs.setInt(key, value);
  }

  Future<void> setStringValue(String key, String value) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    _prefs.setString(key, value);
  }

  Future<bool> getValue(String key) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs.getBool(key);
  }

  Future<String> getStringValue(String key) async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs.getString(key);
  }

  // SETTINGS
  Future<bool> getIsFirstLaunch() async => await getValue(_kIsFirstLaunch);
  set isFirstLaunch(bool newValue) => _prefs.setBool(_kIsFirstLaunch, newValue);

  Future<DateTime> getSessionTokenTime() async {
    int milliseconds = await getIntValue(_kSessionTime);
    if (milliseconds == null) {
      return DateTime.now();
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return date;
  }

  Future<void> setSessionTokenTime(DateTime time) async {
    int milliseconds = time.millisecondsSinceEpoch;
    await setIntValue(_kSessionTime, milliseconds);
  }
}
