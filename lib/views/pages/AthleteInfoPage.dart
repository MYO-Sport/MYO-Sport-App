import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/UserInfoResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/HeadValueWidget.dart';
import 'package:http/http.dart' as http;

class AthleteInfoPage extends StatefulWidget {

  final String name;
  final String email;
  final String image;
  final String userId;

  AthleteInfoPage({required this.name,required this.email, required this.image,required this.userId});

  @override
  _AthleteInfoPageState createState() => _AthleteInfoPageState();
}

class _AthleteInfoPageState extends State<AthleteInfoPage> {

  int weight=0;
  int height=0;
  String cellNo='';
  int age=0;

  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(colorGrey),
                    ),
                  ),
                  height: 80.0,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0))),
                ),
                errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    "assets/images/placeholder.jpg",
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                imageUrl: ApiClient.baseUrl+widget.image,
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 5,),
          Text(widget.name,style: TextStyle(color: colorBlack,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(widget.email,style: TextStyle(color: colorGrey),),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: HeadValueWidget(
              value: isLoading || weight==0?'N/A':'$weight',
              title: 'Weight',
            ),
          ),
          SizedBox(height: 25.0,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 30.0),
            child: HeadValueWidget(
              value: isLoading || weight==0?'N/A':'$weight',
              title: 'Height',
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: HeadValueWidget(
              title: 'Cell No',
              value: isLoading || cellNo==''?'N/A':cellNo,
            ),
          ),
          SizedBox(height: 25.0,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.0),
            child: HeadValueWidget(
              value: isLoading || age==0?'N/A':'$age',
              title: 'Age',
            ),
          ),
          SizedBox(height: 25.0,),
        ],
      ),
    );
  }

  getUserInfo() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetUserInfo;

    print('userId: '+widget.userId);

    final response = await http.post(Uri.parse(apiUrl),
        body: {'user_id': widget.userId}).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      UserInfoResponse mResponse =
      UserInfoResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          height=mResponse.user.height;
          weight=mResponse.user.weight;
          age=mResponse.user.age;
          cellNo=mResponse.user.contactNum;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: Something Went Wrong');
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
