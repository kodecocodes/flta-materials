import 'package:flutter/material.dart';
import '../models/models.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
        name: FooderlichPages.raywenderlich,
        key: ValueKey(FooderlichPages.raywenderlich),
        child: const WebviewScreen());
  }
  
  const WebviewScreen({Key key}) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebviewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('raywenderlich.com'),),
      body: const WebView(
        initialUrl: 'https://www.raywenderlich.com/',
      ),
    );
  }
}
