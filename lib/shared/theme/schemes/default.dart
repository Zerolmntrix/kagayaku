import 'package:flutter/material.dart';

import '../styles.dart';

class DefaultTheme {
  DefaultTheme(Brightness theme) {
    if (theme == Brightness.light) {
      _theme = _light;
    } else {
      _theme = _dark;
    }
  }

  late ColorScheme _theme;

  final ColorScheme _light = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE9DDFF),
    onPrimaryContainer: Color(0xFF22005D),
    secondary: Color(0xFF814698),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFF9D8FF),
    onSecondaryContainer: Color(0xFF320046),
    tertiary: Color(0xFF9A405A),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD9E0),
    onTertiaryContainer: Color(0xFF3F0019),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF8FDFF),
    onBackground: Color(0xFF001F25),
    surface: Color(0xFFF8FDFF),
    onSurface: Color(0xFF001F25),
    surfaceVariant: Color(0xFFE7E0EB),
    onSurfaceVariant: Color(0xFF49454E),
    outline: Color(0xFF7A757F),
    onInverseSurface: Color(0xFFD6F6FF),
    inverseSurface: Color(0xFF00363F),
    inversePrimary: Color(0xFFCFBCFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF6750A4),
    outlineVariant: Color(0xFFCAC4CF),
    scrim: Color(0xFF000000),
  );
  final ColorScheme _dark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFCFBCFF),
    onPrimary: Color(0xFF381E72),
    primaryContainer: Color(0xFF4F378A),
    onPrimaryContainer: Color(0xFFE9DDFF),
    secondary: Color(0xFFECB1FF),
    onSecondary: Color(0xFF4E1266),
    secondaryContainer: Color(0xFF672D7E),
    onSecondaryContainer: Color(0xFFF9D8FF),
    tertiary: Color(0xFFFFB1C3),
    onTertiary: Color(0xFF5E112D),
    tertiaryContainer: Color(0xFF7C2943),
    onTertiaryContainer: Color(0xFFFFD9E0),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF001F25),
    onBackground: Color(0xFFA6EEFF),
    surface: Color(0xFF001F25),
    onSurface: Color(0xFFA6EEFF),
    surfaceVariant: Color(0xFF49454E),
    onSurfaceVariant: Color(0xFFCAC4CF),
    outline: Color(0xFF948F99),
    onInverseSurface: Color(0xFF001F25),
    inverseSurface: Color(0xFFA6EEFF),
    inversePrimary: Color(0xFF6750A4),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFCFBCFF),
    outlineVariant: Color(0xFF49454E),
    scrim: Color(0xFF000000),
  );

  ThemeData get themeData => sharedTheme.copyWith(colorScheme: _theme);
}
