import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velvot_pay/provider/splash_provider.dart';
import 'package:velvot_pay/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SplashProvider())],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Velvot Pay',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white),
          home: SplashScreen()),
    );
  }
}
