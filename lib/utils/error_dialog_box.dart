import 'package:flutter/material.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../helper/app_color.dart';
import '../helper/custom_btn.dart';
import '../helper/getText.dart';
import '../helper/screen_size.dart';
import 'Constants.dart';

errorAlertDialog(String error){
  showDialog(
      context: navigatorKey.currentContext!, builder: (context){
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: getText(title: "Error",
                size: 18, fontFamily: Constants.galanoGrotesqueMedium, color: AppColor.grayIronColor,
                fontWeight: FontWeight.w500),
          ),
          ScreenSize.height(25),
          getText(title:error,
              size: 14, fontFamily: Constants.galanoGrotesqueRegular,
              color: AppColor.grayIronColor, fontWeight: FontWeight.w400),
          ScreenSize.height(30),
          CustomBtn(title: "Okay", onTap: (){
            Navigator.pop(context);
          })
        ],
      ),
    );
  });
}
