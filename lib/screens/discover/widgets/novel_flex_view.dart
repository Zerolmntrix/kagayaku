import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/novel.dart';
import '../provider/provider.dart';
import 'empty_list.dart';
import 'more_button.dart';

class NovelFlexView extends ConsumerWidget {
  const NovelFlexView({super.key, required this.title, required this.novels});

  final String title;
  final List novels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final limit = novels.length >= 6 ? 6 : novels.length;

    final isLoading = ref.watch(discoverProvider.select((v) => v.isLoading));

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
              MoreButton(title.split(' ').first.toLowerCase()),
            ],
          ),
        ),
        const SizedBox(height: 4),
        if (isLoading && novels.isEmpty)
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
        if (!isLoading || novels.isNotEmpty)
          SizedBox(
            height: 200,
            child: novels.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemCount: limit,
                    itemBuilder: (context, index) {
                      final novel = novels[index];

                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Novel(
                          cover: novel.cover,
                          title: novel.title,
                        ),
                      );
                    },
                  )
                : const EmptyList(),
          ),
      ],
    );
  }
}
