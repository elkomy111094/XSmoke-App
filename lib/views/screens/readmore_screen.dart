import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadMoreScreen extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "WiKi",
            style: TextStyle(fontFamily: "Patu", letterSpacing: 1),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: WebView(
          initialUrl: "https://ar.wikipedia.org/wiki/تدخين",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
