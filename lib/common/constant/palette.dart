import 'package:flutter/material.dart';

class Palette {
  static const primary = Color(0xFF3B3C53);
  static const accent = Color(0xFFF13737);
  static const text = Color(0xFF626368);

  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFF3B3C53, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFE7E8EA),
      100: Color(0xFFC4C5CB),
      200: Color(0xFF9D9EA9),
      300: Color(0xFF767787),
      400: Color(0xFF58596D),
      500: Color(0xFF3B3C53),
      600: Color(0xFF35364C),
      700: Color(0xFF2D2E42),
      800: Color(0xFF262739),
      900: Color(0xFF191A29),
    },
  );
}
