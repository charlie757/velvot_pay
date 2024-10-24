import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final provider = Provider.of<SplashProvider>(context, listen: false);
    provider.callSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBlueColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor.darkBlueColor,
        alignment: Alignment.center,
        child: Image.asset(Images.logo,width: 171,height: 175,),
      ),
    );
  }
}
