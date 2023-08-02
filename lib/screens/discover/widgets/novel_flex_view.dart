import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/novel_grid_view.dart';
import 'more_button.dart';

class NovelFlexView extends NovelGridView {
  const NovelFlexView({
    super.key,
    required this.title,
    required this.isLoading,
    required super.novels,
    required super.builder,
  });

  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const MoreButton(),
            ],
          ),
        ),
        const SizedBox(height: 4),
        if (isLoading)
          SizedBox(
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
          ),
        if (!isLoading)
          SizedBox(
            height: 200,
            child: novels.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemCount: novels.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: builder(novels[index]),
                      );
                    },
                  )
                : Center(
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
                  ),
          ),
      ],
    );
  }
}
