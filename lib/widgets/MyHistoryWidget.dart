import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:us_rowing/models/ActivityModel.dart';
import 'package:us_rowing/models/RecentWorkoutModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/ActivitiesResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'CachedImage.dart';
import 'Expandable.dart';

class MyHistoryWidget extends StatefulWidget{

  final RecentWorkoutModel workout;
  final String days;
  final DateTime now;

  MyHistoryWidget({required this.workout,required this.now,required this.days});

  @override
  State<StatefulWidget> createState() => _StateMyHistoryWidget();
}

class _StateMyHistoryWidget extends State<MyHistoryWidget>{

  bool isLoading = true;
  List<ActivityModel> activities=[];

  List<_SalesData> data = [
    _SalesData('12 Mar', 35,40),
    _SalesData('13 Mar', 28,20),
    _SalesData('14 Mar', 34,10),
    _SalesData('15 Mar', 32,0),
    _SalesData('16 Mar', 40,12)
  ];

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(8.0)),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CachedImage(
                  image:
                  ApiClient.baseUrl+widget.workout.workoutImage,
                  imageHeight: 47.0,
                  radius: 6,
                  imageWidth: 47,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.workout.workoutName,
                        style:
                        TextStyle(color: colorBlack, fontSize: 14),
                      ),
                      Text(
                        getTime(),
                        style:
                        TextStyle(color: colorTextSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ),
          collapsed: SizedBox(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Workout Details'),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        decoration: BoxDecoration(
                          color: colorGrey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(widget.workout.type=='myo'?'Added Manually':widget.workout.type,)),
                  ],
                ),

              ),
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Indoor Summary'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Distance',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.timeSpend,
                        name: 'Time',
                        color: colorGreen,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
              isLoading?
                  Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):
              activities.length==0?
              Container(
                height: 50,
                child: Center(
                  child: Text('No Data Found',style: TextStyle(color: colorGrey,fontSize: 12),),
                ),
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
    );
  }

  getActivities() async {

    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetWorkoutActivities;

    print('url: '+apiUrl);
    print('workoutId: '+widget.workout.sId);

    final response = await http
        .post(Uri.parse(apiUrl),body: {'workout_id': widget.workout.sId})
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      showToast( 'Error: ' + 'Check Your Internet Connection');
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

  String getTime(){
    DateTime time=DateTime.parse(widget.days);
    int i=widget.now.difference(time).inDays;
    if(i==0){
      return 'today';
    }
    if(i==1){
      return '1 day ago';
    }
    if(i>1){
      return '$i days ago';
    }

    return '';
  }

}

class _SalesData {
  _SalesData(this.year, this.sales,this.timeSpend);

  final String year;
  final double sales;
  final double timeSpend;
}