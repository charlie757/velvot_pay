import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:velvot_pay/helper/session_manager.dart';
import 'package:velvot_pay/provider/bill_number_provider.dart';
import 'package:velvot_pay/provider/choose_plan_provider.dart';
import 'package:velvot_pay/provider/contact_us_provider.dart';
import 'package:velvot_pay/provider/dashboard_provider.dart';
import 'package:velvot_pay/provider/data_subscription_provider.dart';
import 'package:velvot_pay/provider/pages_provider.dart';
import 'package:velvot_pay/provider/login_provider.dart';
import 'package:velvot_pay/provider/operator_provider.dart';
import 'package:velvot_pay/provider/pay_provider.dart';
import 'package:velvot_pay/provider/profile_provider.dart';
import 'package:velvot_pay/provider/splash_provider.dart';
import 'package:velvot_pay/provider/transaction_provider.dart';
import 'package:velvot_pay/provider/verify_otp_provider.dart';
import 'package:velvot_pay/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/utils/theme.dart';
import 'package:velvot_pay/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager().init();
  HttpOverrides.global = MyHttpOverrides();
  await FlutterContacts.requestPermission();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => OperatorProvider()),
        ChangeNotifierProvider(create: (_) => PagesProvider()),
        ChangeNotifierProvider(create: (_) => ContactUsProvider()),
        ChangeNotifierProvider(create: (_) => DataSubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => BillNumberProvider()),
        ChangeNotifierProvider(create: (_) => ChoosePlanProvider()),
        ChangeNotifierProvider(create: (_) => PayProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.unFocusTextField();
      },
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Velvot Pay',
          debugShowCheckedModeBanner: false,
          // darkTheme: darkThemeData(context),
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white),
          home: SplashScreen()),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}