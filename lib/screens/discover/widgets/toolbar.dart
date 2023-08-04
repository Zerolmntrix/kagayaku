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
      actions: const [
        Icon(Icons.search),
        SizedBox(width: 10),
        Icon(Icons.more_horiz),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  CupertinoNavigationBar ios() {
    return CupertinoNavigationBar(
      leading: const Icon(CupertinoIcons.ellipsis_circle, size: 24),
      middle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(width: 4),
          const Icon(CupertinoIcons.chevron_down, size: 16),
        ],
      ),
      trailing: const Icon(CupertinoIcons.search, size: 24),
    );
  }
}
