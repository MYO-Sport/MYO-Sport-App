import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AthleteView/Club/ClubView.dart';
import 'package:us_rowing/views/CoachView/fragments/CoachWorkoutFragment.dart';
import 'package:us_rowing/views/UsFeed/UsFeedDetails.dart';
import 'package:us_rowing/widgets/CoachDrawerWidget.dart';

import 'EventViewCoach/EventViewDetails.dart';

class CoachHomeView extends StatefulWidget {
  final UserModel userModel;

  CoachHomeView({required this.userModel});

  @override
  _CoachHomeViewState createState() => _CoachHomeViewState();
}

class _CoachHomeViewState extends State<CoachHomeView>
    with SingleTickerProviderStateMixin {
  var selectedItem = 0;
  late UserModel user;

  List children = [];

  @override
  void initState() {
    super.initState();
    user = widget.userModel;
    children = [
      UsFeedDetails(userId: user.sId,),
      CoachWorkoutFragment(isBack: false),
      EventViewDetails(userId:user.sId),
      ClubView(isBack: false,),
      CoachDrawerWidget(userId: widget.userModel.sId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      body: children[selectedItem],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorWhite,
          selectedItemColor: colorPrimary,
          unselectedItemColor: colorGrey,
          unselectedFontSize: 0,
          iconSize: 0.0,
          // iconSize: 27.0
          currentIndex: selectedItem,
          onTap: (currIndex) {
            setState(() {
              selectedItem = currIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon:
              selectedItem != 0?ImageIcon(
                AssetImage(IMG_HOMEiCON),
                size: 20,
              ):SizedBox(),
              label: selectedItem == 0?'Home':'',
            ),
            BottomNavigationBarItem(
              icon: selectedItem != 1?ImageIcon(
                AssetImage(IMG_WORKoUTiCON),
                size: 20,
              ):SizedBox(),
              label: selectedItem == 1?'Workout':'',
            ),
            BottomNavigationBarItem(
              icon: selectedItem != 2?ImageIcon(
                AssetImage(IMG_EVENTS),
                size: 20,
              ):SizedBox(),
              label: selectedItem == 2?'My Events':'',
            ),
            BottomNavigationBarItem(
              icon: selectedItem != 3?ImageIcon(
                AssetImage(IMG_CLUBiCON,),
                size: 20,
              ):SizedBox(),
              label: selectedItem == 3?'Clubs':'',
            ),
            BottomNavigationBarItem(
              icon: selectedItem != 4?ImageIcon(
                AssetImage(IMG_MENU_MAIN),
                size: 20,
              ):SizedBox(),
              label: selectedItem == 4?'Menu':'',
            ),
          ],
        ),
      ),
    );
  }
}
