
import 'package:flutter/material.dart';
import 'package:us_rowing/models/CoachModel.dart';
import 'package:us_rowing/models/MemberModel.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class MyCoachInfo extends StatefulWidget {
  final String coachImage;
  final CoachModel coachModel;

  MyCoachInfo({this.coachImage = '',required this.coachModel});

  @override
  _MyCoachInfoState createState() => _MyCoachInfoState();
}

class _MyCoachInfoState extends State<MyCoachInfo> {
  bool isLoading = false;
  List<MemberModel> members = [];
  List<String> associations = [];

  @override
  void initState() {
    super.initState();
    // members = widget.coachModel.members;
    // associations = widget.coachModel.associations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(100),
                          child: CachedImage(
                            padding: 0,
                            image: widget.coachImage,
                            placeHolder: IMG_INFO,
                            radius: 100,
                            imageHeight: 60,
                            imageWidth: 60,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: Text(
                            widget.coachModel.username,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorBlack,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'SKILL / SPECIALITY',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.coachModel.speciality,
                                style: TextStyle(
                                    fontSize: 11.0,
                                    color: colorBlack),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TEAM NAMES',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              isLoading
                                  ? Center(
                                child: CircularProgressIndicator(),
                              )
                                  : members.length == 0
                                  ? Center(
                                child: Text('No Teams',style: TextStyle(fontSize: 12.0,color: colorGrey)),
                              ):
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: members.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 6.0,
                                  mainAxisSpacing: 0.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  MemberModel member = members[index];
                                  index = index + 1;
                                  return Text(
                                    index.toString() + '.' + member.username,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CLUB NAMES',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              isLoading
                                  ? Center(
                                child: CircularProgressIndicator(),
                              )
                                  : associations.length == 0
                                  ? Center(
                                child: Text('No Clubs',style: TextStyle(fontSize: 12.0,color: colorGrey)),
                              ):
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: associations.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 6.0,
                                  mainAxisSpacing: 0.0,
                                  crossAxisSpacing: 10.0,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  String association = associations[index];
                                  index = index + 1;
                                  return Text(
                                    index.toString() + '.' + association,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CONTACT ME',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Cell No:',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text(
                                    widget.coachModel.contactNum,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  ),
                                  SizedBox(width: 30.0),
                                ],
                              ),
                              SizedBox(height: 5.0,),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Email:',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text(
                                    widget.coachModel.email,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  ),
                                  SizedBox(width: 30.0),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ADDRESS',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.coachModel.address.city+ "," + widget.coachModel.address.state,
                                style: TextStyle(
                                    fontSize: 11.0,
                                    color: colorBlack),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
