import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'toolbar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, this.toolbar, required this.body});

  final Toolbar? toolbar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: toolbar?.ios(),
        child: SafeArea(child: body),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: toolbar?.android(),
      body: body,
    );
  }
}
