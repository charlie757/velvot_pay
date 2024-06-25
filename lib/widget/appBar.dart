import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/app_color.dart';
import 'package:velvot_pay/helper/getText.dart';
import 'package:velvot_pay/helper/images.dart';
import 'package:velvot_pay/util/constaints.dart';

AppBar appBar({required String title, Function()? onTap}) {
  return AppBar(
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    backgroundColor: AppColor.whiteColor,
    leading: InkWell(
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
    ),
    title: getText(
        title: title,
        size: 16,
        fontFamily: Constaints.poppinsMedium,
        color: AppColor.blackColor,
        fontWeight: FontWeight.w500),
  );
}
