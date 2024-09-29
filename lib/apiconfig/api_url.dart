class ApiUrl {
  static String payStackPublicKey = 'pk_test_04a44a0fbe29b8103e588c722c42817364df3412';
  static String baseUrl = 'https://velvotpay.com:2021/v1/';
      // 'http://20.56.149.83:2021/v1/';
      // 'http://app.velvotpay.com:2021/v1/';
      // 'http://velvotpay.com:2021/v1/';
  static String imgBaseUrl = 'https://velvotpay.com:2021/';
      // 'http://app.velvotpay.com/api/';
      // 'http://velvotpay.com:2021/';
  static String loginUrl = '${baseUrl}auth/customer-login';
  /// sign up
  static String registerUrl = '${baseUrl}auth/register';
  static String verifyOtpUrl = '${baseUrl}auth/verifyOTP';
  static String resendOtpUrl = '${baseUrl}auth/resend';
  static String createPasswordUrl = '${baseUrl}customer/create-password';
  static String setMPinUrl = '${baseUrl}customer/set-transaction-pin';
  static String updateProfileUrl = '${baseUrl}customer/updateProfile';

  /// forgot
  static String forgotUrl = '${baseUrl}auth/forgotPassword';
  static String resetPasswordUrl = '${baseUrl}customer/reset-password';

  static String dashboardUrl = '${baseUrl}customer/dashboard';
  static String getProfileUrl = '${baseUrl}customer/profile';
  static String bannerUrl = '${baseUrl}banner/list';
  static String faqUrl = '${baseUrl}faq/list';
  static String privacyUrl = '${baseUrl}cms/page/privacy-policy';
  static String aboutUsUrl= '${baseUrl}cms/page/about-us';
  static String contactUsUrl = '${baseUrl}cms/contactUs';
  static String transactionUrl = '${baseUrl}transaction/list';
  static String transactionDetailsUrl = '${baseUrl}transaction/details/';
  static String transactionDownloadUrl = '${baseUrl}transaction/download';

  /// wallet
  static String addWalletUrl = '${baseUrl}wallet/create';
  /// bank
  static String createBankUrl = '${baseUrl}customer/createAccount';
  static String bankUrl = '${baseUrl}customer/bank-account';


  /// saved transaction
  static String savedTransactionUrl = '${baseUrl}utility/save-transactions';

  /// data subscription
  static String dataSubscriptionOperatorListUrl =
      '${baseUrl}utility/data-subscription/operator';
  static String dataSubscriptionPlanListUrl = '${baseUrl}utility/data-subscription/operator/plan/';
  static String buyDataSubscriptionPlanUrl = '${baseUrl}utility/data-subscription/buy-plan';

  /// tv subscription
  static String tvOperatorListUrl =
      '${baseUrl}utility/tv-subscription/operator';
  static String getTvOperatorPlanUrl = '${baseUrl}utility/tv-subscription/operator/plan/';
  static String buyTvPlanUrl = '${baseUrl}utility/tv-subscription/buy-plan';

  /// electricity
  static String electricityOperatorListUrl =
      '${baseUrl}utility/electricity/operator';
  static String prepaidElectricityPlanUrl = '${baseUrl}utility/electricity/bill-details';
  static String getElectricityPlanUrl = '${baseUrl}utility/electricity/bill-details';
  static String electricityBillPaymentUrl = '${baseUrl}utility/electricity/bill-payment';

  ///education
  static String educationalOperatorListUrl =
      '${baseUrl}utility/educational/operator';
 static String getEducationalPlanUrl = '${baseUrl}utility/educational/operator/plan/';
 static String buyEducationalPlanUrl = '${baseUrl}utility/educational/buy-plan';

  /// insurance
  static String insuranceOperatorListUrl =
      '${baseUrl}utility/insurance/operator';
  static String getInsurancePlanUrl = '${baseUrl}utility/insurance/operator/plan/';
  static String getHospitalUrl = '${baseUrl}utility/health-insurance/hospital';
  static String buyVehiclePlanUrl = '${baseUrl}utility/insurance-vehicle/buy-plan';
  static String buyHealthPlanUrl = '${baseUrl}utility/insurance-health/buy-plan';
  static String buyPersonalPlanUrl = '${baseUrl}utility/insurance-personal/buy-plan';

  /// pay
  static String payStackInitializeUrl = '${baseUrl}pay-stack/initialize';

  /// mobile top up
static String mobileTopUpOperatorListUrl = '${baseUrl}utility/mobile-top-up/operator';
static String buyMobileTopUpPlanUrl = '${baseUrl}utility/mobile-top-up/buy-plan';

/// notification
 static String notificationUrl = '${baseUrl}notification';

 static String checkPinUrl = '${baseUrl}customer/check-pin';

 static String deleteAccountUrl = '${baseUrl}customer/profile';
}
