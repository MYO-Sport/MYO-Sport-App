import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';
import 'package:us_rowing/models/FeedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/views/AthleteView/Coach/MyCoach/FeedDetailView.dart';
import 'package:us_rowing/views/VideoPalyerItems.dart';
import 'package:us_rowing/widgets/MorePostWidget.dart';
import 'package:video_player/video_player.dart';

import 'CachedImage.dart';
import 'PhotoGridWidget.dart';
import 'ViewCommentWidget.dart';
import 'ViewLikesWidget.dart';
import 'package:http/http.dart' as http;

import 'package:timeago/timeago.dart' as timeago;

class FeedWidget extends StatefulWidget {
  final FeedModel feed;
  final String userId;
  final bool options;
  final bool isAdmin;
  final Function onRefresh;

  FeedWidget(
      {required this.feed,
      required this.userId,
      this.options = true,
      required this.isAdmin,
      required this.onRefresh});

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  late int likes;
  late int comments;
  late bool isLiked;
  ReceivePort _port = ReceivePort();
  late DateTime now;
  late VideoPlayerController playerController;

  @override
  void initState() {
    super.initState();
    now = DateTime.now().toUtc();
    likes = widget.feed.likes.length;
    comments = widget.feed.comments.length;
    isLiked = widget.feed.isLiked;
    if (widget.feed.media.length > 0 && widget.feed.mediaType == postVideo) {
      playerController = VideoPlayerController.network(
        ApiClient.baseUrl + widget.feed.media[0],
      );
    }

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.complete) {
        FlutterDownloader.open(taskId: id);
      } else if (status == DownloadTaskStatus.canceled) {
        showToast('Download Canceled');
      } else if (status == DownloadTaskStatus.failed) {
        showToast('Download Failed');
      }

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    playerController.dispose();
    super.dispose();
  }

  static void downloadCallback(String id, int status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: colorWhite,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedImage(
                        padding: 0,
                        imageHeight: 40,
                        imageWidth: 40,
                        radius: 100,
                        image: widget.feed.createrInfo.length > 0
                            ? ApiClient.baseUrl +
                                widget.feed.createrInfo[0].profileImage
                            : '',
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.feed.createrInfo.length == 0
                                    ? ''
                                    : widget.feed.createrInfo[0].username,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: colorBlack,
                                ),
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.feed.createrInfo.length == 0
                                        ? ''
                                        : widget.feed.createrInfo[0].type,
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: colorTextSecondary),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 3,
                                    width: 3,
                                    decoration: BoxDecoration(
                                        color: colorPrimary,
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                  Text(
                                    getTime(),
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: colorTextSecondary),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      widget.options
                          ? InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: colorPrimary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(40)),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: colorPrimary,
                                  )),
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
                                              child: MorePostWidget(
                                                isAdmin: widget.isAdmin,
                                                feedId: widget.feed.sId,
                                                userId: widget.userId,
                                              ),
                                            ),
                                          ],
                                        )).then((value) {
                                  if (value is bool && value) {
                                    widget.onRefresh();
                                  }
                                });
                              },
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReadMoreText(
                  widget.feed.feedText,
                  style: TextStyle(color: colorTextPrimary, fontSize: 12.0),
                  textAlign: TextAlign.justify,
                  trimLines: 2,
                  colorClickableText: colorBlue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: colorBlue),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              widget.feed.media.length > 0 && widget.feed.mediaType == postImg
                  ? PhotoGridWidget(
                      imageUrls: widget.feed.media,
                      onImageClicked: (i) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedDetailView(
                                      imgList: widget.feed.media,
                                    )));
                      },
                      onExpandClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedDetailView(
                                      imgList: widget.feed.media,
                                    )));
                      },
                      maxImages: 4,
                    )
                  : widget.feed.media.length > 0 &&
                          widget.feed.mediaType == postVideo
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: colorBlack,
                            ),
                            child: VideoPlayerItems(
                              videoPlayerController: playerController,
                              looping: false,
                              autoplay: false,
                            ),
                          ),
                        )
                      : widget.feed.media.length > 0 &&
                              widget.feed.mediaType == postFile
                          ? InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorGrey),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                            'assets/images/pdf.png'),
                                        width: 20.0,
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          getPdfName(widget.feed.media[0]),
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                          maxLines: 3,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                _requestDownload(
                                    ApiClient.baseUrl + widget.feed.media[0]);
                              },
                            )
                          : SizedBox(),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: colorBlue,
                            size: 11,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$likes Likes',
                            style: TextStyle(
                                color: isLiked ? colorBlue : colorBlack,
                                fontSize: 11.0),
                          ),
                        ],
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
                                      child: ViewLikesWidget(
                                        postId: widget.feed.sId,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                  ],
                                ));
                      },
                    ),
                    InkWell(
                      child: Text(
                        '$comments Comments',
                        style: TextStyle(color: colorBlack, fontSize: 11.0),
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
                                      child: ViewCommentWidget(
                                        onComment: onComment,
                                        postId: widget.feed.sId,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                  ],
                                ));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  height: 0,
                  color: colorGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/like.png',
                            height: 16,
                            width: 16,
                            color: isLiked ? colorBlue : colorGrey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(
                                fontSize: 11,
                                color: isLiked ? colorBlue : colorGrey),
                          )
                        ],
                      ),
                      onTap: () {
                        if (!isLiked) {
                          setState(() {
                            likes = likes + 1;
                            isLiked = true;
                          });
                          likePost();
                        }
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/comment.png',
                            color: colorGrey,
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Comment',
                            style: TextStyle(fontSize: 11, color: colorGrey),
                          )
                        ],
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
                                      child: ViewCommentWidget(
                                        onComment: onComment,
                                        postId: widget.feed.sId,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                    ),
                                  ],
                                ));
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/share.png',
                            color: colorGrey,
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Share',
                            style: TextStyle(fontSize: 11, color: colorGrey),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  likePost() async {
    print('userId' + widget.userId);
    print('postId' + widget.feed.sId);
    String apiUrl = ApiClient.urlLikePost;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'post_id': widget.feed.sId
    }).catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        print('Likes Successful');
      } else {
        print('Error: ' + mResponse.message);
      }
    } else {
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  onComment(String text) {
    setState(() {
      comments = comments + 1;
    });
  }

  String getPdfName(String str) {
    List<String> list = str.split('/');

    return list[list.length - 1];
  }

  void _requestDownload(String url) async {
    showToast('Downloading...');
    bool permission = await _checkPermission();

    if (permission) {
      String _localPath =
          (await _findLocalPath())! + Platform.pathSeparator + 'Download';

      print('Local: $_localPath');

      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      await FlutterDownloader.enqueue(
          url: Uri.encodeFull(url),
          headers: {"auth": "test_for_sql_encoding"},
          savedDir: _localPath,
          showNotification: true,
          openFileFromNotification: true);
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

  String getTime() {
    DateTime createTime = DateTime.parse(widget.feed.createdAt);
    return timeago.format(createTime);
  }
}
