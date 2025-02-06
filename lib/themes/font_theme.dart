import 'package:flutter/material.dart';

class FontTheme {
  static ThemeData get theme {
    return ThemeData(
        fontFamily: 'ProductSans',
        textTheme: TextTheme(
            bodySmall: TextStyle(fontSize: 16.0, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 32, color: Colors.black)));
  }
}
