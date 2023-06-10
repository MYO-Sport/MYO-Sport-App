
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/ActivityModel.dart';
import 'package:us_rowing/models/HistoryModel.dart';
import 'package:us_rowing/utils/AppColors.dart';

import 'Expandable.dart';

class ActivityWidget extends StatefulWidget{

  final HistoryModel historyModel;

  ActivityWidget({required this.historyModel});

  @override
  State<StatefulWidget> createState() => _StateMyHistoryWidget();
}

class _StateMyHistoryWidget extends State<ActivityWidget>{

  List<ActivityModel> activities=[];

  ExpandableController _controller=ExpandableController(initialExpanded: false);

  @override
  void initState() {
    super.initState();
    activities=widget.historyModel.activities;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: colorPrimary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.0)),
        child: ExpandablePanel(
          controller: _controller,
          header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          getFormattedDate(),
                          style:
                          TextStyle(color: colorBlack, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      decoration: BoxDecoration(
                        color: colorWhite.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(widget.historyModel.type=='myo'?'Added Manually':widget.historyModel.type,)),

                ],
              )
          ),
          collapsed: SizedBox(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              activities.length==0?
              Container(
                height: 50,
                child: Center(
                  child: Text('No Activity Found',style: TextStyle(color: colorGrey,fontSize: 12),),
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
                          Text('${activity.value.toString()}  ${activity.unit}',style: TextStyle(color: colorBlack,fontWeight: FontWeight.bold),),
                        ],
                      ),);
                  }),

            ],
          ),
        ),
      ),
    );
  }

  String getFormattedDate(){
    String mDate='';
    try{
      var formatter = new DateFormat('dd MMMM yyyy');
      DateTime dateTime=DateTime.parse(widget.historyModel.date).toLocal();
      mDate=formatter.format(dateTime);
    }catch(e){
      mDate='';
    }
    return mDate;
  }

}