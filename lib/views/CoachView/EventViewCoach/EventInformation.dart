import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/CoachView/EventViewCoach/AthleteEventInformation.dart';

class EventInformation extends StatefulWidget {
  @override
  _EventInformationState createState() => _EventInformationState();
}

class _EventInformationState extends State<EventInformation> {
  bool status = false;

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
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'EVENT DEATILS',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite.withOpacity(0),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Text(
                    'Event Info',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Joined Athletes',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  ),
                  Text(
                    '27',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  )
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Event Name',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  ),
                  Text(
                    '',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  )
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Date',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Image.asset(IMG_DROPDOWNBUTTON),
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Time',
                    style: TextStyle(color: colorGrey, fontSize: 15),
                  ),
                  SizedBox(
                    width: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 20.0,
                        height: 20.0,
                        child: Image.asset(IMG_DROPDOWNBUTTON),
                      ),
                    ],
                  ),
                  Text(
                    'Time TBD',
                    style: TextStyle(color: colorGrey, fontSize: 12),
                  ),
                  FlutterSwitch(
                    width: 55.0,
                    height: 25.0,
                    valueFontSize: 8.0,
                    inactiveColor: colorWhite,
                    activeColor: colorBlue,
                    toggleColor: status ? colorWhite : colorBlue,
                    inactiveTextColor: colorBlue,
                    toggleSize: 15.0,
                    inactiveSwitchBorder: Border.all(color: colorGrey),
                    value: status,
                    borderRadius: 25.0,
                    padding: 5.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Zone',
                        style: TextStyle(color: colorGrey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '(GMT+05:00)Asia/Karachi',
                        style: TextStyle(color: colorBlack, fontSize: 13),
                      ),
                    ],
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Image.asset(IMG_DROPDOWNBUTTON),
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Repeats',
                        style: TextStyle(color: colorGrey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '(GMT+05:00)Asia/Karachi',
                        style: TextStyle(color: colorBlack, fontSize: 13),
                      ),
                    ],
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Image.asset(IMG_DROPDOWNBUTTON),
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Location',
                    style: TextStyle(
                        color: colorGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Image.asset(IMG_DROPDOWNBUTTON),
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Location Details',
                    style: TextStyle(
                        color: colorGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                        color: colorGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: colorBlue,
                      size: 30.0,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AthleteEventInformation(eventId: '',)));
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: colorGrey,
            ),
          ],
        ),
      ),
    );
  }
}
