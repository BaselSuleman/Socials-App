import 'package:flutter/material.dart';

class AppMaterialColors {
  static ColorScheme lightScheme = ColorScheme(
    primary: green.shade200,
    secondary: blue.shade100,
    surface: grey.shade300,
    error: red.shade50,
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onError: red.shade50,
    brightness: Brightness.light,
  );
  static ColorScheme darkScheme = ColorScheme(
    primary: blue.shade300,
    secondary: blue.shade100,
    surface: grey.shade300,
    error: red.shade50,
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onError: red.shade50,
    brightness: Brightness.light,
  );
  static const MaterialColor green = MaterialColor(0xFF5EC4BF, <int, Color>{
    25: Color(0xFFD2F5F1),
    50: Color(0xFF5EC4BF),
  });
  static const MaterialColor blue = MaterialColor(0xFF16A3CE, <int, Color>{
    50: Color(0xFFE1F9FF),
    75: Color(0xffdaf5f8),
    100: Color(0xFFA4D6FF),
  });
  static const MaterialColor grey = MaterialColor(0xFFF2F2F2, <int, Color>{
    50: Color(0xFFF4F4F4),
    100: Color(0xFFF2F2F2), // base
    200: Color(0xFFEFF3F5),
    300: Color(0xFFE6E6E6),
    400: Color(0xFFDDDDDD),
    500: Color(0xFFD4D4D4),
    600: Color(0xFFBBBBBB),
    700: Color(0xFFA1A1A1),
    800: Color(0xFF888888),
    900: Color(0xFF6E6E6E),
  });
  static const MaterialColor white = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: Color(0xFFFFFFFF),
    75: Color(0xFFEFF3F5),
    100: Color(0xffdaf5f8),
  });
  static const MaterialColor red = MaterialColor(0xFFFF5959, <int, Color>{
    50: Color(0xFFFF5959),
    100: Color(0xFFFF5955),
  });
  static const MaterialColor brown = MaterialColor(0xFFB54747, <int, Color>{
    50: Color(0xFFEED175),
    100: Color(0xFFF8C097),
    200: Color(0xFFD9A883),
  });
  static const MaterialColor yellow = MaterialColor(0xFFFFBF31, <int, Color>{
    50: Color(0xFFFFBF31),
  });
  static const MaterialColor magenta = MaterialColor(0xFFB44BDB, <int, Color>{
    50: Color(0xFFB44BDB),
  });
  static const MaterialColor pink = MaterialColor(0xFFFFA59B, <int, Color>{
    50: Color(0xFFFFA59B),
    100: Color(0xFFEF8B8B),
    200: Color(0xFFFF6555),
  });
  static const MaterialColor orange = MaterialColor(0xFFF4AA16, <int, Color>{
    50: Color(0xFFF4AA16),
  });
  static const MaterialColor black = MaterialColor(0xFF444444, <int, Color>{
    25: Color(0xFF6E7183),
    50: Color(0xff333A42),
    75: Color(0xff707070),
    100: Color(0xff1F2329),
    200: Color(0xFF000000),
  });

}
