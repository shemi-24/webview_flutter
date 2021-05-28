import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  WebViewController _controller;

  // String filePath = 'assets/payment.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Webview Demo')),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     _webViewController.evaluateJavascript('add(10, 10)');
      //   },
      // ),
    );
  }

  _loadHtmlFromAssets() async {
    // String fileText = await rootBundle.loadString(
    //     '<html> <meta name="viewport" content="width=device-width, initial-scale=1" /> <script id="context" type="text/javascript"src="https://sandbox-payments.open.money/layer"></script> <script id="context" type="text/javascript"src="https://payments.open.money/layer"></script><body> <script>Layer.checkout({token: "payment_token",accesskey: "access_key"},function(response) {if (response.status == "captured") {} else if (response.status == "created") {} else if (response.status == "pending") {} else if (response.status == "failed") {} else if (response.status == "cancelled") {}},function(err) {});</script></body></html>');

    _controller.loadUrl(Uri.dataFromString(
        '<html> <meta name="viewport" content="width=device-width, initial-scale=1" /> <script id="context" type="text/javascript"src="https://sandbox-payments.open.money/layer"></script> <script id="context" type="text/javascript"src="https://payments.open.money/layer"></script><body> <script>Layer.checkout({token: "payment_token",accesskey: "access_key"},function(response) {if (response.status == "captured") {} else if (response.status == "created") {} else if (response.status == "pending") {} else if (response.status == "failed") {} else if (response.status == "cancelled") {}},function(err) {});</script></body></html>',
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}