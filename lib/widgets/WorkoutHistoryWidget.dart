import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/HistoryModel.dart';
import 'package:us_rowing/models/RecentWorkoutModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/HistoryResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:us_rowing/widgets/ActivityWidget.dart';

import 'CachedImage.dart';
import 'Expandable.dart';

class WorkoutHistoryWidget extends StatefulWidget{

  final RecentWorkoutModel workout;
  final String days;
  final DateTime now;
  final DateTime startDate;
  final DateTime endDate;
  final String userId;

  WorkoutHistoryWidget({required this.workout,required this.now,required this.days,required this.startDate,required this.endDate,required this.userId});

  @override
  State<StatefulWidget> createState() => _StateMyHistoryWidget();
}

class _StateMyHistoryWidget extends State<WorkoutHistoryWidget>{

  bool isLoading = true;
  List<HistoryModel> histories=[];

  List<_SalesData> data = [];

  var formatter = new DateFormat('dd');

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
                    placeHolder: WORKOUT_PLACEHOLDER,
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
              isLoading?
              Container(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):
              histories.length==0?
              Container(
                height: 50,
                child: Center(
                  child: Text('No Data Found',style: TextStyle(color: colorGrey,fontSize: 12),),
                ),
              ):
              Column(
                children: [
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: widget.workout.workoutName+' Summary'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SalesData, String>>[
                        LineSeries<_SalesData, String>(
                          dataSource: data,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Distance(km)',
                          // Enable data label
                          // dataLabelSettings: DataLabelSettings(isVisible: true)
                        ),
                      ]),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: histories.length,
                      itemBuilder: (context,index){
                        HistoryModel history=histories[index];
                        if(history.activities.length==0)
                          return SizedBox();
                        return ActivityWidget(historyModel: history);

                      })
                ],
              ),

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
    String apiUrl = ApiClient.urlGetWorkoutsActivities;

    DateTime selectedStartDate=widget.startDate;
    DateTime selectedEndDate=widget.endDate;

    String strStartDate='${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}';
    String strEndDate='${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}';

    print('url: '+apiUrl);
    print('workoutName: '+widget.workout.workoutName);
    print('startDate: $strStartDate');
    print('endDate: $strEndDate');
    print('userId: ${widget.userId}');

    final response = await http
        .post(Uri.parse(apiUrl),body: {'workout_name': widget.workout.workoutName,'start_date':strStartDate,'end_date':strEndDate,'user_id': widget.userId})
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
      HistoryResponse mResponse =
      HistoryResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        List<_SalesData> _salesData=[];
        for(HistoryModel history in mResponse.wrokoutDetails){
          DateTime dateTime=DateTime.parse(history.date).toLocal();
          String string=formatter.format(dateTime);
          double day;
          try{
            day=double.parse(history.distance);
          }catch(e){
            day=0;
          }

          _salesData.add(_SalesData(string,day));
        }
        setState(() {
          data.addAll(_salesData);
          histories=mResponse.wrokoutDetails;
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

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}