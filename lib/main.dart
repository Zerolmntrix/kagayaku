import 'package:flutter/material.dart';

import 'shared/constants/routes.dart';
import 'shared/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kagayaku',
      theme: DefaultTheme(Brightness.light).themeData,
      darkTheme: DefaultTheme(Brightness.dark).themeData,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.config,
    );
  }
}
