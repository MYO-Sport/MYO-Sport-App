
import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/models/MemberModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/ReadMoreWidget.dart';

class ClubInfo extends StatefulWidget {
  final String clubImage;
  final ClubModel clubModel;

  ClubInfo({this.clubImage = '',required this.clubModel});

  @override
  _ClubInfoState createState() => _ClubInfoState();
}

class _ClubInfoState extends State<ClubInfo> {
  bool isLoading = false;
  List<MemberModel> members = [];
  List<String> associations = [];

  @override
  void initState() {
    super.initState();
    members = widget.clubModel.members;
    associations = widget.clubModel.associations;
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                    child: Row(
                      children: <Widget>[
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ABOUT US',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ReadMoreWidget(
                                text:
                                    widget.clubModel.about,
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
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TEAM MEMBERS',
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
                                child: Text('No Members'),
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
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CONTACT US',
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
                                  SizedBox(width: 30.0),
                                  Text(
                                    widget.clubModel.cell,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: colorBlack),
                                  ),
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
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'City',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.clubModel.city,
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
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'LOCATION',
                                style: TextStyle(
                                    color: colorGrey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.clubModel.location,
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
                        Material(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedImage(
                              imageWidth: 50,
                              imageHeight: 50,
                              imageArea: 25,
                              image: widget.clubImage,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        SizedBox(width: 20.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ASSOCIATIONS',
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
                                child: Text('No Associations'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
