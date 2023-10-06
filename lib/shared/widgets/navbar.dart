import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/routes.dart';

class NavBar {
  NavBar(this.context, {required this.route});

  final String route;
  final BuildContext context;

  final _tabs = {0: AppRoutes.discover, 1: AppRoutes.browse};

  NavigationBar android() {
    return NavigationBar(
      onDestinationSelected: (i) => _changeTab(context, index: i),
      selectedIndex: getRouteIndex(_tabs, route) ?? 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore),
          label: 'Discover',
        ),
        NavigationDestination(
          icon: Icon(Icons.language),
          label: 'Browse',
        ),
      ],
    );
  }

  ios() {
    return CupertinoTabBar(
      onTap: (i) => _changeTab(context, index: i),
      currentIndex: getRouteIndex(_tabs, route) ?? 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.compass),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.globe),
          label: 'Browse',
        ),
      ],
    );
  }

  _changeTab(BuildContext context, {required int index}) {
    context.go(_tabs[index]!);
  }

  int? getRouteIndex(Map<int, String> map, String route) {
    for (var entry in map.entries) {
      if (entry.value == route) {
        return entry.key;
      }
    }
    return null;
  }
}
