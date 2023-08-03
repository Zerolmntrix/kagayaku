import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/routes.dart';
import '../provider/provider.dart';

class MoreButton extends ConsumerWidget {
  const MoreButton(this.list, {super.key});

  final String list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    const buttonText = 'More';

    final isLoading = ref.watch(discoverProvider.select((v) => v.isLoading));

    final onPressed = isLoading
        ? null
        : () => context.push(AppRoutes.moreNovels, extra: list.trim());

    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: SizedBox(
          height: 25,
          width: 50,
          child: CupertinoButton(
            onPressed: onPressed,
            pressedOpacity: 0.7,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50),
            color: colorScheme.primaryContainer,
            child: Text(
              buttonText.toUpperCase(),
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
              ),
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
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
