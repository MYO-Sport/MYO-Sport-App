import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/DocumentModel.dart';
import 'package:us_rowing/models/SavedDocModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/SavedDocResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/DocumentItem.dart';
import 'package:http/http.dart' as http;

class SavedDocView extends StatefulWidget {

  final String id;
  final String stat;
  final String userId;

  SavedDocView({required this.id,required this.stat,required this.userId});

  @override
  _SavedDocViewState createState() => _SavedDocViewState();
}

class _SavedDocViewState extends State<SavedDocView> {

  List<SavedDocModel> docs=[];

  bool isLoading=true;


  @override
  void initState() {
    super.initState();
    getDocuments(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      body:
      isLoading
          ? Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
            )),
      ):
      docs.length==0?
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
            child:Text('No Documents Found',style: TextStyle(color: colorGrey),)),
      ):
      ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context,index){
            DocumentModel doc=docs[index].media;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DocumentItem(mediaUrl: doc.media,userId: widget.userId,mediaId: doc.sId,downloadAble: false,),
            );
          }),
    );
  }

  getDocuments(String id) async {
    print('id: $id');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetSavedDoc;

    Object body;

    body={'user_id':widget.userId,'limit':'5','skip':'0'};

    final response = await http
        .post(Uri.parse(apiUrl),body: body)
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      SavedDocResponse mResponse =
      SavedDocResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {

          docs=mResponse.savedMedia;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading=false;
        });
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error: Check Your Internet Connection');
    }
  }

}
