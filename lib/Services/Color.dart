import 'package:flutter/material.dart';

class NewColor {
  static const MaterialColor mainTheme = MaterialColor(
    _mainThemePrimaryValue,
    <int, Color>{
      50: Color(0xff0E6B56),
      100: Color(0xFFB3B5B8),
      200: Color(0xFF82868A),
      300: Color(0xFF51585E),
      400: Color(0xFF252B31),
      500: Color(_mainThemePrimaryValue),
      600: Color(0xFF00060C),
      700: Color(0xFF00060C),
      800: Color(0xFF00060C),
      900: Color(0xFF00060C),
    },
  );
  static const int _mainThemePrimaryValue = 0xFF0E6B56;
}
