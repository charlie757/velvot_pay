import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:velvot_pay/utils/constants.dart';

convertHtmlWidget(String html) {
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
        fontSize: 14,
        fontFamily: Constants.poppinsRegular,
        color: const Color(0xff616161),
        fontWeight: FontWeight.w300),
  );
}
