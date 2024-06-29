import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/utils/constants.dart';

AppBar appBar({required String title, Function()? onTap, isShowArrow = true}) {
  return AppBar(
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColor.whiteColor,
    leading: isShowArrow
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              height: 24,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Images.arrowBackImage,
                height: 24,
                width: 24,
              ),
            ),
          )
        : Container(),
    title: getText(
        title: title,
        size: 16,
        fontFamily: Constants.poppinsMedium,
        color: AppColor.blackColor,
        fontWeight: FontWeight.w500),
  );
}
