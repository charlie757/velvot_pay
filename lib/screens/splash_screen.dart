import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SvgPicture.asset(
              Images.splashLogo,
            ),
            const Spacer(),
            Stack(
              children: [
                SvgPicture.asset(Images.splashBottomLogo),
                // getText(title: title, size: size, fontFamily: fontFamily, color: color, fontWeight: fontWeight)
              ],
            )
          ],
        ),
      ),
    );
  }
}
