import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/Constants.dart';
import 'app_color.dart';
customOtpTextField(BuildContext context, TextEditingController controller, {bool isReadOnly=false}) {
  return SizedBox(
    // height: 48,
    child: PinCodeTextField(
      readOnly: isReadOnly,
      onTap: (){},
      enabled: !isReadOnly,
      controller: controller,
      cursorColor: AppColor.hintTextColor,
      autovalidateMode: AutovalidateMode.disabled,
      cursorHeight: 20,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(
          8,),
        borderWidth: 1,
        activeColor: const Color(0xffF4F4F5),
        disabledColor: const Color(0xffF4F4F5),
        selectedColor: AppColor.appColor.withOpacity(.5),
        inactiveColor: const Color(0xffF4F4F5),
        fieldHeight: 48,
        fieldWidth: 48,
        inactiveFillColor: const Color(0xffF4F4F5),
        selectedFillColor: const Color(0xffF4F4F5),
        activeFillColor: const Color(0xffF4F4F5),
      ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      length: 6,
      animationDuration: const Duration(milliseconds: 300),
      appContext: context,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(
          color: AppColor.grayIronColor, fontFamily: Constants.galanoGrotesqueRegular),
      enableActiveFill: true,
      onChanged: (val) {},
      onCompleted: (result) {},
      validator: (val) {
        if (val!.isEmpty) {
          return 'Enter otp';
        } else if (val.length < 6) {
          return 'Enter otp shoulb be valid';
        }
        return null;
      },
    ),
  );
}
