import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/toolbar.dart';
import '../../../utils/ios_dialog.dart';
import '../../../utils/snackbar.dart';
import '../provider/provider.dart';

enum MenuOptions { refresh, share, openInBrowser }

class WebViewToolbar implements Toolbar {
  const WebViewToolbar(this.title, this.webViewController);

  final InAppWebViewController? webViewController;

  @override
  final String title;

  @override
  AppBar android() {
    return AppBar(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16.0),
      ),
      actions: const [
        NavigationControls(),
        MoreOptionsMenu(),
      ],
    );
  }

  @override
  CupertinoNavigationBar ios() {
    return CupertinoNavigationBar(
      middle: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: CupertinoButton(
        onPressed: () => webViewController?.reload(),
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.refresh_thick),
      ),
    );
  }
}

class NavigationControls extends ConsumerStatefulWidget {
  const NavigationControls({super.key});

  @override
  ConsumerState<NavigationControls> createState() => _NavigationControlsState();
}

class _NavigationControlsState extends ConsumerState<NavigationControls> {
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(webViewProvider);

    canGoBack() async {
      final canGoBack = await controller?.canGoBack();
      setState(() => this.canGoBack = canGoBack ?? false);
    }

    canGoForward() async {
      final canGoForward = await controller?.canGoForward();
      setState(() => this.canGoForward = canGoForward ?? false);
    }

    canGoBack();
    canGoForward();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: this.canGoBack ? () => controller?.goBack() : null,
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 24,
          ),
          onPressed: this.canGoForward ? () => controller?.goForward() : null,
        ),
      ],
    );
  }
}

class MoreOptionsMenu extends ConsumerWidget {
  const MoreOptionsMenu({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.read(webViewProvider.notifier);

    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.refresh:
            notifier.refresh();
            break;
          case MenuOptions.share:
            notifier.share();
            break;
          case MenuOptions.openInBrowser:
            notifier.openInBrowser();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.refresh,
          child: Text('Refresh'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.share,
          child: Text('Share'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.openInBrowser,
          child: Text('Open in browser'),
        ),
      ],
    );
  }
}

class BottomWebViewToolbar extends ConsumerStatefulWidget {
  const BottomWebViewToolbar({super.key});

  @override
  ConsumerState<BottomWebViewToolbar> createState() =>
      _BottomWebViewToolbarState();
}

class _BottomWebViewToolbarState extends ConsumerState<BottomWebViewToolbar> {
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(webViewProvider.notifier);
    final controller = ref.watch(webViewProvider);

    canGoBack() async {
      final canGoBack = await controller?.canGoBack();
      setState(() => this.canGoBack = canGoBack ?? false);
    }

    canGoForward() async {
      final canGoForward = await controller?.canGoForward();
      setState(() => this.canGoForward = canGoForward ?? false);
    }

    canGoBack();
    canGoForward();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: this.canGoBack ? () => notifier.goBack() : null,
            child: const Icon(CupertinoIcons.back),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: this.canGoForward ? () => notifier.goForward() : null,
            child: const Icon(CupertinoIcons.forward),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => notifier.share(),
            child: const Icon(CupertinoIcons.share),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              try {
                await notifier.openInBrowser();
              } catch (e) {
                if (context.mounted) showBrowserMessage(context);
              }
            },
            child: const Icon(CupertinoIcons.compass),
          ),
        ],
      ),
    );
  }
}

showBrowserMessage(BuildContext context) {
  !Platform.isIOS
      ? showIOSDialog(context, 'Open in Browser', 'Failed to open in browser.')
      : showSnackBar(context, 'Failed to open in browser.');
}
