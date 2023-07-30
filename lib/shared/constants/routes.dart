import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/discover/screen.dart';

abstract class AppRoutes {
  static const discover = '/';
  static const library = '/library';
  static const updates = '/updates';
  static const history = '/history';
  static const more = '/more';
}

abstract class AppRouter {
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey();

  static final config = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.discover,
    routes: [
      _goRoute(AppRoutes.discover, const DiscoverScreen()),
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
