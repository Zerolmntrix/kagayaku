import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../shared/theme/styles.dart';
import '../../shared/widgets/clickable_element.dart';
import '../../shared/widgets/scaffold.dart';
import 'provider/provider.dart';
import 'widgets/chapter.dart';
import 'widgets/toolbar.dart';

List chapters = [
  'Chapter 1',
  'Chapter 2',
  'Chapter 3',
  'Chapter 4',
  'Chapter 5',
  'Chapter 6',
  'Chapter 7',
  'Chapter 8',
  'Chapter 9',
  'Chapter 10',
  'Chapter 11',
  'Chapter 12',
  'Chapter 13',
  'Chapter 14',
];

class NovelScreen extends ConsumerStatefulWidget {
  const NovelScreen(this.url, {super.key});

  final String url;

  @override
  ConsumerState<NovelScreen> createState() => _NovelScreenState();
}

class _NovelScreenState extends ConsumerState<NovelScreen> {
  late final RefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final novelProvider = ref.read(novelDetailsProvider);

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      toolbar: const NovelToolbar('Novel'),
      body: SmartRefresher(
        controller: _controller,
        header: const SmartRefresherHeader(),
        onRefresh: loadNovel,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    height: 200,
                    child: ClickableElement(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://i2.wp.com/centralnovel.com/wp-content/uploads/2021/11/The-Beginning-After-The-End-capa.jpg?resize=370,500'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Beginning After The End',
                          style: textTheme.titleLarge,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 4),
                        Text('TurtleMe8', style: textTheme.labelMedium),
                        const Row(
                          children: [
                            Icon(Icons.access_time_outlined, size: 14),
                            SizedBox(width: 2),
                            Text('Ongoing'),
                          ],
                        ),
                        Text('Asura Light Novels (${'en'.toUpperCase()})'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    '''
King Grey has unrivaled strength, wealth, and prestige in a world governed by martial ability. However, solitude lingers closely behind those with great power. Beneath the glamorous exterior of a powerful king lurks the shell of man, devoid of purpose and will. 

Reincarnated into a new world filled with magic and monsters, the king has a second chance to relive his life. Correcting the mistakes of his past will not be his only challenge, however. Underneath the peace and prosperity of the new world is an undercurrent threatening to destroy everything he has worked for, questioning his role and reason for being born again. 
              ''',
                    style: textTheme.bodyMedium,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        '${chapters.length} chapters',
                        textAlign: TextAlign.left,
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Column(
                    children:
                        chapters.map((e) => NovelChapter(name: e)).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loadNovel() {
    ref.read(novelDetailsProvider.notifier).setNovel(widget.url);
  }
}
