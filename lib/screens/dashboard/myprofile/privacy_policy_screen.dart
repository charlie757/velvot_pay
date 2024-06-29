import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/helper/screen_size.dart';
import 'package:velvot_pay/utils/Constants.dart';
import 'package:velvot_pay/widget/appBar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: 'Privacy Policy',
          onTap: () {
            Navigator.pop(context);
          }),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 36,
              right: 35,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: 'What is Lorem Ipsum?',
                    size: 16,
                    fontFamily: Constants.poppinsMedium,
                    color: AppColor.darkBlackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.height(15),
                getText(
                    title:
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                    size: 14,
                    fontFamily: Constants.poppinsRegular,
                    color: const Color(0xff616161),
                    fontWeight: FontWeight.w300)
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(Images.bottomImage))
        ],
      ),
    );
  }
}
