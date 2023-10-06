import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/toolbar.dart';

class BrowseToolbar implements Toolbar {
  const BrowseToolbar();

  @override
  final title = 'Browse';

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
