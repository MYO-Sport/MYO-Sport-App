import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/ChatWidget.dart';

class MyClubChat extends StatefulWidget {
  final String coachName;
  final String coachImage;
  MyClubChat({this.coachName='',this.coachImage=''});
  @override
  _MyClubChatState createState() => _MyClubChatState();
}

class _MyClubChatState extends State<MyClubChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorLightGrey,
        body: ListView.builder(
            itemBuilder: (context,index){
              return ChatWidget(name: 'Salena Gomez',image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Heidi_Klum_by_Glenn_Francis.jpg/1200px-Heidi_Klum_by_Glenn_Francis.jpg');
            })
    );
  }
}
