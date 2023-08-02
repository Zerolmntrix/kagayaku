import 'package:flutter/material.dart';

import '../../../shared/widgets/novel_grid_view.dart';
import 'more_button.dart';

class NovelFlexView extends NovelGridView {
  const NovelFlexView({
    super.key,
    required this.title,
    required super.novels,
    required super.builder,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
        SizedBox(
          height: 200,
          child: ListView.builder(
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
          ),
        ),
      ],
    );
  }
}
