import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'toolbar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.toolbar, required this.body, this.iOS});

  final Toolbar? toolbar;
  final Widget body;
  final Widget? iOS;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: toolbar?.ios(),
        child: Scaffold(
          body: SafeArea(child: iOS != null ? iOS! : body),
        ),
      );
    }
    return Scaffold(
      appBar: toolbar?.android(),
      body: body,
    );
  }
}
