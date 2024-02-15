import 'package:flutter/material.dart';

///2023.09.10
///アプリテーマ設定
///
///@author
///S.Yamamoto
///
class AppTheme {
  static const Color seedColor = Color.fromRGBO(234, 0, 47, 1);
  static const Color seedColorB = Color.fromRGBO(10, 10, 10, 1);

  static ThemeData lightTheme(ColorScheme? lightDynamicScheme) {
    final scheme =
        lightDynamicScheme ?? ColorScheme.fromSeed(seedColor: seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'PottaOne',
    );
  }

  static ThemeData darkTheme(ColorScheme? darkDynamicScheme) {
    final scheme = darkDynamicScheme ?? const ColorScheme.dark();
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'PottaOne',
    );
  }
}
