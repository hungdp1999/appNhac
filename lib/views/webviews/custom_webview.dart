import 'package:base_project/components/appbar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebview extends StatelessWidget {
  final String? title;
  final String? url;

  const CustomWebview({
    super.key,
    this.title,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: AppBarBackButton(
            title: title ?? '',
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: false,
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) async {
            // final controller = await _controller.future;
            // final String cookies =
            //     await controller.evaluateJavascript('document.cookie');
            // Session.setCookiesFromYtb(cookies);
          },
          gestureNavigationEnabled: true,
          // navigationDelegate: (request) async {
          //   // if (request.url.contains('noapp=1')) {
          //   //   final controller = await _controller.future;
          //   //   controller.loadUrl('https://m.youtube.com');
          //   //   return NavigationDecision.prevent;
          //   // } else {
          //   //   return NavigationDecision.navigate;
          //   // }
          // },
          // onWebViewCreated: (WebViewController webViewController) {
          //   // _controller.complete(webViewController);
          // },
          // javascriptChannels: <JavascriptChannel>[
          //   // _toasterJavascriptChannel(context),
          // ].toSet(),
        ),
      ),
    );
  }
}
