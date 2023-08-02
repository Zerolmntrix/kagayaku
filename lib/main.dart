import 'package:flutter/material.dart';

import 'shared/constants/routes.dart';
import 'shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedTheme = Themes.defaultTheme;

    return MaterialApp.router(
      title: 'Kagayaku',
      theme: const AppTheme(ThemeMode.light).theme(selectedTheme),
      darkTheme: const AppTheme(ThemeMode.dark).theme(selectedTheme),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.config,
    );
  }
}
