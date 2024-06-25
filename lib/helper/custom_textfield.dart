import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'app_color.dart';
import 'getText.dart';

class CustomTextField extends StatefulWidget {
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
  FocusNode? focusNode;

  CustomTextField(
      {required this.hintText,
      this.controller,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.isReadOnly = false,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none,
      this.textColor = const Color(0xff0E0E0E),
      this.focusNode});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: widget.focusNode,
      readOnly: widget.isReadOnly,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      autofocus: false,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: widget.textColor,
          fontFamily: Constants.poppinsRegular),
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        fillColor: AppColor.lightAppColor,
        // isDense: true,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.lightAppColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        hintText: widget.hintText,
        errorStyle: TextStyle(
          color: AppColor.redColor,
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.hintTextColor,
            fontFamily: Constants.poppinsRegular),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
