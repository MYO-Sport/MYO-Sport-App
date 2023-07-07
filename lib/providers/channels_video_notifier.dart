import 'package:flutter/material.dart';
import 'package:us_rowing/models/slack/channel_videos_model.dart';
import 'package:http/http.dart' as http;

class ChannelsVideoNotifier extends ChangeNotifier {
  List<Message> videoMessages = [];
  List<FileElement> videoFiles = [];

  fetchMessages(String channelID) async {
    var token =
        'xoxp-5444083524757-5447059404530-5488219679908-0ed11ae477ff4c3760f725a7c2d6537f';
    var url = 'https://slack.com/api/conversations.history?channel=$channelID';

    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        var data = channelVideosModelFromJson(response.body);
        // debugPrint(data.messages.toString());
        videoMessages = data.messages;
        notifyListeners();
        // videoMessages = data.messages;
        /* for (int i = 0; i < data.messages.length; i++) {
          data.messages[i].files!.forEach((element) {
            if (!videoFiles.contains(element)) {
              videoFiles.add(element);
            }
          });
          /*  if (videoMessages[i].files!.isEmpty ||
            videoFiles.any((element) => videoFiles.forEach(FileElement file : videoMessages[i].files))) {
          return;
        } else {
          videoFiles.addAll(videoMessages[i].files!.toList());
        } */
        } */

        break;
      default:
        print(response.body);
        print('Error fetching messages');
    }
  }
}

List<FileElement> getVideos(List<Message> messagesList) {
  List<FileElement> videoFiles = [];
  messagesList.forEach((element) {
    element.files!.forEach((element) {
      if (!videoFiles.contains(element) || videoFiles.isEmpty) {
        videoFiles.add(element);
      }
    });
  });
  var files = videoFiles.where((element) => element.filetype == 'mp4').toList();
  return files;
}
       /*  data.messages.forEach((element) {
          element.files!.forEach((element) {
            if (!videoFiles.contains(element)) {
              videoFiles.add(element);
            }
          });
        }); */
 /*  getVideos() {
    for (int i = 0; i < videoMessages.length; i++) {
      videoMessages[i].files!.forEach((element) {
        if (!videoFiles.contains(element)) {
          videoFiles.add(element);
        } else {
          return;
        }
      });
      /*  if (videoMessages[i].files!.isEmpty ||
            videoFiles.any((element) => videoFiles.forEach(FileElement file : videoMessages[i].files))) {
          return;
        } else {
          videoFiles.addAll(videoMessages[i].files!.toList());
        } */

      notifyListeners();
    }
  }
} */
