import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:us_rowing/models/slack/channel_messages_response.dart';
import 'package:http/http.dart' as http;

class ChannelsVideoNotifier extends ChangeNotifier {
  List<Files> videoFiles = [];
  List<Files> pdfFiles = [];
  List<Files> docFiles = [];

  bool _downloading = false;
  // double _progressValue = 0.0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool get downloading => _downloading;
  initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  fetchMessages(String channelID) async {
    var token =
        'xoxp-5444083524757-5447059404530-5488219679908-0ed11ae477ff4c3760f725a7c2d6537f';
    var url = 'https://slack.com/api/conversations.history?channel=$channelID';

    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        var data = channelMessagesFromJson(response.body);

        // print(data.toJson());
        // debugPrint(data.messages.toString());
        var multipleFiles = await getVideos(data.messages!);
        videoFiles = multipleFiles.getVideoFiles!;
        docFiles = multipleFiles.getDocsFiles!;
        pdfFiles = multipleFiles.getPdfFiles!;

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

  Future<void> downloadFile(String url) async {
    var response = await http.get(Uri.parse(url));
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/MYO-Sport';
    var file = File(filePath);

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    await file.writeAsBytes(response.bodyBytes).then((value) {
      openDownloadedFile(value.path);
    });
  }

  Future<void> openDownloadedFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    print(result.message);
  }

  /*  Future<void> startDownload(String url) async {
    _downloading = true;
    _progressValue = 0;
    notifyListeners();

    //  String fileUrl = 'https://example.com/file.pdf';
    String fileName = 'file.pdf';

    // var response = await http.get(Uri.parse(fileUrl));
    var request = new http.Request('GET', Uri.parse(url));
    var response = http.Client().send(request);

    var directory = await getApplicationDocumentsDirectory();
    String savePath = '${directory.path}/$fileName';
    File file = File(savePath);
    List<List<int>> chunks = [];
    response.asStream().listen((event) {
      event.stream.listen((value) {
        debugPrint(
            'downloadPercentage: ${_progressValue / event.contentLength! * 100}');
        chunks.add(value);
        _progressValue += chunks.length;
      }, onDone: () async {
        final Uint8List bytes = Uint8List(event.contentLength!);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        return;
      });
    });

    notifyListeners();

    await _showDownloadCompleteNotification();
  }

  Future<void> _showDownloadCompleteNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel',
      'Download Channel',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'File downloaded successfully',
      platformChannelSpecifics,
      payload: 'download_complete',
    );
  }
 */
  // showNotification
}

// File? videoThumb;

Future<MultipleFiles> getVideos(List<Messages> messagesList) async {
  List<Files> allFiles = [];
  messagesList.forEach((element) {
    if (element.files != null &&
        (!allFiles.contains(element.files) || allFiles.isEmpty)) {
      allFiles.addAll(element.files!);
    }

    /* element.files!.forEach((element) {
      if (!allFiles.contains(element) || allFiles.isEmpty) {
        allFiles.add(element);
      }
    }); */
  });
  var videos = allFiles.where((element) => element.filetype == 'mp4').toList();
  var docs = allFiles.where((element) => element.filetype == 'docx').toList();
  var pdfs = allFiles.where((element) => element.filetype == 'pdf').toList();
  MultipleFiles files = MultipleFiles(videos, docs, pdfs);
  return files;
}

class MultipleFiles {
  List<Files>? videoFiles;
  List<Files>? docsFiles;
  List<Files>? pdfFiles;

  MultipleFiles(this.videoFiles, this.docsFiles, this.pdfFiles);

  List<Files>? get getVideoFiles => this.videoFiles;

  set setVideoFiles(List<Files>? videoFiles) => this.videoFiles = videoFiles;

  get getDocsFiles => this.docsFiles;

  set setDocsFiles(docsFiles) => this.docsFiles = docsFiles;

  get getPdfFiles => this.pdfFiles;

  set setPdfFiles(pdfFiles) => this.pdfFiles = pdfFiles;
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

