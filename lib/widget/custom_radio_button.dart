
import 'package:flutter/material.dart';

import '../helper/app_color.dart';

customRadioButton(bool isShowSelected){
  return Container(
    height: 18,width: 18,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.greenColor)
    ),
    padding:const EdgeInsets.all(2),
    child: isShowSelected? Container(
      height: 18,width: 18,
      decoration: BoxDecoration(
          shape: BoxShape.circle,color: AppColor.greenColor
      ),
    ):Container(),
  );
}
