import 'package:auth_example/core/colors.dart';
import 'package:flutter/material.dart';

class MyStyleText {
  static TextStyle mediumlLine_18([Color color = black]) => TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18,
        fontFamily: 'Poppins',
        color: color,
      );

  static TextStyle mediumlLine_14([Color color = black]) => TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14,
        fontFamily: 'Poppins',
        color: color,
      );

  static TextStyle normalLine_14([Color color = black]) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontFamily: 'Poppins',
        color: color,
      );

  static TextStyle mediumLine_12([Color color = lightBlack]) => TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 12,
        fontFamily: 'Poppins',
        color: color,
      );
  static TextStyle normalLine_12([Color color = lightBlack]) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        fontFamily: 'Poppins',
        color: color,
      );
}
