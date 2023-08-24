import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewState extends StateNotifier<InAppWebViewController?> {
  WebViewState(super._state);

  setController(InAppWebViewController controller) => state = controller;

  refresh() => state?.reload();

  share() async {
    final url = await state?.getUrl();
    if (url != null) Share.share(url.toString());
  }

  Future<bool> openInBrowser() async {
    final url = await state?.getUrl();
    if (url == null) return false;
    return launchUrl(
      Uri.parse(url.toString()),
      mode: LaunchMode.externalApplication,
    );
  }

  goBack() => state?.goBack();

  goForward() => state?.goForward();
}

final webViewProvider =
    StateNotifierProvider.autoDispose<WebViewState, InAppWebViewController?>(
  (ref) => WebViewState(null),
);
