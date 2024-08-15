import 'package:flutter/material.dart';
import 'package:velvot_pay/utils/constants.dart';

import 'app_color.dart';
import 'getText.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final bool isLoading;
  final Function() onTap;
  const CustomBtn({
    required this.title,
    this.height,
    this.width,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              isLoading ? AppColor.btnColor.withOpacity(.5) : AppColor.btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 48,
        width: width ?? double.infinity,
        child: isLoading
            ? Container(
                height: 22,
                width: 22,
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : getText(
                title: title,
                size: 16,
                fontFamily: Constants.poppinsMedium,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w600),
      ),
    );
  }
}
