import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/browse/screen.dart';
import '../../screens/discover/more_novels/screen.dart';
import '../../screens/discover/screen.dart';
import '../../screens/novel/screen.dart';
import '../../screens/webview/screen.dart';

abstract class AppRoutes {
  // * Main routes
  static const discover = '/';
  static const library = '/library';
  static const browse = '/browse';

  static const settings = '/settings';

  static const novel = '/novel';

  // * Sub routes
  static const moreNovels = '/discover/more-novels';

  // * Complementary routes
  static const webview = '/webview';
}

abstract class AppRouter {
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey();

  static final config = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.discover,
    routes: [
      // * Main routes
      _goRoute(AppRoutes.discover, const DiscoverScreen()),
      _goRoute(AppRoutes.browse, const BrowseScreen()),

      GoRoute(
        path: AppRoutes.novel,
        builder: (context, state) => NovelScreen(state.extra!.toString()),
      ),

      // * Sub routes
      GoRoute(
        path: AppRoutes.moreNovels,
        builder: (context, state) => MoreNovelsScreen(state.extra!.toString()),
      ),

      // * Complementary routes
      GoRoute(
        path: AppRoutes.webview,
        builder: (context, state) => WebViewScreen(state.extra!.toString()),
      ),
    ],
  );

  static GoRoute _goRoute(String path, Widget child) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: child);
      },
    );
  }
}
