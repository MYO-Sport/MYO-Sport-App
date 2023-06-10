import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/CommentModel.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/MoreWidget.dart';

class MoreMediaWidget extends StatefulWidget {
  final String userId;
  final String mediaId;
  final Function download;

  MoreMediaWidget(
      {required this.userId, required this.mediaId, required this.download});

  @override
  _MoreMediaWidgetState createState() => _MoreMediaWidgetState();
}

class _MoreMediaWidgetState extends State<MoreMediaWidget> {
  List<CommentModel> comments = [];
  late CommentModel newComment;
  late UserModel user;

  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = new FocusNode();
  bool isLoading = false;

  late String strComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: MoreWidget(
                        image: 'assets/images/save.png',
                        head: 'Save Media',
                        desc: 'Add this to your saved items.'),
                    onTap: () {
                      saveMedia();
                    },
                  ),
                  Divider(),
                  InkWell(
                      child: MoreWidget(
                          image: 'assets/images/download.png',
                          head: 'Download',
                          desc: 'You can download this media.'),
                    onTap: (){
                        widget.download();
                        Navigator.of(context).pop();
                    },
                  ),
                  Divider(),
                  InkWell(
                    child: MoreWidget(
                        image: 'assets/images/delete.png',
                        head: 'Delete Media',
                        desc: 'You can delete this media if you want.'),
                    onTap: (){
                      deleteMedia();
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                right: 20,
                top: 15,
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    color: colorBlack,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )),
            isLoading
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: colorBlack.withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  bool validate() {
    strComment = textEditingController.text;
    if (strComment.isEmpty) {
      return false;
    }
    return true;
  }

  saveMedia() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('lib_id' + widget.mediaId);
    String apiUrl = ApiClient.urlSaveMedia;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'video_id': widget.mediaId
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading = false;
        });
        showToast('Added to Saved Media');
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast('Something Went Wrong');
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  deleteMedia() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('lib_id' + widget.mediaId);
    String apiUrl = ApiClient.urlDeleteMedia;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'video_id': widget.mediaId
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading = false;
        });
        showToast('Media is deleted Successfully.');
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast('Something Went Wrong');
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
    }
  }
}
