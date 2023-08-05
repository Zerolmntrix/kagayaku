import 'package:flutter/material.dart';

import '../theme/styles.dart';

class ClickableElement extends StatelessWidget {
  const ClickableElement({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        SizedBox.expand(
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              borderRadius: borderRadius,
              splashColor: colorScheme.secondary.withOpacity(0.3),
              highlightColor: colorScheme.secondary.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}
