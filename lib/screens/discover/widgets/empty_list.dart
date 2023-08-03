import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';

class EmptyList extends ConsumerWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = ref.watch(discoverProvider.select((v) => v.isLoading));

    if (isLoading) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: colorScheme.primary,
                )
              : CupertinoActivityIndicator(
                  radius: 20,
                  color: colorScheme.primary,
                ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Platform.isAndroid
                ? Icons.error_outline
                : CupertinoIcons.exclamationmark_circle,
            size: 50,
            color: Theme.of(context).colorScheme.outline,
          ),
          Text(
            'No novels found.',
            style: textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
