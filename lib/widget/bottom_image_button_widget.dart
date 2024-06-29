import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/custom_btn.dart';
import 'package:velvot_pay/helper/images.dart';

Widget bottomImageButtonWidget(
    {required Function() onTap, required String btnText}) {
  return Container(
    // color: Colors.red,
    height: 240,
    child: Stack(
      children: [
        SvgPicture.asset(
          Images.bottomImage,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 125),
            child: CustomBtn(title: btnText, onTap: onTap),
          ),
        )
      ],
    ),
  );
}
