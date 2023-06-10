import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/ChatWidget.dart';

class ChatViewCoach extends StatefulWidget {
  final String coachName;
  final String coachImage;

  ChatViewCoach({this.coachName = '', this.coachImage = ''});

  @override
  _ChatViewCoachState createState() => _ChatViewCoachState();
}

class _ChatViewCoachState extends State<ChatViewCoach> {
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
              padding:
              EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
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
                    'CHAT VIEW',
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 20.0,
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
        body: ListView.builder(itemBuilder: (context, index) {
          return ChatWidget(
              name: 'HEIDI KLUM',
              image:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Heidi_Klum_by_Glenn_Francis.jpg/1200px-Heidi_Klum_by_Glenn_Francis.jpg');
        }));
  }
}
