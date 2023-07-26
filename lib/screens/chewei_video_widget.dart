import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChewieListItem extends StatefulWidget {
  final String url;
  final String title;

  ChewieListItem({required this.url, required this.title});

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  WebViewController? webController;
  // late ChewieController _chewieController;
  // late VideoPlayerController _controller;

  @override
  void initState() {
    webController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onProgress: (progress) {},
        onPageFinished: (url) {},
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url),
      );
    // _controller = VideoPlayerController.network(widget.url);
    // _chewieController = ChewieController(
    //   videoPlayerController: _controller,
    //   autoPlay: true,
    //   looping: false,
    // );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    // _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: WebViewWidget(controller: webController!)),
          // child: Chewie(controller: _chewieController)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.title),
          ),
        ],
      ),
    );
  }
}
