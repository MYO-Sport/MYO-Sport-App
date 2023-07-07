import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/providers/slack_notifier.dart';
import 'package:us_rowing/screens/channel_screen.dart';

class SlackScreen extends StatelessWidget {
  const SlackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SlackNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
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
            }));
  }
}
