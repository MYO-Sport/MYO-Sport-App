
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:us_rowing/models/VideoModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/widgets/MoreMediaWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'CachedImage.dart';
import 'VideoItem.dart';
import 'ZoomImage.dart';

class MediaWidget extends StatefulWidget {
  final VideoModel video;
  final String userId;
  final bool show;
  final bool options;
  final Function onRefresh;

  MediaWidget({required this.video,required this.userId,this.show=true, this.options=true, required this.onRefresh});

  @override
  State<StatefulWidget> createState() => _StateMediaWidget();

}

class _StateMediaWidget extends State<MediaWidget>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(19),topRight: Radius.circular(19))
          ),
          child: Column(
            children: [
              widget.show?
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(19),topRight: Radius.circular(19))
                ),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedImage(
                      padding: 0,
                      imageHeight: 27,
                      imageWidth: 27,
                      radius: 100,
                      image: widget.video.createrInfo.length==0?'':ApiClient.baseUrl+widget.video.createrInfo[0].profileImage,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(widget.video.createrInfo.length==0?'':widget.video.createrInfo[0].username,style: TextStyle(fontSize: 10.0,color: colorBlack,),maxLines: 1,),
                            Row(
                              children: [
                                Text(widget.video.createrInfo.length==0?'':widget.video.createrInfo[0].type,style: TextStyle(fontSize: 8.0,color: colorTextSecondary),),
                                Container(margin:EdgeInsets.symmetric(horizontal: 2),height: 1,width: 1,decoration: BoxDecoration(color: colorPrimary,borderRadius: BorderRadius.circular(2)),),
                                Text(getTime(),style: TextStyle(fontSize: 8.0,color: colorTextSecondary),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    widget.options?
                    InkWell(
                      child: Icon(Icons.keyboard_arrow_down_outlined,color: colorGrey,),
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Wrap(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom:
                                      MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: MoreMediaWidget(
                                    userId: widget.userId,
                                    mediaId: widget.video.sId, download: (){
                                    _requestDownload();
                                  },
                                  ),
                                ),
                              ],
                            )).then((value) {
                          if(value is bool && value){
                            widget.onRefresh();
                          }
                        });
                      },
                    ):
                    SizedBox()
                  ],
                ),
              ):SizedBox(),
              Expanded(child: widget.video.mediaType == postVideo
                  ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: VideoItem(videoUrl: widget.video.media))
                  : InkWell(
                child: CachedImage(
                  imageWidth: MediaQuery.of(context).size.width,
                  imageHeight: MediaQuery.of(context).size.height,
                  padding: 0,
                  image: ApiClient.baseUrl + widget.video.media,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ZoomImage(url: ApiClient.baseUrl + widget.video.media)));
                },
              ),)

            ],
          ),
        ));
  }

  String getTime(){
    DateTime createTime=DateTime.parse(widget.video.createdAt);
    return timeago.format(createTime,locale: 'en_short');
  }

  void _requestDownload() async {
    showToast('Downloading...');
    bool permission= await _checkPermission();

    if(permission){
      String _localPath =
          (await _findLocalPath())! + Platform.pathSeparator + 'Download';

      print('Local Path: $_localPath');

      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      await FlutterDownloader.enqueue(
        url: Uri.decodeFull(ApiClient.baseUrl+widget.video.media),
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
    }else{
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
