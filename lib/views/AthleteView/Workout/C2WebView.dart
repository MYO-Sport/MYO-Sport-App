import 'dart:io';

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class C2WebView extends StatefulWidget {
  final String userId;

  C2WebView({required this.userId});

  @override
  State<StatefulWidget> createState() => _C2WebViewState();
}

class _C2WebViewState extends State<C2WebView> {
  bool isLoading = true;
  String reqAuth = "";
  final scopes =
      "read,read_all,profile%3Aread_all,profile%3Aread_all,activity%3Awrite,activity%3Aread_all";

  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // reqAuth = "https://www.strava.com/oauth/authorize?client_id=74665&redirect_uri=http%3A%2F%2F192.168.2.124:3001%2Fapi%2Fworkout%2Fv1%2Fauthenticate%2Fstrava%2F${widget.userId}&response_type=code&scope=read&scope=read_all&scope=profile%3Aread_all&scope=activity%3Awrite&scope=activity%3Aread_all";
    reqAuth = ApiClient.webUrlConcept2;
    print(reqAuth);
    if (Platform.isAndroid)
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
             onPageFinished: (controller) {
              if (mounted) {
                isLoading = false;
                setState(() {});
              }
            },
            onNavigationRequest: (NavigationRequest request) {
              print(request.url);
              if (request.url.startsWith("http://api.myosport.co/success")) {
                showToast('Concept2 is added successfully');
                Navigator.of(context).pop(true);
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(reqAuth));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SimpleToolbar(
        title: "Concept 2",
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
           /*  initialUrl: reqAuth,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (controller) {},
            onPageFinished: (controller) {
              if (mounted) {
                isLoading = false;
                setState(() {});
              }
            },
            navigationDelegate: (NavigationRequest request) {
              print(request.url);
              if (request.url.startsWith("http://api.myosport.co/success")) {
                showToast('Concept2 is added successfully');
                Navigator.of(context).pop(true);
              }
              return NavigationDecision.navigate;
            }, */
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
