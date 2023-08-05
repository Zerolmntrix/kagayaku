import 'package:flutter/material.dart';

class NovelChapter extends StatelessWidget {
  final String name;

  const NovelChapter({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '5/25/23',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_for_offline_outlined),
          ),
        ],
      ),
    );
  }
}
