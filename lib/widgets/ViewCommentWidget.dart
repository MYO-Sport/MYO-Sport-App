import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:us_rowing/models/CommentContentModel.dart';
import 'package:us_rowing/models/CommentModel.dart';
import 'package:us_rowing/models/CreatorModel.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CommentsResponse.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;

class ViewCommentWidget extends StatefulWidget {

  final Function onComment;
  final String postId;

  ViewCommentWidget({required this.onComment, required this.postId});

  @override
  _ViewCommentWidgetState createState() => _ViewCommentWidgetState();
}

class _ViewCommentWidgetState extends State<ViewCommentWidget> {

  List<CommentModel> comments = [];
  late CommentModel newComment;
  late UserModel user;

  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = new FocusNode();
  bool isLoading = true;

  late String strComment;

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        user=value;
      });
      getComments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Material(
              color: colorWhite,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(child: Icon(Icons.arrow_back_ios),onTap: (){
                      Navigator.pop(context);
                    },),
                    Text(
                      'Comments',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          letterSpacing: 1.0),
                    ),
                    Text(
                      'Likes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: colorWhite,
                          letterSpacing: 1.0
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            isLoading
                ? Expanded(
                child: Center(child: CircularProgressIndicator()))
                : comments.length == 0
                ? Expanded(
              child: Center(
                  child: Text(
                    'No Comments',
                    style: TextStyle(color: colorGrey),
                  )),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context , index){
                  CommentModel comment = comments[index];
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CachedImage(image: '',imageHeight: 50.0,radius: 25.0,imageWidth: 50,),
                            SizedBox(width: 20.0,),
                            Flexible(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.commentedBy.username,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10.0,),
                                ReadMoreText(
                                  comment.comment.commentText,
                                  style:
                                  TextStyle(color: colorGrey, fontSize: 10.0),
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
                              ],
                            )),
                          ],
                        ),
                        Divider(color: colorGrey,thickness: 0.2,),
                      ],
                    ),
                  );
                },
              ),
            ),
        Container(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  child: TextField(
                    style: TextStyle(color: colorGrey, fontSize: 15.0),
                    controller: textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type your comment. . .',
                      hintStyle: TextStyle(color: colorGrey,letterSpacing: 1.0),
                    ),
                    focusNode: focusNode,
                  ),
                ),
              ),

              // Button send message
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 8.0),
                  child: new IconButton(
                    icon: new Icon(Icons.send),
                    color: colorBlue,
                    onPressed: () {
                      hideKeyboard(context);
                      if(validate()){
                        widget.onComment(strComment);
                        commentPost(strComment);
                      }
                    },
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
          width: double.infinity,
          height: 50.0,
          decoration: new BoxDecoration(
              border: new Border(top: new BorderSide(color: colorGrey, width: 0.5)),
              color: Colors.white),
        ),
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

  getComments() async {
    print('postId: ' + widget.postId);
    String apiUrl = ApiClient.urlGetComments+widget.postId ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
    )
        .catchError((value) {
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      CommentsResponse mResponse =
      CommentsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          comments=mResponse.post;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading=false;
        });
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print('Error: ' + 'Check Your Internet Connection');
    }
  }

  commentPost(String comment) async {
    print('userId: ' + user.sId);
    print('postId: ' + widget.postId);
    print('comment: ' + comment);
    String apiUrl = ApiClient.urlCommentPost ;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'user_id':user.sId,
          'post_id':widget.postId,
          'comment_text':comment
        }
    )
        .catchError((value) {
      print('Error: ' + value.toString());
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        print('Commented Successful');
        CommentContentModel content=CommentContentModel(sId: '', userId: user.sId, commentText: comment);
        CreatorModel creator=CreatorModel(sId: user.sId, username: user.username, email: user.email,profileImage: user.profileImage,type: user.type);
        newComment=CommentModel(comment: content, commentedBy: creator);
        setState(() {
          comments.add(newComment);
        });
      } else {
        print('Error: ' + mResponse.message);
      }
    } else {
      print('Error: ' + 'Something Went Wrong');
    }
  }
}