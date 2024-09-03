
import 'package:flutter/material.dart';

import '../helper/app_color.dart';
import '../helper/getText.dart';
import '../helper/screen_size.dart';
import '../utils/Constants.dart';
rowColumnForConfirmationWidget(String title, String  subTitle){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      getText(title: title, size: 14,
          fontFamily: Constants.galanoGrotesqueRegular,
          color: const Color(0xff7F808C), fontWeight: FontWeight.w400),
      ScreenSize.width(8),
      Expanded(
        child: getText(title: subTitle, size: 14,
            fontFamily: Constants.galanoGrotesqueSemiBold,
            textAlign: TextAlign.right,
            color: AppColor.grayIronColor, fontWeight: FontWeight.w600),
      )
    ],
  );
}
