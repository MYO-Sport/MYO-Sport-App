
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Workout/AddWorkout.dart';

import 'WorkoutHistory.dart';

class WorkoutFragment extends StatefulWidget {



  @override
  _WorkoutFragmentState createState() => _WorkoutFragmentState();
}

class _WorkoutFragmentState extends State<WorkoutFragment> {


  @override
  void initState() {
    super.initState();
    // connectToSocket('', widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: colorBackgroundLight,
          appBar: AppBar(
            backgroundColor: colorWhite,
            elevation: 0,
            title: TabBar(
              tabs: [
                Tab(
                  icon: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Workouts',
                      style: TextStyle(color: colorBlack),
                    ),
                  ),
                ),
                Tab(
                  icon: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'History',
                      style: TextStyle(color: colorBlack),
                    ),
                  ),
                ),
              ],
              isScrollable: false,
            ),
          ),
          body: TabBarView(
            children: [
              AddWorkout(),
              WorkoutHistory(),
            ],
          ),
        ),
      ),
    );
  }

}
