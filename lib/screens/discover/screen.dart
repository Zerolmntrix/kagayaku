import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/svgs/svgs.dart';
import '../../shared/widgets/novel.dart';
import '../../shared/widgets/scaffold.dart';
import 'widgets/novel_flex_view.dart';
import 'widgets/spotlight.dart';
import 'widgets/toolbar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  final isEmpty = !true;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const AppScaffold(
        toolbar: DiscoverToolbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyDiscover(height: 250),
              Text('You don\'t have any sources installed yet.'),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      toolbar: const DiscoverToolbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Spotlight(novels: novels),
            NovelFlexView(
              title: 'Latest Novels',
              novels: novels,
              builder: _novelBuilder,
            ),
            const SizedBox(height: 10),
            NovelFlexView(
              title: 'Popular Novels',
              novels: novels,
              builder: _novelBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Novel _novelBuilder(novel) {
    return Novel(
      cover: novel['cover'],
      title: novel['title'],
      unread: 12,
      inkWell: const InkWell(),
    );
  }
}

final novels = [
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
  {
    'cover':
        'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg',
    'title': 'The Beginning After The End',
  },
];
