import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/widgets/MoreDocWidget.dart';

class DocumentItem extends StatefulWidget {
  final String mediaUrl;
  final bool downloadAble;
  final String mediaId;
  final String userId;
  final bool options;

  DocumentItem(
      {required this.mediaUrl,
      this.downloadAble = true,
      required this.mediaId,
      required this.userId,
      this.options = true});

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  ReceivePort _port = ReceivePort();
  double progress = 0;

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        FlutterDownloader.open(taskId: id);
      } else if (status == DownloadTaskStatus.canceled) {
        showToast('Download Canceled');
      } else if (status == DownloadTaskStatus.failed) {
        showToast('Download Failed');
      }

      setState(() {});
    });
   

    FlutterDownloader.registerCallback((id, status, progress) {
      downloadCallback(id, status, progress);
    });
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, int status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: colorWhite),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: colorSilver,
                ),
                child: Center(
                    child: Text(
                  'PDF',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  getPdfName(widget.mediaUrl),
                  style: TextStyle(color: colorBlack),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            widget.downloadAble
                ? InkWell(
                    child: Icon(
                      Icons.more_horiz,
                      color: colorGrey,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Wrap(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: MoreDocWidget(
                                      userId: widget.userId,
                                      docId: widget.mediaId,
                                      download: () {
                                        _requestDownload();
                                      },
                                    ),
                                  ),
                                ],
                              ));
                    },
                  )
                : SizedBox()
          ],
        ));
  }

  String getPdfName(String str) {
    List<String> list = str.split('/');
    List<String> list2 = list[list.length - 1].split('\\');
    return list2[list2.length - 1];
  }

  void _requestDownload() async {
    showToast('Downloading...');
    bool permission = await _checkPermission();

    if (permission) {
      String _localPath =
          (await _findLocalPath())! + Platform.pathSeparator + 'Download';

      print('Local Path: $_localPath');

      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      await FlutterDownloader.enqueue(
        url: Uri.decodeFull(ApiClient.baseUrl + widget.mediaUrl),
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      showToast('Permissions Required');
    }
  }

  Future<String?> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory?.path;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
