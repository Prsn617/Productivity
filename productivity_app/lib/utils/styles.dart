import 'package:flutter/material.dart';

Color primary = const Color(0xFFE75223);

class Styles {
  static Color mainColor = primary;
  static Color textColor = const Color(0xFF3B3B3B);
  static Color bgColor = Colors.white;
  static Color blueColor = const Color(0xFF005DAA);
  static Color greenColor = const Color(0xFF6CB50D);
  static TextStyle h0 =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w400);
  static TextStyle h1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle h2 =
      TextStyle(fontSize: 21, color: textColor, fontWeight: FontWeight.bold);
  static TextStyle h3 =
      TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle h4 =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);
  static TextStyle h5 = TextStyle(
      fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500);
  static TextStyle h6 =
      TextStyle(fontSize: 15, color: textColor, fontWeight: FontWeight.w400);
}
