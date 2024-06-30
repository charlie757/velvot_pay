// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velvot_pay/helper/images.dart';

import '../utils/constants.dart';
import 'app_color.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  Color textColor;
  Widget? suffixWidget;
  FocusNode? focusNode;
  Color? fillColor;
  Function()? onTap;
  CustomSearchBar(
      {required this.hintText,
      this.controller,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.isReadOnly = false,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.suffixWidget,
      this.textCapitalization = TextCapitalization.none,
      this.textColor = const Color(0xff0E0E0E),
      this.focusNode,
      this.fillColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: widget.focusNode,
      onTap: onTap,
      readOnly: isReadOnly,
      textInputAction: TextInputAction.done,
      controller: controller,
      autofocus: false,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: textColor,
          fontFamily: Constants.poppinsRegular),
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        fillColor: fillColor ?? AppColor.lightAppColor,
        prefixIcon: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            Images.searchIcon,
          ),
        ),
        // isDense: true,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.hintTextColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.hintTextColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.hintTextColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        hintText: hintText,
        errorStyle: TextStyle(
          color: AppColor.redColor,
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.hintTextColor,
            fontFamily: Constants.poppinsRegular),
      ),
      onChanged: onChanged,
    );
    ;
  }
}
