import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../shared/theme/styles.dart';
import '../../shared/widgets/scaffold.dart';
import 'provider/provider.dart';
import 'widgets/toolbar.dart';

class WebViewScreen extends ConsumerStatefulWidget {
  const WebViewScreen(this.url, {super.key});

  final String url;

  @override
  ConsumerState<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends ConsumerState<WebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  String title = 'Kagayaku';

  bool isLoading = true;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(webViewProvider);
    final colorScheme = Theme.of(context).colorScheme;

    buildWebView() {
      return [
        if (isLoading)
          LinearPercentIndicator(
            lineHeight: 4,
            percent: progress,
            animation: true,
            animateFromLastPercent: true,
            animationDuration: animationDuration.inMilliseconds,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            backgroundColor: colorScheme.onSurface.withOpacity(0.2),
            progressColor: colorScheme.secondary,
          ),
        Expanded(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              ref.read(webViewProvider.notifier).setController(controller);
            },
            onLoadStart: (controller, url) {
              setState(() => isLoading = true);
              _getPageTitle();
            },
            onProgressChanged: (controller, progress) {
              setState(() => this.progress = progress / 100);
            },
            onLoadStop: (controller, url) {
              setState(() => isLoading = false);
              _getPageTitle();
            },
          ),
        )
      ];
    }

    return AppScaffold(
      toolbar: WebViewToolbar(title, controller),
      body: Column(
        children: buildWebView(),
      ),
      iOS: Column(
        children: [
          ...buildWebView(),
          const BottomWebViewToolbar(),
        ],
      ),
    );
  }

  _getPageTitle() async {
    final title = await ref.read(webViewProvider)?.getTitle();
    setState(() => this.title = title ?? this.title);
  }
}
