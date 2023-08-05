import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/toolbar.dart';

class NovelToolbar implements Toolbar {
  const NovelToolbar(this.title);

  @override
  final String title;

  @override
  AppBar android() {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  CupertinoNavigationBar ios() {
    return CupertinoNavigationBar(
      middle: Text(title),
    );
  }
}
