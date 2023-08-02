import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    const buttonText = 'More';

    if (!Platform.isIOS) {
      return SizedBox(
        height: 25,
        width: 50,
        child: CupertinoButton(
          onPressed: _onPressed,
          pressedOpacity: 0.7,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(50),
          color: colorScheme.primaryContainer,
          child: Text(
            buttonText.toUpperCase(),
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      );
    }
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: _onPressed,
      child: Text(
        buttonText,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.secondary,
        ),
      ),
    );
  }

  _onPressed() {
    debugPrint('MoreButton pressed');
  }
}
