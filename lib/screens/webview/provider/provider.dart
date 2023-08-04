import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewState extends StateNotifier<WebViewController> {
  WebViewState(super._state);

  refresh() => state.reload();

  share() async {
    final url = await state.currentUrl();
    if (url != null) Share.share(url);
  }

  Future<bool> openInBrowser() async {
    final url = await state.currentUrl();
    if (url == null) return false;
    return launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  goBack() => state.goBack();

  goForward() => state.goForward();
}

final webViewProvider =
    StateNotifierProvider.autoDispose<WebViewState, WebViewController>(
  (ref) => WebViewState(WebViewController()),
);
