import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/toolbar.dart';

class DiscoverToolbar implements Toolbar {
  const DiscoverToolbar();

  @override
  final title = 'Discover';

  @override
  AppBar android() {
    return AppBar(
      title: Text(title),
      actions: const [],
    );
  }

  @override
  CupertinoNavigationBar ios() {
    return CupertinoNavigationBar(
      middle: Text(title),
    );
  }
}
