import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/channels_video_notifier.dart';

class ChannelVideosScreen extends StatelessWidget {
  final String? channelID;
  ChannelVideosScreen({Key? key, this.channelID})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChannelsVideoNotifier>(context);

    provider.fetchMessages(channelID!);

    var videosList = getVideos(provider.videoMessages);
   
    // provider.getVideos();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Channel Videos'),
        ),
        body: ListView.builder(
          itemCount: videosList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                Clipboard.setData(
                        ClipboardData(text: videosList[index].thumbVideo))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied to your clipboard !')));
                });
              },
              title: Text(videosList[index].name),
            );
          },
        ) /* FutureBuilder(
          future: provider.fetchMessages(channelID!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error Occured'));
            } else {
              var filesList = provider.videoFiles
                  .where((element) => element.filetype == 'mp4')
                  .toList();
              if (filesList.isEmpty) {
                return Center(
                  child: Text('No data to Display'),
                );
              } else {
                return ListView.builder(
                  itemCount: filesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filesList[index].name),
                    );
                  },
                );
              }
            }
          }), */
        );
  }
}
