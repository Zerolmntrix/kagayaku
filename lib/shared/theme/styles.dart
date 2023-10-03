import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const animationDuration = Duration(milliseconds: 300);
const longAnimationDuration = Duration(seconds: 3);

const borderRadius = BorderRadius.all(Radius.circular(10));
const textShadow = [
  Shadow(
    color: Colors.black,
    offset: Offset(1, 2),
    blurRadius: 2,
  ),
];

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

SliverGridDelegateWithFixedCrossAxisCount buildGridDelegate(
  int crossAxisCount,
) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: crossAxisCount,
    childAspectRatio: 0.7,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );
}
