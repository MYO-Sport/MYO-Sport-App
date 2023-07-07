import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/channel_notifier.dart';
import 'package:us_rowing/screens/channel_videos_screen.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChannelNotifier>(context, listen: false);
    // provider.getSlackMessages();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Channels'),
      ),
      body: FutureBuilder(
          future: provider.getSlackChannels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error Occured'));
            } else {
              return ListView.builder(
                itemCount: provider.getChannelsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: TextButton(
                      child: Text('Open in Slack'),
                      onPressed: () {
                        provider.openSlackApp(provider.channelsList[index].id);
                      },
                    ),
                    title: Text(provider.channelsList[index].name),
                    onTap: () {
                      moveToNextScreen(
                          context, provider.channelsList[index].id);
                    },
                  );
                },
              );
            }
          }),
    );
  }

  moveToNextScreen(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChannelVideosScreen(
                  channelID: id,
                )));
  }
}
