import 'package:flutter/material.dart';

class Styling {
  static TextStyle setTextStyle(
      {double? size = 14,
      FontWeight? fontWeight = FontWeight.normal,
      Color? color = Colors.black}) {
    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
