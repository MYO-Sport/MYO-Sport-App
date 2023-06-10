import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ReservedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ReservedResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/ReservedWidget.dart';
import 'package:http/http.dart' as http;

class ReservedView extends StatefulWidget {

  final String userId;

  ReservedView({required this.userId});

  @override
  State<StatefulWidget> createState() => _StateExploredView();
}

class _StateExploredView extends State<ReservedView> {

  bool isLoading=true;
  List<ReservedModel> reservedList=[];

  @override
  void initState() {
    super.initState();
    getReserved();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:
        isLoading?
            Expanded(child: Center(child: CircularProgressIndicator(),)):
            reservedList.length==0?
                Expanded(child: Center(child: Text('No Reserved Equipments Found',style: TextStyle(color: colorGrey),),)):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5),
              child: Text(
                'My Bookings',
                style: TextStyle(
                    color: colorBlack, fontSize: 16.0, letterSpacing: 0.5),
              ),
            ),
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: reservedList.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  ReservedModel reserved=reservedList[index];
                  return ReservedWidget(reserved: reserved,userId: widget.userId,updated: (){
                    setState(() {
                      isLoading=true;
                      reservedList.clear();
                    });
                    getReserved();
                  },);
                },
              ),
            ))
          ],
        ),
    );
  }

  getReserved() async {
    String apiUrl = ApiClient.urlGetReservedList;

    print('Url: '+apiUrl);
    print('User Id: '+ widget.userId);

 
    final response = await http
        .post(Uri.parse(apiUrl),
        body: {
          'user_id': widget.userId,
          'skip': '0',
          'limit': '10'
        })
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      print('error: $value');
      return value;

      // showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      ReservedResponse mResponse =
      ReservedResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          reservedList=mResponse.reservations;
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context,mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context,'Check Your Internet Connection');
    }
  }
}
