import 'dart:async';

import 'package:base_project/components/appbar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebview extends StatelessWidget {
  YoutubeWebview({Key? key}) : super(key: key);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: AppBarBackButton(
            title: 'Youtube',
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: false,
        ),
        body: WebView(
          initialUrl: 'https://m.youtube.com',
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) async {
            final controller = await _controller.future;
            // final String cookies =
            //     await controller.evaluateJavascript('document.cookie');
            // Session.setCookiesFromYtb(cookies);
          },
          gestureNavigationEnabled: true,
          navigationDelegate: (request) async {
            if (request.url.contains('noapp=1')) {
              final controller = await _controller.future;
              controller.loadUrl('https://m.youtube.com');
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        // ignore: deprecated_member_use
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(content: Text(message.message)),
        // );
      },
    );
  }
}
