// ignore_for_file: non_constant_identifier_names

import 'package:velvot_pay/helper/images.dart';

class Constants {

  static String poppinsBold = 'poppinsBold';
  static String poppinsLight = 'poppinsLight';
  static String poppinsMedium = 'poppinsMedium';
  static String poppinsRegular = 'poppinsRegular';
  static String poppinsSemiBold = 'poppinsSemiBold';
  static String galanoGrotesqueBold = 'galanoGrotesqueBold';
  static String  galanoGrotesqueLight = 'galanoGrotesqueLight';
  static String galanoGrotesqueMedium = 'galanoGrotesqueMedium';
  static String galanoGrotesqueRegular = 'galanoGrotesqueRegular';
  static String galanoGrotesqueSemiBold = 'galanoGrotesqueSemiBold';
  static bool is401Error = false;

  static  List serviceList = [
    {
      'title': "Electricity Payment",
      'img':"",
      'value':"ELECTRICITY-BILL-PAYMENT"
    },
    {
      'title': "Data",
      'img':Images.dataIcon,
      'value':"MOBILE-DATA"
    },
    {
      'title': "Insurance",
      'img':Images.insuranceIcon,
      'value':"INSURANCE-DATA"
    },
    {
      'title': "Cable TV",
      'img':Images.tvSubscriptionIcon,
      "value":"TV-DATA"
    },
    {
      'title': "Edu Payment",
      'img':Images.educationIcon,
      "value":"EDUCATION-DATA"
    },
  ];

  ///
  static String TOKEN = 'token';
  static String FCM_TOKEN = 'FCM_TOKEN';
  static String USER_ID = 'USER_ID';
  static String VIEW_BALANCE = 'VIEW_BALANCE';
  static String IS_FIRST_TIME = 'IS_FIRST_TIME';
  static String IS_COMPLETE_PROFILE = 'IS_COMPLETE_PROFILE';
  static String IS_OTP_EMAIL = 'IS_OTP_EMAIL';
  static String IS_PIN_SETUP = 'IS_PIN_SETUP';
  static String IS_PASSWORD_SETUP = 'IS_PASSWORD_SETUP';
  static String IS_BANK_ACCOUNT = 'IS_BANK_ACCOUNT';
  static String USER_EMAIL = 'USER_EMAIL';
  static String SAVED_DATA_NUMBER = 'SAVED_DATA_NUMBER';

}
