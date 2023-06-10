import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/EventAttendantModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/AttendantsResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/AthleteWidget.dart';
import 'package:http/http.dart' as http;

class AthleteEventInformation extends StatefulWidget {

  final String eventId;

  AthleteEventInformation({required this.eventId});

  @override
  _AthleteEventInformationState createState() =>
      _AthleteEventInformationState();
}

class _AthleteEventInformationState extends State<AthleteEventInformation> {

  bool isLoading=true;
  List<EventAttendantModel> attendants=[];

  late String userId;

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        userId=value.sId;
      });
      getAttendants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
              backgroundColor: colorPrimary,
              leading: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text('EVENT DETAILS'),
              ),
              centerTitle: true,
              actions: <Widget>[
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 33.0),
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: colorGrey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attending Athletes',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    Container(
                      width: 20.0,
                      height: 20.0,
                      child: Image.asset(IMG_DROPDOWNBUTTON),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child:
            isLoading?
            Center(child: CircularProgressIndicator(),):
            attendants.length==0?
            Center(child: Text('No Attendants Found')):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: attendants.length,
                padding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  EventAttendantModel athlete=attendants[index];
                  return AthleteWidget(name: athlete.userName,image: athlete.userProfileImage,email: athlete.userEmail,id: athlete.sId,userId: userId,);
                },

              ),
            ),
          ),
        ],
      ),
    );
  }

  getAttendants() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetAttendants;

    print('eventId: '+widget.eventId);

    final response = await http.post(Uri.parse(apiUrl),
        body: {'event_id': widget.eventId,}).catchError((value) {
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
      AttendantsResponse mResponse =
      AttendantsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          attendants=mResponse.attendents;
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
