class ApiUrl {
  static String baseUrl = 'http://velvotpay.com:2021/v1/';
  static String loginUrl = '${baseUrl}auth/customer-login';
  static String registerUrl = '${baseUrl}auth/register';
  static String verifyOtpUrl = '${baseUrl}auth/verifyOTP';
  static String resendOtpUrl = '${baseUrl}auth/resend';
  static String getProfileUrl = '${baseUrl}customer/profile';
  static String updateProfileUrl = '${baseUrl}customer/updateProfile';
}
