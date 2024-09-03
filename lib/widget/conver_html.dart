import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:velvot_pay/utils/constants.dart';

convertHtmlWidget(String html,double fontSize,FontWeight fontWeight) {
  return HtmlWidget(
    html,
    customStylesBuilder: (element) {
      if (element.classes.contains('foo')) {
        return {'color': 'red'};
      }

      return null;
    },
    renderMode: RenderMode.column,
    textStyle: TextStyle(
        fontSize: fontSize,
        fontFamily: Constants.galanoGrotesqueRegular,
        color: const Color(0xff70707B),
        fontWeight: fontWeight),
  );
}
