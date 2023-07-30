import 'package:flutter/material.dart';

import 'shared/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kagayaku',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.config,
    );
  }
}
