import 'package:flutter/material.dart';

import 'themes.dart';

export 'themes.dart';

class AppTheme {
  const AppTheme(this.mode);

  final ThemeMode mode;

  ThemeData theme(Themes theme) {
    final colorScheme = _getColorScheme(theme);

    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
    ).copyWith(
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  ColorScheme _getColorScheme(Themes theme) {
    switch (theme) {
      case Themes.defaultTheme:
        return _getThemeMode(DefaultScheme());
      default:
        return _getThemeMode(DefaultScheme());
    }
  }

  ColorScheme _getThemeMode(ThemeScheme theme) {
    if (mode == ThemeMode.light) {
      return theme.light();
    }

    return theme.dark();
  }
}
