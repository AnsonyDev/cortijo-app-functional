import 'package:flutter/cupertino.dart';

abstract class AppTextStyle {
  static const TextStyle h1Style = TextStyle(
    fontFamily: 'Quiza Pro',
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle h2Style = TextStyle(
    fontFamily: 'Quiza Pro',
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle cardTitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle cardContentStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
  );

  static const TextStyle defaultStyle = TextStyle(
      fontFamily: 'NunitoSans', fontWeight: FontWeight.w400, fontSize: 16);
}
