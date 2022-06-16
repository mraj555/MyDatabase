import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({Key? key}) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {


  WebViewController? _viewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBack,
        child: Scaffold(
          body: WebView(
            initialUrl: 'https://www.cryptolivehub.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) {
                _viewController = webViewController;
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _onBack() async{
    var value = await _viewController!.canGoBack();
    if(value) {
      _viewController!.goBack();
      return false;
    }
    else {
      return true;
    }
  }
}
