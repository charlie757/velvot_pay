// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import 'app_color.dart';

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
  Widget? suffixWidget;
  Widget? prefixWidget;
  FocusNode? focusNode;
  Color? fillColor;
  Function()? onTap;
  int maxLines;
  Color borderColor;
  double borderRadius;
  bool isObscureText;
  CustomTextField(
      {required this.hintText,
      this.controller,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.isReadOnly = false,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.suffixWidget,
        this.prefixWidget,
      this.textCapitalization = TextCapitalization.none,
      this.textColor = AppColor.grayIronColor,
      this.focusNode,
        this.isObscureText=false,
      this.fillColor = const Color(0xffF9FAFB),
      this.onTap,this.maxLines=1,this.borderColor=AppColor.lightAppColor,this.borderRadius=1});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: widget.focusNode,
      obscureText: widget.isObscureText,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      autofocus: false,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: widget.textColor,
          fontFamily: Constants.galanoGrotesqueMedium),
      cursorColor: AppColor.appColor,
      decoration: InputDecoration(
        // fillColor: widget.fillColor ?? AppColor.lightAppColor,
        fillColor: widget.fillColor,
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixWidget,
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        hintText: widget.hintText,
        errorMaxLines: 3,
        errorStyle: TextStyle(
          color: AppColor.redColor.withOpacity(.7),
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: AppColor.hintTextColor,
            fontFamily: Constants.galanoGrotesqueRegular),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
