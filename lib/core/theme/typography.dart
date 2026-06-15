import 'package:flutter/material.dart';

class AppTypography {
  static const String _font = 'MPLUS2';

  static const displayLarge = TextStyle(
    fontFamily: _font,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: Color(0xFFFFFFFF),
  );

  static const displayMedium = TextStyle(
    fontFamily: _font,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: Color(0xFFFFFFFF),
  );

  static const titleLarge = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: Color(0xFFFFFFFF),
  );

  static const titleMedium = TextStyle(
    fontFamily: _font,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: Color(0xFFFFFFFF),
  );

  static const bodyLarge = TextStyle(
    fontFamily: _font,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: Color(0xFFFFFFFF),
  );

  static const bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: Color(0xAAFFFFFF),
  );

  static const caption = TextStyle(
    fontFamily: _font,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: Color(0x66FFFFFF),
  );

  static const amountLarge = TextStyle(
    fontFamily: _font,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: Color(0xFFFF6B6B),
  );

  static const amountSuccess = TextStyle(
    fontFamily: _font,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: Color(0xFF00E5A0),
  );

  static const label = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: Color(0xFFFFFFFF),
  );
}