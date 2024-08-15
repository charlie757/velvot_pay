import 'package:flutter/material.dart';
import 'package:velvot_pay/helper/app_color.dart';

Widget customDivider(double leftMargin) {
  return Container(
    margin: EdgeInsets.only(left: leftMargin),
    color: AppColor.hintTextColor.withOpacity(.3),
    height: 1,
  );
}
