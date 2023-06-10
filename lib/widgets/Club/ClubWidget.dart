import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Club/Clubs/ClubsDetails.dart';
import 'package:us_rowing/widgets/AddMenuButton.dart';
import 'package:http/http.dart' as http;

import '../CachedImage.dart';

class ClubWidget extends StatefulWidget {
  final String name;
  final String image;
  final String userId;
  final String clubId;
  final Function onAdd;
  final ClubModel clubModel;

  ClubWidget({this.image='',this.name='', required this.userId, required this.clubId,required this.onAdd,required this.clubModel});

  @override
  _ClubWidgetState createState() => _ClubWidgetState();

}

class _ClubWidgetState extends State<ClubWidget>{

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
      child: InkWell(
        child: Material(
          color: colorWhite,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: colorLightGrey,
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: CachedImage(image: widget.image,radius: 0,fit: BoxFit.fill,padding: 0,
                      )),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(widget.name,maxLines: 2,overflow: TextOverflow.fade,textAlign: TextAlign.start,),
                  )),
                  AddMenuButton(progress:isLoading, text: 'Add', onPressed: (){
                    assignClub();
                  })
                ],
              ),
            ),
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClubDetails(clubName: widget.name,clubImage: widget.image,clubModel: widget.clubModel,userId: widget.userId,)),
          );
        },
      ),
    );
  }

  assignClub() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + widget.userId);
    print('clubId' + widget.clubId);
    String apiUrl = ApiClient.urlAssignClub + widget.userId + '/' + widget.clubId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralResponse mResponse =
      GeneralResponse.fromJson(json.decode(responseString));
      if (mResponse.success) {
        widget.onAdd();
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }
}