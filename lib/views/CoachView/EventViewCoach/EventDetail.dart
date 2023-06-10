import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/EventAttendantModel.dart';
import 'package:us_rowing/models/EventModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/AttendantsResponse.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/AthleteEventInformation.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/EventButton.dart';
import 'package:us_rowing/widgets/LeaderWidget.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class EventDetail extends StatefulWidget {

  final EventModel event;
  final String userId;
  final String userType;
  final int status;
  final Function onChange;
  final ImageProvider mapImage;
  final String address;
  final String completeStatus;

  EventDetail(
      {required this.event,required this.userId, required this.userType,required this.status,required this.onChange,required this.mapImage,required this.address,required this.completeStatus});

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {

  late int status;
  bool isLoading=false;

  bool loadingDependents=true;
  List<EventAttendantModel> attendants=[];

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    status=widget.status;
    getAttendants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: SimpleToolbar(title:'Event Detail'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Material(
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: colorGrey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0))),
                    child: ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),child: Image(image: widget.mapImage,fit: BoxFit.fill,))
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.event.name,
                          style: TextStyle(color: colorBlack, fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 24,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.completeStatus==statComplete?colorGreen:colorPrimary),
                        child: Center(
                          child: Text(
                            widget.completeStatus,
                            style: TextStyle(color: colorWhite, fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: colorBlue,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          '${getFormattedDate(widget.event.startDate)} - ${getFormattedDate(widget.event.endDate)}',
                          style: TextStyle(color: colorTextSecondary, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: colorBlue,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.address,
                        style: TextStyle(color: colorTextSecondary, fontSize: 12),
                      )
                    ],
                  ),
                ),
                widget.userType==typeAthlete?
                Column(
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        EventButton(icon: Icons.star, text: 'Interested', onPressed: (){
                          addEvent(2);
                        }, checked: status==2),
                        EventButton(icon: Icons.check_circle, text: 'Going', onPressed: (){
                          addEvent(1);
                        }, checked: status==1),
                        EventButton(icon: Icons.dangerous, text: 'May Be', onPressed: (){
                          addEvent(3);
                        }, checked: status==3),
                      ],
                    ),
                    Divider(),
                  ],
                ):SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Going',
                    style: TextStyle(color: colorBlack, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child:
                  loadingDependents?
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):attendants.length==0?
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('No Attendants Yet',style: TextStyle(color: colorGrey,fontSize: 12),),
                    ),
                  ):
                  InkWell(
                    child: ImageStack(
                      imageList: images,
                      totalCount: images.length,
                      // If larger than images.length, will show extra empty circle
                      imageRadius: 25,
                      // Radius of each images
                      imageCount: 3,
                      // Maximum number of images to be shown in stack
                      imageBorderWidth: 0, // Border width around the images
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AthleteEventInformation(
                                    eventId: widget.event.sId,
                                  )));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CachedImage(
                        padding: 0,
                        imageHeight: 40,
                        imageWidth: 40,
                        radius: 100,
                        image: widget.event.createrInfo.length > 0
                            ? ApiClient.baseUrl +
                            widget.event.createrInfo[0].profileImage
                            : '',
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.event.createrInfo.length == 0
                                    ? ''
                                    : widget.event.createrInfo[0].username,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: colorBlack,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                widget.event.createrInfo.length == 0
                                    ? ''
                                    : widget.event.createrInfo[0].type,
                                style: TextStyle(
                                    fontSize: 10.0, color: colorTextSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'About Event',
                    style: TextStyle(color: colorBlack, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.event.description,
                    style: TextStyle(color: colorTextSecondary, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Leaderboard',
                    style: TextStyle(color: colorBlack, fontSize: 18),
                  ),
                ),
                loadingDependents?
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ):attendants.length==0?
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('No Attendants Yet',style: TextStyle(color: colorGrey,fontSize: 12),),
                  ),
                ):ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: attendants.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    EventAttendantModel attendant=attendants.length>0?attendants[index]:EventAttendantModel(userProfileImage: '', userEmail: '', sId: '', userName: '', userId: '', userType: '', status: '');
                    index = index + 1;
                    return LeaderWidget(athlete: attendant,index:index,last: index==attendants.length,);
                  },
                ),

                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDate(){
    if(widget.event.date.isNotEmpty){
      DateTime dateTime=DateTime.parse(widget.event.date);
      return dateTime.day.toString();
    }else{
      return '-';
    }
  }



  String getDay(){
    if(widget.event.date.isNotEmpty){
      DateTime dateTime=DateTime.parse(widget.event.date);
      return DateFormat('EEEE').format(dateTime);
    }else{
      return '';
    }
  }

  getAttendants() async {
    setState(() {
      loadingDependents = true;
    });
    String apiUrl = ApiClient.urlGetAttendants;

    print('eventId: '+widget.event.sId);

    final response = await http.post(Uri.parse(apiUrl),
        body: {'event_id': widget.event.sId,}).catchError((value) {
      setState(() {
        loadingDependents = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      AttendantsResponse mResponse =
      AttendantsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        images.clear();
        attendants=mResponse.attendents;
        for(EventAttendantModel attendant in attendants){
          images.add(ApiClient.baseUrl+attendant.userProfileImage);
        }
        setState(() {
          loadingDependents = false;
        });
      } else {
        setState(() {
          loadingDependents = false;
        });
        MySnackBar.showSnackBar(context, 'Error: Something Went Wrong');
      }
    } else {
      setState(() {
        loadingDependents=false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  addEvent(int newStatus) async {
    print('User Id ' + widget.userId);
    setState(() {
      isLoading = true;
    });

    String flag;
    if(status==1 || status==2 || status==3){
      flag='1';
    }else{
      flag='0';
    }

    String apiUrl = ApiClient.urlSubEvent;


    final response = await http.post(Uri.parse(apiUrl), body: {
      'event_id': widget.event.sId,
      'user_id': widget.userId,
      'status': '$newStatus',
      'flag': flag
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          status = newStatus;
          widget.onChange(status);
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }

  declineEvent(String flag) async {
    print('User Id '+widget.userId);
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlSubEvent;

    final response = await http
        .post(Uri.parse(apiUrl),
        body: {'event_id':widget.event.sId,'user_id':widget.userId,'status':'2','flag':flag})
        .catchError((value) {
      setState(() {

        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          status=2;
          widget.onChange();
          isLoading=false;
        });
        getAttendants();
      } else {
        setState(() {
          isLoading=false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      MySnackBar.showSnackBar(context, 'Error' + 'Check Your Internet Connection');
    }
  }

  String getFormattedDate(String str){
    if(str.isEmpty){
      return '';
    }
    DateTime dt = DateTime.parse(str);
    var formatter = new DateFormat('dd MMM yyyy hh:mm a');
    return formatter.format(dt);
  }
}
