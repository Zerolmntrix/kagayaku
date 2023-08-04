import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/constants/routes.dart';
import '../../../shared/theme/styles.dart';
import '../../../shared/widgets/novel.dart';
import '../../../shared/widgets/novel_grid_view.dart';
import '../../../shared/widgets/scaffold.dart';
import '../../../utils/snackbar.dart';
import '../provider/provider.dart';
import '../widgets/empty_list.dart';
import 'widgets/toolbar.dart';

class MoreNovelsScreen extends ConsumerWidget {
  const MoreNovelsScreen(this.list, {super.key});

  final String list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = list == 'latest' ? 'Latest Novels' : 'Popular Novels';

    final sourceUrl = ref.read(discoverProvider).sourceData.sourceUrl;
    final novels = list == 'latest'
        ? ref.watch(discoverProvider).latestNovels
        : ref.watch(discoverProvider).popularNovels;
    final controller = RefreshController();

    onRefresh() async {
      try {
        if (list == 'latest') {
          await ref.read(discoverProvider.notifier).setLatestNovels();
        }
        if (list == 'popular') {
          await ref.read(discoverProvider.notifier).setPopularNovels();
        }
      } catch (e) {
        showSnackBar(context, 'Failed to load ${title.toLowerCase()}');
      }

      controller.refreshCompleted();
    }

    return AppScaffold(
      toolbar: MoreNovelsToolbar(title),
      body: SmartRefresher(
        controller: controller,
        header: const SmartRefresherHeader(),
        onRefresh: onRefresh,
        child: Center(
          child: SingleChildScrollView(
            child: novels.isEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const EmptyList(),
                      TextButton.icon(
                        icon: Icon(
                          Platform.isAndroid
                              ? Icons.public
                              : CupertinoIcons.globe,
                        ),
                        onPressed: () => context.push(
                          AppRoutes.webview,
                          extra: sourceUrl,
                        ),
                        label: const Text('WebView'),
                      ),
                    ],
                  )
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
      ),
    );
  }
}
