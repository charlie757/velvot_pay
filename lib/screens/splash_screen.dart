import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/provider/splash_provider.dart';

import '../utils/constants.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SizedBox(
              height: 282,
              width: 262,
              child: Image.asset(
                Images.splashLogo,
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                SvgPicture.asset(
                  Images.splashBottomLogo,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 0 + 40,
                    right: MediaQuery.of(context).size.width / 2.5,
                    child: getText(
                        title: "App Version 1.01",
                        size: 12,
                        fontFamily: Constants.poppinsRegular,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w300))
              ],
            )
          ],
        ),
      ),
    );
  }
}
