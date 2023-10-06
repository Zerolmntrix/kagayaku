import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navbar.dart';
import 'toolbar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.toolbar,
    this.navbar,
    required this.body,
    this.iOS,
  });

  final Toolbar? toolbar;
  final NavBar? navbar;
  final Widget body;
  final Widget? iOS;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: toolbar?.ios(),
        child: Scaffold(
          body: SafeArea(child: iOS != null ? iOS! : body),
          bottomNavigationBar: navbar?.ios(),
        ),
      );
    }
    return Scaffold(
      appBar: toolbar?.android(),
      body: body,
      bottomNavigationBar: navbar?.android(),
    );
  }
}
