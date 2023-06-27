import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/slack_notifier.dart';

class SlackScreen extends StatelessWidget {
  const SlackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SlackNotifier>(context, listen: false);

    provider.getSlackMessages();
    return Scaffold(
        appBar: AppBar(
          /* actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    openSlackApp();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  splashRadius: 20.0,
                ),
              ],
            )
          ], */
          title: const Text('Slack Screen'),
        ),
        body: Consumer<SlackNotifier>(
          builder: (context, data, child) {
            if (data.channelsList.isEmpty) {
              return Center(
                child:
                    CircularProgressIndicator(), // Display a loading indicator while data is being loaded
              );
            } else {
              return ListView.builder(
                itemCount: data.channelsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.channelsList[index].name),
                    onTap: () {
                      data.openSlackApp(data.channelsList[index].id);
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
