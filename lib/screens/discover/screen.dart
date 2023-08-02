import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/source_data.dart';
import '../../shared/constants/endpoints.dart';
import '../../shared/svgs/svgs.dart';
import '../../shared/theme/styles.dart';
import '../../shared/widgets/novel.dart';
import '../../shared/widgets/scaffold.dart';
import '../../utils/snackbar.dart';
import 'widgets/novel_flex_view.dart';
import 'widgets/spotlight.dart';
import 'widgets/toolbar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late final RefreshController _controller;
  SourceData? sourceData;
  bool isLoading = true;

  final isEmpty = !true;
  final List<NovelModel> spotlightNovels = [];
  final List<NovelModel> popularNovels = [];
  final List<NovelModel> latestNovels = [];

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
              Text('You don\'t have any sources installed yet.'),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      toolbar: const DiscoverToolbar(),
      body: SmartRefresher(
        controller: _controller,
        header: const SmartRefresherHeader(),
        onRefresh: _loadModuleData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Spotlight(novels: spotlightNovels),
              NovelFlexView(
                isLoading: isLoading,
                title: 'Latest Updates',
                novels: latestNovels,
                builder: _novelBuilder,
              ),
              const SizedBox(height: 10),
              NovelFlexView(
                isLoading: isLoading,
                title: 'Popular Novels',
                novels: popularNovels,
                builder: _novelBuilder,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Novel _novelBuilder(NovelModel novel) {
    return Novel(
      cover: novel.cover,
      title: novel.title,
      inkWell: const InkWell(),
    );
  }

  _loadModuleData() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _controller.refreshFailed();
      _showMessage('No internet connection');
      setState(() => isLoading = false);
      return;
    }

    final response = await http.get(Uri.parse(Endpoints.test));

    final kayaContent = response.body.split('\n').map((e) => e.trim()).toList();

    sourceData ??= SourceData(kayaContent);

    final spotlightNovels = await sourceData!.getSpotlightNovels();
    final latestNovels = await sourceData!.getLatestNovels();
    final popularNovels = await sourceData!.getPopularNovels();

    final endLatestList = latestNovels.length >= 6 ? 6 : latestNovels.length;
    final endPopularList = popularNovels.length >= 6 ? 6 : popularNovels.length;
    final endSpotlightList = latestNovels.length >= 5 ? 5 : latestNovels.length;

    setState(() {
      this.spotlightNovels.addAll(spotlightNovels.sublist(0, endSpotlightList));
      this.latestNovels.addAll(latestNovels.sublist(0, endLatestList));
      this.popularNovels.addAll(popularNovels.sublist(0, endPopularList));
      isLoading = false;
    });

    _controller.refreshCompleted();
  }

  _showMessage(String message) => showSnackBar(context, message);
}
