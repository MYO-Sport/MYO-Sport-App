import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/slack_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SlackScreen extends StatefulWidget {
  const SlackScreen({Key? key}) : super(key: key);

  @override
  State<SlackScreen> createState() => _SlackScreenState();
}

class _SlackScreenState extends State<SlackScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SlackNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await provider.controller.canGoBack();

        if (isLastPage) {
          provider.controller.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              provider.progress > 1.0
                  ? LinearProgressIndicator(
                      value: provider.getProgress.toDouble(),
                    )
                  : SizedBox(),
              Expanded(child: WebViewWidget(controller: provider.controller)

                  /* InAppWebView(
                    onWebViewCreated: (controller) {
                      provider.controller = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      provider.progress = progress;
                    },
                    initialUrlRequest: URLRequest(
                      url: Uri.parse("https://www.slack.com"),
                    )), */
                  ),
            ],
          ),
          /*  appBar: AppBar(
              actions: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        provider.openSlackLoginPage();
                      },
                      icon: Icon(
                        Icons.web,
                        color: Colors.white,
                      ),
                      splashRadius: 20.0,
                    ),
                  ],
                )
              ],
              title: const Text('Slack Screen'),
            ),
            body: FutureBuilder(
                future: provider.checkEmailFunc(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error Occured'));
                  } else {
                    if (provider.checkEmail) {
                      return ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChannelScreen()));
                            },
                            title: Text("WorkSpace"),
                          )
                        ],
                      );
                    } else {
                      return Center(child: Text("NO User Found"));
                    }
                  }
                }) */
        ),
      ),
    );
  }
}
