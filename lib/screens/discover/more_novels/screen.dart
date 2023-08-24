import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/constants/routes.dart';
import '../../../shared/theme/styles.dart';
import '../../../shared/widgets/novel.dart';
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

    final moduleUrl = ref.read(discoverProvider).module.sourceUrl;
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
        if (context.mounted) {
          showSnackBar(context, 'Failed to load ${title.toLowerCase()}');
        }
      }

      controller.refreshCompleted();
    }

    openWebView() async {
      final browser = ChromeSafariBrowser();

      if (Platform.isAndroid) {
        return context.push(AppRoutes.webview, extra: moduleUrl);
      }

      try {
        await browser.open(url: WebUri(moduleUrl));
      } catch (e) {
        if (context.mounted) context.push(AppRoutes.webview, extra: moduleUrl);
      }
    }

    return AppScaffold(
      toolbar: MoreNovelsToolbar(title),
      body: SmartRefresher(
        controller: controller,
        header: const SmartRefresherHeader(),
        onRefresh: onRefresh,
        child: novels.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EmptyList(),
                  TextButton.icon(
                    icon: Icon(
                      Platform.isAndroid ? Icons.public : CupertinoIcons.globe,
                    ),
                    onPressed: openWebView,
                    label: const Text('WebView'),
                  ),
                ],
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: buildGridDelegate(2),
                itemCount: novels.length,
                itemBuilder: (context, index) {
                  return Novel(
                    cover: novels[index].cover,
                    title: novels[index].title,
                  );
                },
              ),
      ),
    );
  }
}
