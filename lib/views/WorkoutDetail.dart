import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ActivityModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ActivitiesResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CoachView/fragments/CoachChatViewFragment.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;

class WorkoutDetail extends StatefulWidget {

  final bool isBack;
  final String workoutId;
  final String workoutName;
  final bool share;
  final String imgUrl;

  WorkoutDetail({this.isBack = true,required this.workoutId, required this.workoutName,this.share=false, required this.imgUrl});


  @override
  _WorkoutDetailState createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {

  bool isLoading=true;
  List<ActivityModel> activities=[];


  @override
  void initState() {
    super.initState();
    print('imageUrl: '+widget.imgUrl);
    getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: colorPrimary,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isBack ? InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: colorWhite,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ) : SizedBox(width: 24,),
                  Text(
                    'WORKOUT',
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0),
                  ),
                  widget.share ? InkWell(
                    child: Icon(
                      Icons.share,
                      color: colorWhite,
                    ),
                    onTap: () {
                      activeShare().then((value){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CoachChatViewFragment(share: true,workoutId: widget.workoutId,workoutName: widget.workoutName,workoutImage: widget.imgUrl,)));
                      });
                    },
                  ) : SizedBox(width: 24,),
                ],
              ),
            ),
          ),
        ),
        body:
        SingleChildScrollView(
          child: Column(

            children: <Widget>[
              SizedBox(height: 20.0,),
              CachedImage(
                image: ApiClient.baseUrl+widget.imgUrl,
                imageHeight: MediaQuery.of(context).size.width*0.5,
                imageWidth: MediaQuery.of(context).size.width*0.8,
              ),
              SizedBox(height: 20.0,),
              Text(widget.workoutName,style: TextStyle(color: colorBlack,fontSize: 20),),
              SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Card(
                  borderOnForeground: true,
                  elevation: 5.0,
                  color: colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Material(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2.0,
                        child: Container(
                          height: 50.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Workout Activities',
                                  style: TextStyle(color: colorGrey),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 55.0,
                                  color: colorBlack.withOpacity(0.6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      isLoading?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: CircularProgressIndicator(),
                      ):
                      activities.length==0?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22.0),
                        child: Text('No Workout Activities',style: TextStyle(color: colorGrey),),
                      ):
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: activities.length,
                          itemBuilder: (context,index){
                            ActivityModel activity=activities[index];
                            return Padding(padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(activity.activityName),
                                Text(activity.value.toString(),style: TextStyle(color: colorBlack,fontWeight: FontWeight.bold),),
                              ],
                            ),);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  getActivities() async {
    print('workoutId: '+widget.workoutId);
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetWorkoutActivities;

    final response = await http
        .post(Uri.parse(apiUrl),body: {'workout_id': widget.workoutId})
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
      ActivitiesResponse mResponse =
      ActivitiesResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          activities=mResponse.wrokoutDetails;
          isLoading=false;
        });
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
}
