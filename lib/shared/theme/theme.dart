import 'package:flutter/material.dart';

import 'themes.dart';

export 'themes.dart';

class AppTheme {
  const AppTheme(this.mode);

  final ThemeMode mode;

  ThemeData theme(Themes theme) {
    final themeScheme = _getThemeScheme(theme);

    return ThemeData.from(
      useMaterial3: true,
      colorScheme: _getThemeMode(themeScheme),
    ).copyWith(
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  ThemeScheme _getThemeScheme(Themes theme) {
    switch (theme) {
      case Themes.defaultTheme:
        return DefaultScheme();
      default:
        return DefaultScheme();
    }
  }

  ColorScheme _getThemeMode(ThemeScheme theme) {
    if (mode == ThemeMode.light) {
      return theme.light();
    }

    return theme.dark();
  }
}
