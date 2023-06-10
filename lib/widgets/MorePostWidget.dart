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

class MorePostWidget extends StatefulWidget {

  final String userId;
  final String feedId;
  final bool isAdmin;

  MorePostWidget({required this.userId,required this.feedId,required this.isAdmin});


  @override
  _MorePostWidgetState createState() => _MorePostWidgetState();
}

class _MorePostWidgetState extends State<MorePostWidget> {

  List<CommentModel> comments = [];
  late CommentModel newComment;
  late UserModel user;

  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = new FocusNode();
  bool isLoading = false;
  bool savingPost = false;

  late String strComment;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height*0.4,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(child: MoreWidget(image: 'assets/images/save.png', head: 'Save Post', desc: 'Add this to your saved items.'),onTap: (){
                    savePost();
                  },),
                  Divider(),
                  InkWell(child: MoreWidget(image: 'assets/images/notification.png', head: 'Notifications', desc: 'Turn notifications on and off.'),onTap: (){
                    Navigator.of(context).pop();
                  },),
                  Divider(),
                  InkWell(child: MoreWidget(image: 'assets/images/delete.png', head: 'Delete Post', desc: 'You can delete this post if you want.'),onTap: (){
                    if(widget.isAdmin){
                      deletePost();
                    }else{
                      showToast('Only admin can delete a post');
                    }
                  },),
                ],
              ),
            ),
            Positioned(
                right: 20,
                top: 15,
                child: InkWell(child: Icon(Icons.close,color: colorBlack,),onTap: (){
                  Navigator.of(context).pop();
                },)),
            isLoading?
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: colorBlack.withOpacity(0.3),
              ),
              height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),)
                :SizedBox(),

          ],
        ),
      ),
    );
  }

  bool validate(){
    strComment=textEditingController.text;
    if(strComment.isEmpty){
      return false;
    }
    return true;
  }

  savePost() async {

    setState(() {
      isLoading=true;
    });

    print('userId' + widget.userId);
    print('postId' + widget.feedId);
    String apiUrl = ApiClient.urlSavePost ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'user_id':widget.userId,
          'post_id':widget.feedId
        }
    )
        .catchError((value) {
      setState(() {
        isLoading=false;
      });
      showToast('Something Went Wrong');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        showToast('Added to Saved Posts');
        setState(() {
          isLoading=false;
        });
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading=false;
        });
        showToast('Something Went Wrong');
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  deletePost() async {

    setState(() {
      isLoading=true;
    });

    print('userId' + widget.userId);
    print('postId' + widget.feedId);
    String apiUrl = ApiClient.urlDeletePost ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'user_id':widget.userId,
          'post_id':widget.feedId
        }
    )
        .catchError((value) {
      setState(() {
        isLoading=false;
      });
      showToast('Something Went Wrong');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        showToast('Post is Deleted Successfully');
        setState(() {
          isLoading=false;
        });
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          isLoading=false;
        });
        showToast('Something Went Wrong');
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      showToast('Something Went Wrong');
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

}