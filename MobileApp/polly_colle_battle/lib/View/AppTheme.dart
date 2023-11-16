import 'package:flutter/material.dart';

///2023.09.10
///アプリテーマ設定
///
///@author
///S.Yamamoto
///
class AppTheme {
  static const Color seedColor = Color.fromRGBO(237, 222, 208, 1);

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
    final scheme =
        darkDynamicScheme ?? ColorScheme.fromSeed(seedColor: seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'PottaOne',
    );
  }
}
