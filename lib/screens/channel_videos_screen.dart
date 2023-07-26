import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/channels_video_notifier.dart';
import 'package:us_rowing/screens/chewei_video_widget.dart';
import 'package:us_rowing/utils/AppAssets.dart';

class ChannelVideosScreen extends StatefulWidget {
  final String? channelID;
  ChannelVideosScreen({Key? key, this.channelID})
      : super(
          key: key,
        );

  @override
  State<ChannelVideosScreen> createState() => _ChannelVideosScreenState();
}

requestPermission() async {
  var status = await Permission.storage.status;
  if (status.isGranted) {
    print('permission already granted');
  } else {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();
    print(statuses[Permission.manageExternalStorage]);
  }
}

class _ChannelVideosScreenState extends State<ChannelVideosScreen> {
  @override
  initState() {
    requestPermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChannelsVideoNotifier>(context, listen: false);
    provider.initializeNotifications();
    return Scaffold(
        body: DefaultTabController(
      length: 3,
      child: NestedScrollView(headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            pinned: true,
            title: Text('Channel Data'),
            bottom: TabBar(tabs: [
              Tab(text: 'Videos'),
              Tab(text: 'Docs'),
              Tab(text: 'Pdfs'),
            ]),
          ),
        ];
      }, body:
          Consumer<ChannelsVideoNotifier>(builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.fetchMessages(widget.channelID!),
            builder: (context, snapshot) {
              return TabBarView(children: [
                getChannelVideos(provider),
                getChannelDocs(provider),
                getChannelPdfs(provider)
              ]);
            });
      })),
    ));
  }

  getChannelVideos(ChannelsVideoNotifier provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: provider.videoFiles.length,
        itemBuilder: (context, index) {
          return ChewieListItem(
              url: provider.videoFiles[index].mp4!,
              title: provider.videoFiles[index]
                  .title!); /* ListTile(
            leading: CachedNetworkImage(
              imageUrl:
                  'https://files.slack.com/files-tmb/T05D22FFEN9-F05FDHQF38F-c01a6388a0/pexels-reynald-ian-de-rueda-16578196__1080p__thumb_video.jpeg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
            ),
            onTap: () async {
             
             
            },
            onLongPress: () {
              Clipboard.setData(
                      ClipboardData(text: provider.videoFiles[index].mp4!))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied to your clipboard !')));
              });
            },
            title: Text(provider.videoFiles[index].name!),
          ); */
        },
      ),
    );
  }

  getChannelPdfs(provider) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: provider.pdfFiles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: ListTile(
            leading: Image.asset(
              imgPDF,
              height: 60,
              width: 60,
            ),
            onLongPress: () {
              Clipboard.setData(
                      ClipboardData(text: provider.pdfFiles[index].urlPrivate))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied to your clipboard !')));
              });
            },
            title: Text(provider.pdfFiles[index].name),
          ),
        );
      },
    );
  }

  getChannelDocs(provider) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: provider.docFiles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListTile(
            leading: Image.asset(
              imgDoc,
              width: 60,
              height: 60,
            ),
            onLongPress: () {
              Clipboard.setData(
                      ClipboardData(text: provider.docFiles[index].urlPrivate))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied to your clipboard !')));
              });
            },
            title: Text(provider.docFiles[index].title),
          ),
        );
      },
    );
  }
}
