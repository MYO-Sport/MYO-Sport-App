import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/slack/slack_channel_reponse.dart';
import 'package:http/http.dart' as http;

class ChannelNotifier extends ChangeNotifier {
  List<Channel> channelsList = [];
  List<Channel> get getChannelsList => this.channelsList;

  set setChannelsList(List<Channel> channelsList) =>
      this.channelsList = channelsList;

  /* Future<List<Channel>?> */ getSlackChannels() async {
    const String slackToken =
        'xoxp-5444083524757-5447059404530-5488219679908-0ed11ae477ff4c3760f725a7c2d6537f';
    // const String slackToken =
    //     'xoxb-5444083524757-5485781785122-uuychi4rhaQZF4GiC1c8VEZ3';
    // final String channelID = 'YOUR_CHANNEL_ID';
    // const String apiUrl =
    //     'https://slack.com/api/conversations.list?types=public_channel,private_channel';
    const String apiUrl =
        'https://slack.com/api/conversations.list?types=public_channel';

    final response = await http.get(Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $slackToken'});
    // print(response.body);
    switch (response.statusCode) {
      case 200:
        final jsonData = slackChannelsModelFromJson(response.body);

        channelsList = jsonData.channels;

        notifyListeners();
        break;
      default:
        // print(response.body);
        print("ERROR OCCURED");
        break;
    }

    // if (response.statusCode == 200) {
    //   final jsonData = slackChannelsModelsFromJson(response.body);

    //   debugPrint(jsonData.toJson().toString());

    //   channelsList = jsonData.channels;
    //   notifyListeners();
    // } else {
    //   print("ERROR");
    // }
  }

  void openSlackApp(String channelName) async {
    final url = 'slack://channel?team={T05D22FFEN9}&id=$channelName';
    const playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.Slack';

    if (await launchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      if (await launchUrl(Uri.parse(playStoreUrl))) {
        await launchUrlString(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    }
  }
}
