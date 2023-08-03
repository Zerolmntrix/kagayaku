import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/theme/styles.dart';
import '../../../shared/widgets/novel.dart';
import '../../../shared/widgets/novel_grid_view.dart';
import '../../../shared/widgets/scaffold.dart';
import '../provider/provider.dart';
import '../widgets/empty_list.dart';
import 'widgets/toolbar.dart';

class MoreNovelsScreen extends ConsumerWidget {
  const MoreNovelsScreen(this.list, {super.key});

  final String list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = list == 'latest' ? 'Latest Novels' : 'Popular Novels';

    final novels = ref.watch(discoverProvider.notifier).getNovels(list);
    final controller = RefreshController();

    onRefresh() {
      if (list == 'latest') {
        ref.read(discoverProvider.notifier).setLatestNovels();
      }
      if (list == 'popular') {
        ref.read(discoverProvider.notifier).setPopularNovels();
      }

      // TODO: Implement error handling

      //   final snackBar = SnackBar(
      //     content: const Text('No new novels found.'),
      //     action: SnackBarAction(
      //       label: 'RETRY',
      //       onPressed: () {
      //
      //       },
      //     ),
      //   );

      controller.refreshCompleted();
    }

    return AppScaffold(
      toolbar: MoreNovelsToolbar(title),
      body: SmartRefresher(
        controller: controller,
        header: const SmartRefresherHeader(),
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: novels.isEmpty
              ? const EmptyList()
              : NovelGridView(
                  novels: novels,
                  builder: (novel) {
                    return Novel(
                      title: novel.title,
                      cover: novel.cover,
                      inkWell: const InkWell(),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
