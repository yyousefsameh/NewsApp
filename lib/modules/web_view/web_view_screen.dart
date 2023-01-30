import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  late final WebViewController webcontroller = WebViewController()
    ..loadRequest(
      Uri.parse(url),
    );
  final String url;
  WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: webcontroller,
      ),
    );
  }
}
