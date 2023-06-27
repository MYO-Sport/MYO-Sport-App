import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/screens/slack_screen.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/views/AthleteView/NotificationView.dart';
import 'package:us_rowing/views/CoachView/CoachProfileView.dart';
import 'package:us_rowing/views/CoachView/LiveFeedDetails.dart';
import 'package:us_rowing/views/CoachView/fragments/CoachChatViewFragment.dart';
import 'package:us_rowing/views/FeedBackView.dart';
import 'package:us_rowing/views/Reservation/ClubResView.dart';
import 'package:us_rowing/views/SponsorsView.dart';
import 'package:us_rowing/views/FAQView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/DrawerWidget.dart';

class AthleteDrawerWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _StateAthleteDrawerWidget();

}

class _StateAthleteDrawerWidget extends State<AthleteDrawerWidget>{

  String? userName;
  late String userImage;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
       userName=value.username;
       userImage=value.profileImage;
       userEmail=value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (Widget child, Animation<double> animation) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation,
          child: child, );
      },
      duration: const Duration(milliseconds: 800),
      child: Container(
        color: colorWhite,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 60.0,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CachedImage(image:userName==null?'':ApiClient.baseUrl+userImage,imageHeight: 60,imageWidth: 60,padding: 0,),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userName==null?'':userName!,style: TextStyle(color: colorBlack,fontSize: 19),),
                      SizedBox(height: 5,),
                      Text(userEmail==null?'':userEmail!,style: TextStyle(color: colorTextSecondary,fontSize: 14),)
                    ],
                  ))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(thickness: 2,height: 0,),
            ),
            Expanded(child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerWidget(
                  icon:imgNavProfile,
                  name: 'Profile',
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoachProfileView()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavChat,
                  name: 'Chat',
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoachChatViewFragment(workoutImage: '',)));
                  },
                ),
                DrawerWidget(
                  icon: imgNavLive,
                  name: 'Live Feeds',
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LiveFeedDetails()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavNotification,
                  name: 'Notifications',
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.
                    push(context, MaterialPageRoute(builder: (context) => NotificationView()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavSponsors,
                  name: 'Sponsors',
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.
                    push(context, MaterialPageRoute(builder: (context) => SponsorsView()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavStore,
                  name: 'Store',
                  onTap: () {
                    Navigator.
                    push(context, MaterialPageRoute(builder: (context) => SlackScreen()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavChallenges,
                  name: 'Challenges',
                  onTap: () {
                    

                  },
                ),
                DrawerWidget(
                  icon: imgNavEquipment,
                  name: 'Equipment Reservations',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClubResView(allClubs: false,)));
                  },
                ),
                DrawerWidget(
                  icon: imgNavFAQ,
                  name: 'FAQ',
                  onTap: () {
                    // tod
                    // Navigator.pop(context);
                    Navigator.
                    push(context, MaterialPageRoute(builder: (context) => FAQView()));
                  },
                ),
                DrawerWidget(
                  icon: imgNavFeedBack,
                  name: 'Feedback',
                  onTap: () {
                    // tod
                    // Navigator.pop(context);
                    Navigator.
                    push(context, MaterialPageRoute(builder: (context) => FeedbackView()));
                  },
                ),
                /*DrawerWidget(name: 'Saved', icon: IMG_PROFIE_DRAWER, onTap: () {
              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SavedView()));
            },),*/
                DrawerWidget(
                  icon: imgNavLogout,
                  name: 'Logout',
                  onTap: () {
                    // Navigator.of(context).pop();
                    logout(context);
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
