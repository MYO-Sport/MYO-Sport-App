import 'package:flutter/material.dart';
import 'package:us_rowing/widgets/ChatWidget.dart';

class MyCoachChat extends StatefulWidget {
  final String coachName;
  final String coachImage;
  MyCoachChat({this.coachName='',this.coachImage=''});
  @override
  _MyCoachChatState createState() => _MyCoachChatState();
}

class _MyCoachChatState extends State<MyCoachChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context,index){
            return ChatWidget(name: 'HEIDI KLUM',image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Heidi_Klum_by_Glenn_Francis.jpg/1200px-Heidi_Klum_by_Glenn_Francis.jpg');
          })
    );
  }
}
