class ApiUrl {
  static String baseUrl = 'http://velvotpay.com:2021/v1/';
  static String loginUrl = '${baseUrl}auth/customer-login';
  static String registerUrl = '${baseUrl}auth/register';
  static String verifyOtpUrl = '${baseUrl}auth/verifyOTP';
  static String resendOtpUrl = '${baseUrl}auth/resend';
  static String getProfileUrl = '${baseUrl}customer/profile';
  static String updateProfileUrl = '${baseUrl}customer/updateProfile';
  static String bannerUrl = '${baseUrl}banner/list';
  static String faqUrl = '${baseUrl}faq/list';
  static String privacyUrl = '${baseUrl}cms/page/privacy-policy';
  static String contactUsUrl = '${baseUrl}cms/contactUs';

  /// data subscription
  static String dataSubscriptionOperatorListUrl =
      '${baseUrl}utility/data-subscription/operator';

  /// tv subscription
  static String tvOperatorListUrl =
      '${baseUrl}utility/tv-subscription/operator';

  /// electricity
  static String electricityOperatorListUrl =
      '${baseUrl}utility/electricity/operator';

  ///education
  static String educationalOperatorListUrl =
      '${baseUrl}utility/educational/operator';

  /// insurance
  static String insuranceOperatorListUrl =
      '${baseUrl}utility/insurance/operator';
}
