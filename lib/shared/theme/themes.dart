import 'package:flutter/material.dart';

export 'schemes/default.dart';

enum Themes {
  defaultTheme,
}

abstract class ThemeScheme {
  ColorScheme light();

  ColorScheme dark();
}
