import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/utils/constants.dart';
import 'package:velvot_pay/utils/utils.dart';

import '../helper/screen_size.dart';

AppBar appBar({required String title, Function()? onTap, isShowArrow = true, Color backgroundColor = AppColor.whiteColor,
List<Widget>?actions
}) {
  return AppBar(
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: (){
        isShowArrow?
        Navigator.pop(navigatorKey.currentContext!):null;
      },
      child: Row(
        children: [
          isShowArrow
              ? Container(
                // height: 24,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Images.arrowBackImage,
                  height: 24,
                  width: 24,
                ),
              )
              : Container(),
          ScreenSize.width(10),
          Expanded(child: getText(
              title: title,
              size: 19,
              fontFamily: Constants.galanoGrotesqueMedium,
              color: AppColor.grayIronColor,
              fontWeight: FontWeight.w700),)
        ],
      ),
    ),
    actions: actions,
  );
}
