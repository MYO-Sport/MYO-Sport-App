import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/DocumentModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/DocumentsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/DocumentItem.dart';
import 'package:http/http.dart' as http;

class DocumentPage extends StatefulWidget {

  final String id;
  final String stat;
  final String userId;

  DocumentPage({required this.id,required this.stat,required this.userId});

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {

  List<DocumentModel> docs=[];

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
            DocumentModel doc=docs[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DocumentItem(mediaUrl: doc.media,mediaId: doc.sId,userId: widget.userId,),
            );
          }),
    );
  }

  getDocuments(String id) async {
    print('id: $id');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetPdfs;

    Object body;

    if(widget.stat=='1'){
      body={'status':'1','club_id':widget.id};
    }else if(widget.stat=='2'){
      body={'status':'2','team_id':widget.id};
    }else{
      body={'status':'3',};
    }

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
      DocumentsResponse mResponse =
      DocumentsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {

          docs=mResponse.libraries;
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
