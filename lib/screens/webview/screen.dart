import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String title = 'Kagayaku';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    ref.read(webViewProvider)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            _getPageTitle();
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            _getPageTitle();
            setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(webViewProvider);

    return AppScaffold(
      toolbar: WebViewToolbar(title, controller),
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(minHeight: 4),
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
      iOS: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(minHeight: 4),
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
          const BottomWebViewToolbar(),
        ],
      ),
    );
  }

  _getPageTitle() async {
    final title = await ref.read(webViewProvider).getTitle();
    setState(() => this.title = title ?? this.title);
  }
}
