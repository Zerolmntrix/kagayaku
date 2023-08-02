import 'package:flutter/material.dart';

import 'themes.dart';

export 'themes.dart';

class AppTheme {
  const AppTheme(this.mode);

  final ThemeMode mode;

  ThemeData theme(Themes theme) {
    final colorScheme = _getColorScheme(theme);

    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
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
