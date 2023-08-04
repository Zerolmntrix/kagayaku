import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/discover/more_novels/screen.dart';
import '../../screens/discover/screen.dart';
import '../../screens/webview/screen.dart';

abstract class AppRoutes {
  static const discover = '/';
  static const library = '/library';
  static const updates = '/updates';
  static const history = '/history';
  static const more = '/more';
  static const webview = '/webview';

  // * Sub routes
  static const moreNovels = '/discover/more-novels/:list';
}

abstract class AppRouter {
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey();

  static final config = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.discover,
    routes: [
      // * Main routes
      _goRoute(AppRoutes.discover, const DiscoverScreen()),

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
