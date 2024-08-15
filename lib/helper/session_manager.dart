import 'package:shared_preferences/shared_preferences.dart';
import 'package:velvot_pay/utils/constants.dart';

class SessionManager {
  static late final SharedPreferences sharedPrefs;
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static String get token => sharedPrefs.getString(Constants.TOKEN) ?? "";
  static set setToken(String value) {
    sharedPrefs.setString(Constants.TOKEN, value);
  }

  static String get userId => sharedPrefs.getString(Constants.FCM_TOKEN) ?? "";
  static set setFcmToken(String value) {
    sharedPrefs.setString(Constants.FCM_TOKEN, value);
  }

  static String get fcmToken => sharedPrefs.getString(Constants.USER_ID) ?? "";
  static set setUserId(String value) {
    sharedPrefs.setString(Constants.USER_ID, value);
  }
}
