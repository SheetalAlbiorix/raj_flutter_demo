import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      focusColor: Colors.black87,
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.blue))
      /*  primaryColor: .lightBlue,
    brightness: Brightness.light,*/
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black87,
      focusColor: Colors.white);
}
