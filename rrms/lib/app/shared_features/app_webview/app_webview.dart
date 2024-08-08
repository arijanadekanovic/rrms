import 'package:rrms/_all.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String url;

  /// return true to follow the link
  /// return false to intercept the link
  final bool Function(String url)? onLinkClick;

  const AppWebView({
    super.key,
    required this.url,
    this.onLinkClick,
  });

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {},
          // onPageStarted: (String url) {},
          // onPageFinished: (String url) {},
          // onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) => (widget.onLinkClick?.call(request.url) ?? true) ? NavigationDecision.navigate : NavigationDecision.prevent,
        ),
      )
      ..loadRequest(Uri.parse(widget.url.value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
