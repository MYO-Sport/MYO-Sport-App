import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';

class NotificationsViewCoach extends StatefulWidget {
  const NotificationsViewCoach({Key? key}) : super(key: key);

  @override
  _NotificationsViewCoachState createState() =>
      _NotificationsViewCoachState();
}

class _NotificationsViewCoachState extends State<NotificationsViewCoach> {
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
                  'NOTIFICATIONS',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 22.0,
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


          ],
        ),
      ),
    );
  }
}
