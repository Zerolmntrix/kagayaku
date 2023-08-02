import 'package:flutter/material.dart';

import '../../../shared/widgets/toolbar.dart';

class DiscoverToolbar extends StatelessWidget with Toolbar {
  const DiscoverToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Discover'),
      actions: const [],
    );
  }
}
