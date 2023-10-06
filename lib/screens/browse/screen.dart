import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/constants/routes.dart';
import '../../shared/widgets/navbar.dart';
import '../../shared/widgets/scaffold.dart';
import 'provider/provider.dart';
import 'widgets/modules.dart';
import 'widgets/sources.dart';
import 'widgets/toolbar.dart';

class BrowseScreen extends ConsumerWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(browseProvider.notifier).setSources();

    return AppScaffold(
      toolbar: const BrowseToolbar(),
      navbar: NavBar(context, route: AppRoutes.browse),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(fontWeight: FontWeight.w400),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 2),
              onTap: (index) {
                ref.read(browseProvider.notifier).setPage(index);
              },
              tabs: const [
                Tab(text: 'Sources'),
                Tab(text: 'Modules'),
              ],
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: TabBarView(children: [
                SourcesTab(),
                ModulesTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
