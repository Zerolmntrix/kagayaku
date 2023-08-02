import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const animationDuration = Duration(milliseconds: 300);

class SmartRefresherHeader extends StatelessWidget {
  const SmartRefresherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MaterialClassicHeader(
      backgroundColor: colorScheme.inverseSurface,
      color: colorScheme.onInverseSurface,
    );
  }
}
