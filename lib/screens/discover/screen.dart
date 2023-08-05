import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../shared/svgs/svgs.dart';
import '../../shared/theme/styles.dart';
import '../../shared/widgets/scaffold.dart';
import '../../utils/snackbar.dart';
import 'provider/provider.dart';
import 'widgets/novel_flex_view.dart';
import 'widgets/spotlight.dart';
import 'widgets/toolbar.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  late final RefreshController _controller;

  final isEmpty = !true;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              Text('You don\'t have any modules installed yet.'),
            ],
          ),
        ),
      );
    }

    final discoverState = ref.watch(discoverProvider);

    return AppScaffold(
      toolbar: const DiscoverToolbar(),
      body: SmartRefresher(
        controller: _controller,
        header: const SmartRefresherHeader(),
        onRefresh: _loadModuleData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Spotlight(novels: discoverState.spotlightNovels),
              NovelFlexView(
                title: 'Latest Updates',
                novels: discoverState.latestNovels,
              ),
              const SizedBox(height: 10),
              NovelFlexView(
                title: 'Popular Novels',
                novels: discoverState.popularNovels,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadModuleData() async {
    ref.read(discoverProvider.notifier).setUnloaded();

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _showMessage('No internet connection');
      return;
    }

    try {
      await ref.read(discoverProvider.notifier).setSource();
    } catch (e) {
      _showMessage('Failed to load module');
      return;
    }

    try {
      await ref.read(discoverProvider.notifier).setSpotlightNovels();
      await ref.read(discoverProvider.notifier).setLatestNovels();
      await ref.read(discoverProvider.notifier).setPopularNovels();
    } catch (e) {
      _showMessage('Failed to load module data');
      return;
    }

    _controller.refreshCompleted();
    ref.read(discoverProvider.notifier).setLoaded();
  }

  _showMessage(String message) {
    _controller.refreshFailed();
    ref.read(discoverProvider.notifier).setLoaded();
    showSnackBar(context, message, retry: true, function: () {
      _controller.requestRefresh();
    });
  }
}
