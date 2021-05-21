import 'package:flutter/material.dart';


class CustomTheme{
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: Color.fromRGBO(250, 242, 218, 1),
      scaffoldBackgroundColor: Colors.white,
      buttonColor: Color.fromRGBO(143, 214, 225, 1),
      backgroundColor: Colors.white,
      bottomAppBarColor: Color.fromRGBO(255, 170, 167, 1),
      accentColor: Color.fromRGBO(244, 204, 164, 1)
    );
  }
}