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

  static bool get completeProfile => sharedPrefs.getBool(Constants.IS_COMPLETE_PROFILE) ?? false;
  static set setCompleteProfile( value) {
    sharedPrefs.setBool(Constants.IS_COMPLETE_PROFILE, value);
  }

  static bool get otpEmailVerify => sharedPrefs.getBool(Constants.IS_OTP_EMAIL) ?? false;
  static set setOtpEmailVerify( value) {
    sharedPrefs.setBool(Constants.IS_OTP_EMAIL, value);
  }
  static bool get pinSetup => sharedPrefs.getBool(Constants.IS_PIN_SETUP) ?? false;
  static set setPinSetup( value) {
    sharedPrefs.setBool(Constants.IS_PIN_SETUP, value);
  }
  static bool get passwordSetup => sharedPrefs.getBool(Constants.IS_PASSWORD_SETUP) ?? false;
  static set setPasswordSetup( value) {
    sharedPrefs.setBool(Constants.IS_PASSWORD_SETUP, value);
  }

  static bool get bankSetup => sharedPrefs.getBool(Constants.IS_BANK_ACCOUNT) ?? false;
  static set setBankSetup( value) {
    sharedPrefs.setBool(Constants.IS_BANK_ACCOUNT, value);
  }

  static String get userEmail => sharedPrefs.getString(Constants.USER_EMAIL) ?? "";
  static set setUserEmail(String value) {
    sharedPrefs.setString(Constants.USER_EMAIL, value);
  }

  static String get userId => sharedPrefs.getString(Constants.FCM_TOKEN) ?? "";
  static set setFcmToken(String value) {
    sharedPrefs.setString(Constants.FCM_TOKEN, value);
  }

  static String get fcmToken => sharedPrefs.getString(Constants.USER_ID) ?? "";
  static set setUserId(String value) {
    sharedPrefs.setString(Constants.USER_ID, value);
  }

  static bool get viewBalance => sharedPrefs.getBool(Constants.VIEW_BALANCE) ?? false;
  static set setViewBalance( value) {
    sharedPrefs.setBool(Constants.VIEW_BALANCE, value);
  }

  static bool get isFirstTime => sharedPrefs.getBool(Constants.IS_FIRST_TIME) ?? false;
  static set setIsFirstTime( value) {
    sharedPrefs.setBool(Constants.IS_FIRST_TIME, value);
  }

  static String get savedDataNumber => sharedPrefs.getString(Constants.SAVED_DATA_NUMBER) ?? "";
  static set setSavedDataNumber(String value) {
    sharedPrefs.setString(Constants.SAVED_DATA_NUMBER, value);
  }
}
