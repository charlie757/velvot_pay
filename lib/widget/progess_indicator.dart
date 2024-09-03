import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../helper/app_color.dart';
import '../helper/getText.dart';
import '../helper/screen_size.dart';
import '../utils/Constants.dart';

Widget progressIndicator(currentIndex){
  return  Row(
    children: [
      Expanded(child:  LinearPercentIndicator(
        padding: EdgeInsets.zero,
        barRadius: const Radius.circular(40),
        percent: currentIndex/ 6,
        backgroundColor: const Color(0xffE4E4E7),
        progressColor: AppColor.greenColor,
      ),),
      ScreenSize.width(4),
      getText(title: '$currentIndex/6',
          size: 12, fontFamily: Constants.galanoGrotesqueRegular,
          color: const Color(0xff1A1A1E), fontWeight: FontWeight.w400)
    ],
  );
}