
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Workout/StatFragment.dart';
import 'package:us_rowing/views/AthleteView/Workout/WorkoutFragment.dart';

class AthWorkoutView extends StatefulWidget {

  final bool isBack;

  AthWorkoutView({this.isBack=true});


  @override
  _AthWorkoutViewState createState() => _AthWorkoutViewState();
}

class _AthWorkoutViewState extends State<AthWorkoutView> {


  @override
  void initState() {
    super.initState();
    // connectToSocket('', widget.userId);
  }

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorBackgroundLight,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(
              backgroundColor: colorWhite,
              title: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isBack?
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorWhite,
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ):
                    SizedBox(width: 24,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(IMG_WORKOUT,height: 16,width: 16,color: colorBlack,),
                        SizedBox(width: 10,),
                        Text('Workout',style: TextStyle(fontSize: 18,color: colorBlack),),
                      ],
                    ),
                    SizedBox(height: 24,width: 24,)
                  ], ),
              ),
              leading: null,
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: colorGrey,
                labelColor: colorPrimary,
                unselectedLabelStyle: TextStyle(color: colorGrey,fontSize: 14),
                labelStyle: TextStyle(color: colorPrimary,fontSize: 14),
                indicatorColor: colorPrimary,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/tab_background.png'),fit: BoxFit.fill),
                ),
                tabs: [
                  Tab(
                    text: 'Statistics',

                  ),
                  Tab(
                    text: 'Workouts',
                    // icon: Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Text('Workouts',style: TextStyle(color: colorWhite),),
                    // ),
                  ),
                ],
                isScrollable: false,
              ),

            ),
          ),
        ),
        body: TabBarView(
          children: [
            StatFragment(),
            WorkoutFragment(),
          ],
        ),
      ),
    );
  }

}
