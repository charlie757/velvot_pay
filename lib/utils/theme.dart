import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: Colors.black,
    // accentColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // appBarTheme: appBarTheme,

  );
}


ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.white,
    // accentColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    // appBarTheme: appBarTheme,
  );
}